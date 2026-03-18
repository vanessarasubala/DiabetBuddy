class GluecoseMonitorModel {
  int _gluecoseId;
  int _userId;
  String _checkingDate;
  int _gluecoseResult;
  String _checkingType;
  String _suggest;

  GluecoseMonitorModel(
    int gluecoseId,
    int userId,
    String checkingDate,
    int gluecoseResult,
    String checkingType,
    String suggest,
  ) {
    this._gluecoseId = gluecoseId;
    this._userId = userId;
    this._checkingDate = checkingType;
    this._gluecoseResult = gluecoseResult;
    this._checkingType = checkingType;
    this._suggest = suggest;
  }

  int get gluecoseId => _gluecoseId;
  int get userId => _userId;
  String get checkingDate => _checkingDate;
  int get gluecoseResult => _gluecoseResult;
  String get checkingType => _checkingType;
  String get suggest => _suggest;

  GluecoseMonitorModel.fromJson(Map<String, dynamic> json) {
    _gluecoseId = json['gluecose_id'];
    _userId = json['gluecose_id'];
    _checkingDate = json['checking_date'];
    _gluecoseResult = json['gluecose_result'];
    _checkingType = json['checking_type'];
    _suggest = json['suggest'];
  }
}

class GluecoseModel {
  int _id;
  int _userId;
  String _checkingDate;
  int _checkingTypeId;
  String _checkingType;
  String _checkingTime;
  int _sugarLevel;
  int _sleepDuration;
  int _sportTypeId;
  String _sportType;
  int _sportDuration;
  int _gluecoseResult;
  GluecoseModel(
    int id,
    int userId,
    String checkingDate,
    int checkingTypeId,
    String checkingType,
    String checkingTime,
    int sugarLevel,
    int sleepDuration,
    int sportTypeId,
    String sportType,
    int sportDuration,
    int gluecoseResult,
  ) {
    this._id = id;
    this._userId = userId;
    this._checkingDate = checkingDate;
    this._checkingTypeId = checkingTypeId;
    this._checkingType = checkingType;
    this._checkingTime = checkingTime;
    this._sugarLevel = sugarLevel;
    this._sleepDuration = sleepDuration;
    this._sportTypeId = sportTypeId;
    this._sportType = sportType;
    this._sportDuration = sportDuration;
    this._gluecoseResult = gluecoseResult;
  }

  int get id => _id;
  int get userId => _userId;
  String get checkingDate => _checkingDate;
  int get checkingTypeId => _checkingTypeId;
  String get checkingType => _checkingType;
  String get checkingTime => _checkingTime;
  int get sugarLevel => _sugarLevel;
  int get sleepDuration => _sleepDuration;
  int get sportTypeId => _sportTypeId;
  String get sportType => _sportType;
  int get sportDuration => _sportDuration;
  int get gluecoseResult => _gluecoseResult;

  GluecoseModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _checkingDate = json['checking_date'];
    _checkingTypeId = json['checking_type_id'];
    _checkingType = json['checking_type'];
    _checkingTime = json['checking_time'];
    _sugarLevel = json['sugar_level'];
    _sleepDuration = json['sleep_duration'];
    _sportTypeId = json['sport_type_id'];
    _sportType = json['sport_type'];
    _sportDuration = json['sport_duration'];
    _gluecoseResult = json['gluecose_result'];
  }
}
