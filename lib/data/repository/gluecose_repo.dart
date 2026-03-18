import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gluecose_monitor/data/datasource/remote/dio/dio_client.dart';
import 'package:gluecose_monitor/data/datasource/remote/exception/api_error_handler.dart';
import 'package:gluecose_monitor/data/model/response/base/api_response.dart';
import 'package:gluecose_monitor/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GluecoseRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  GluecoseRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getHistory({String date}) async {
    try {
      Response response = await dioClient.get(
        AppConstants.HISTORY,
        queryParameters: {
          'user_id': sharedPreferences.getString(AppConstants.ID_USER),
          'date': date,
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }

  Future<ApiResponse> createGluecose({Map<String, dynamic> data}) async {
    try {
      data['user_id'] = sharedPreferences.getString(AppConstants.ID_USER);
      print(data);
      Response response = await dioClient.post(
        '${AppConstants.GLUECOSE}/create',
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }

  Future<ApiResponse> updateGluecose(
      {Map<String, dynamic> data, int gluecoseId}) async {
    try {
      Response response = await dioClient.post(
        '${AppConstants.GLUECOSE}/update/${gluecoseId.toString()}',
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }
}
