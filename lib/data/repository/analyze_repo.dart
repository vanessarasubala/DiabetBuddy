import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gluecose_monitor/data/datasource/remote/dio/dio_client.dart';
import 'package:gluecose_monitor/data/datasource/remote/exception/api_error_handler.dart';
import 'package:gluecose_monitor/data/model/response/base/api_response.dart';
import 'package:gluecose_monitor/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnalyzeRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AnalyzeRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getAnalize({int gluecoseId}) async {
    try {
      Response response = await dioClient.get(
        '${AppConstants.ANALYZE}',
        queryParameters: {'gluecose_id': gluecoseId},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }
}
