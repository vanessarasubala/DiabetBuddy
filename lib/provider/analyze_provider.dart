import 'package:flutter/foundation.dart';
import 'package:gluecose_monitor/data/model/response/base/api_response.dart';
import 'package:gluecose_monitor/data/repository/analyze_repo.dart';

class AnalyzeProvider extends ChangeNotifier {
  final AnalyzeRepo analyzeRepo;
  AnalyzeProvider({@required this.analyzeRepo});

  bool _isloading = false;
  String _gluecoseStatus;
  String _colorStatus;
  List _reason = [''];
  List _guide = [''];

  bool get isLoading => _isloading;
  String get gluecoseStatus => _gluecoseStatus;
  String get colorStatus => _colorStatus;
  List get reason => _reason;
  List get guide => _guide;

  Future<void> getAnalyze({@required int gluecoseId}) async {
    _isloading = true;
    _gluecoseStatus = '';
    _colorStatus = '';
    _reason = [''];
    _guide = [''];
    ApiResponse apiResponse =
        await analyzeRepo.getAnalize(gluecoseId: gluecoseId);
    if (apiResponse.response.data['success']) {
      final data = apiResponse.response.data['data'];
      _gluecoseStatus = data['gleucose_status'];
      _colorStatus = data['status_color'];
      _reason = [];
      _guide = [];
      data['result']['reason'].forEach((val) => _reason.add(val));
      data['result']['guide'].forEach((val) => _guide.add(val));
      print(_gluecoseStatus);
      _isloading = false;
      notifyListeners();
    }
    _isloading = false;
    notifyListeners();
  }
}
