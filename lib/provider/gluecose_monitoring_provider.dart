import 'package:flutter/widgets.dart';
import 'package:gluecose_monitor/data/model/gluecose_model.dart';
import 'package:gluecose_monitor/data/model/response/base/api_response.dart';
import 'package:gluecose_monitor/data/repository/gulecose_monitoring_repo.dart';

class GluecoseMonitoringProvider extends ChangeNotifier {
  final GulecoseMonitoringRepo gulecoseMonitoringRepo;

  GluecoseMonitoringProvider({@required this.gulecoseMonitoringRepo});

  bool _isLoading = false;
  List<dynamic> _data = [];
  List<String> _axis = [];
  GluecoseMonitorModel _gluecoseMonitorModel;
  List<GluecoseMonitorModel> _diagnosis;

  bool get isLoading => _isLoading;
  List<dynamic> get data => _data;
  List<String> get axis => _axis;
  GluecoseMonitorModel get gluecoseMonitorModel => _gluecoseMonitorModel;
  List<GluecoseMonitorModel> get diagnosis => _diagnosis;

  Future<void> getGluecoseMonitoring(
      {@required String date, String index}) async {
    _isLoading = true;
    _gluecoseMonitorModel = null;
    ApiResponse apiResponse =
        await gulecoseMonitoringRepo.getGlucoseMonitoring(date: date);
    if (apiResponse.response.data['success']) {
      final data = apiResponse.response.data['data'];
      final chart = data['chart'];
      _axis = [];
      _data = [];
      _diagnosis = [];

      chart['axis'].forEach(
        (value) => _axis.add(value),
      );
      chart['data'].forEach(
        (value) => _data.add(value),
      );

      List<dynamic> diagnosis = data['diagnosis'];
      if (index != null) {
        _gluecoseMonitorModel =
            new GluecoseMonitorModel.fromJson(diagnosis[int.parse(index)]);
      } else {
        _gluecoseMonitorModel =
            new GluecoseMonitorModel.fromJson(diagnosis.last);
      }

      data['diagnosis'].forEach(
        (value) => _diagnosis.add(GluecoseMonitorModel.fromJson(value)),
      );

      _isLoading = false;
    } else {
      _isLoading = false;
    }

    notifyListeners();
    return gluecoseMonitorModel;
  }
}
