import 'package:flutter/widgets.dart';
import 'package:gluecose_monitor/data/model/profile_model.dart';
import 'package:gluecose_monitor/data/model/response/base/api_response.dart';
import 'package:gluecose_monitor/data/model/response/response_model.dart';
import 'package:gluecose_monitor/data/repository/profile_repo.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepo profileRepo;

  ProfileProvider({@required this.profileRepo});

  bool _isLoading = false;
  ProfileModel _profileModel;

  bool get isLoading => _isLoading;
  ProfileModel get profileModel => _profileModel;

  Future<void> getProfile() async {
    _isLoading = true;
    _profileModel = null;
    ApiResponse apiResponse = await profileRepo.getProfile();
    if (apiResponse.response.data['success']) {
      _profileModel = ProfileModel.fromJson(apiResponse.response.data['data']);
      _isLoading = false;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<ResponseModel> create({@required Map<String, dynamic> data}) async {
    _isLoading = true;
    ResponseModel responseModel;
    ApiResponse apiResponse = await profileRepo.createProfile(data: data);
    if (apiResponse.response.data['success']) {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isLoading = false;
    } else {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isLoading = false;
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> update({@required Map<String, dynamic> data}) async {
    _isLoading = true;
    ResponseModel responseModel;
    ApiResponse apiResponse = await profileRepo.updateProfile(data: data);
    if (apiResponse.response.data['success']) {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isLoading = false;
    } else {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isLoading = false;
    }
    notifyListeners();
    return responseModel;
  }

  Future<bool> isProfile() async {
    _isLoading = true;
    ApiResponse apiResponse = await profileRepo.getProfile();
    if (apiResponse.response.statusCode == 200) {
      final status = apiResponse.response.data['success'];
      return status;
    } else {
      return false;
    }
  }
}
