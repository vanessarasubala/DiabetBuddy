import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gluecose_monitor/data/datasource/remote/dio/dio_client.dart';
import 'package:gluecose_monitor/data/datasource/remote/exception/api_error_handler.dart';
import 'package:gluecose_monitor/data/model/response/base/api_response.dart';
import 'package:gluecose_monitor/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GulecoseMonitoringRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  GulecoseMonitoringRepo(
      {@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getGlucoseMonitoring({String date}) async {
    try {
      Response response = await dioClient.get(
        '${AppConstants.GLUECOSE_MONITORING}',
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
}
