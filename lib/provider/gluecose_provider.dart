import 'package:flutter/foundation.dart';
import 'package:gluecose_monitor/data/model/gluecose_model.dart';
import 'package:gluecose_monitor/data/model/response/base/api_response.dart';
import 'package:gluecose_monitor/data/model/response/response_model.dart';
import 'package:gluecose_monitor/data/repository/gluecose_repo.dart';

class GluecoseProvider extends ChangeNotifier {
  final GluecoseRepo gluecoseRepo;
  GluecoseProvider({@required this.gluecoseRepo});

  bool _isLoading = false;
  List<GluecoseModel> _listHistory = [];

  bool get isLoading => _isLoading;
  List<GluecoseModel> get listHistory => _listHistory;

  Future<void> getHistory({String date}) async {
    _isLoading = true;
    ApiResponse apiResponse = await gluecoseRepo.getHistory(date: date);
    if (apiResponse.response.data['success']) {
      final data = apiResponse.response.data['data'];
      _listHistory = [];
      data.forEach(
        (value) => _listHistory.add(GluecoseModel.fromJson(value)),
      );
      _isLoading = false;
      debugPrint(_listHistory.toString());
    } else {
      _listHistory = [];
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<ResponseModel> createGluecose(
      {int id, Map<String, dynamic> data}) async {
    _isLoading = true;
    ResponseModel responseModel;
    ApiResponse apiResponse = await gluecoseRepo.createGluecose(data: data);
    if (apiResponse.response.data['success']) {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
    } else {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isLoading = false;
    }

    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> updateGluecose(
      {int id, Map<String, dynamic> data}) async {
    _isLoading = true;
    ResponseModel responseModel;
    ApiResponse apiResponse =
        await gluecoseRepo.updateGluecose(gluecoseId: id, data: data);
    if (apiResponse.response.data['success']) {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
    } else {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isLoading = false;
    }

    notifyListeners();
    return responseModel;
  }
}
