class ProfileModel {
  int _id;
  String _fullname;
  String _phoneNumber;
  String _email;
  String _gender;
  String _dateOfBirth;
  int _age;
  int _ageRangeId;
  int _weight;
  int _height;
  int _diabetesTypeId;
  String _gluecoseResult;
  String _diabetesType;
  String _isStress;
  String _isSmoke;

  ProfileModel(
    int id,
    String fullname,
    String phoneNumber,
    String email,
    String gender,
    String dateOfBirth,
    int age,
    int ageRangeId,
    int weight,
    int height,
    int diabetesTypeId,
    String gluecoseResult,
    String diabetesType,
    String isStress,
    String isSmoke,
  ) {
    this._id = id;
    this._fullname = fullname;
    this._phoneNumber = phoneNumber;
    this._email = email;
    this._gender = gender;
    this._dateOfBirth = dateOfBirth;
    this._age = age;
    this._ageRangeId = ageRangeId;
    this._weight = weight;
    this._height = height;
    this._diabetesTypeId = diabetesTypeId;
    this._gluecoseResult = gluecoseResult;
    this._diabetesType = diabetesType;
    this._isStress = isStress;
    this._isSmoke = isSmoke;
  }

  int get id => _id;
  String get fullname => _fullname;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
  String get gender => _gender;
  String get dateOfBirth => _dateOfBirth;
  int get age => _age;
  int get ageRangeId => _ageRangeId;
  int get weight => _weight;
  int get height => _height;
  int get diabetesTypeId => _diabetesTypeId;
  String get gluecoseResult => _gluecoseResult;
  String get diabetesType => _diabetesType;
  String get isStress => _isStress;
  String get isSmoke => _isSmoke;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fullname = json['fullname'];
    _phoneNumber = json['phone_number'];
    _email = json['email'];
    _gender = json['gender'];
    _dateOfBirth = json['date_of_birth'];
    _age = json['age'];
    _ageRangeId = json['age_range_id'];
    _weight = json['weight'];
    _height = json['height'];
    _diabetesTypeId = json['diabetes_type_id'];
    _gluecoseResult = json['gluecose_result'].toString();
    _diabetesType = json['diabetes_type'];
    _isStress = json['isStress'];
    _isSmoke = json['isSmoke'];
  }
}
