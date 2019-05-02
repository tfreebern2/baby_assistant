class AteActivity {
  AteActivity(this._date, this._startTime, this._endTime, this._description,
      this._amount, this._childId);

  int _id;
  int _childId;
  String _date;
  String _startTime;
  String _endTime;
  String _description;
  String _amount;


  AteActivity.map(dynamic obj) {
    this._id = obj["id"];
    this._childId = obj["childId"];
    this._date = obj["date"];
    this._startTime = obj["start_time"];
    this._endTime = obj["end_time"];
    this._description = obj["description"];
    this._amount = obj["amount"];
  }

  // Getters
  int get id => _id;
  int get childId => _childId;
  String get date => _date;
  String get startTime => _startTime;
  String get endTime => _endTime;
  String get description => _description;
  String get amount => _amount;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (_id != null) {
      map["id"] = _id;
    }

    map["childId"] = _childId;
    map["date"] = _date;
    map["start_time"] = _startTime;
    map["end_time"] = _endTime;
    map["description"] = _description;
    map["amount"] = _amount;

    return map;
  }

  AteActivity.fromMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._childId = map["childId"];
    this._date = map["date"];
    this._startTime = map["start_time"];
    this._endTime = map["end_time"];
    this._description = map["description"];
    this._amount = map["amount"];
  }
}
