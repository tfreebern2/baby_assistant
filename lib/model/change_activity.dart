class ChangeActivity {
  ChangeActivity(this._childId, this._date, this._startTime, this._endTime, this._description);

  int _id;
  int _childId;
  String _date;
  String _startTime;
  String _endTime;
  String _description;

  int get id => _id;
  int get childId => _childId;
  String get date => _date;
  String get startTime => _startTime;
  String get endTime => _endTime;
  String get description => _description;

  ChangeActivity.map(dynamic obj) {
    this._id = obj["id"];
    this._childId = obj["childId"];
    this._date = obj["date"];
    this._startTime = obj["startTime"];
    this._endTime = obj["endTime"];
    this._description = obj["description"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (_id != null) {
      map["id"] = _id;
    }

    map["childId"] = _childId;
    map["date"] = _date;
    map["startTime"] = _startTime;
    map["endTime"] = _endTime;
    map["description"] = _description;

    return map;
  }

  ChangeActivity.fromMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._childId = map["childId"];
    this._date = map["date"];
    this._startTime = map["startTime"];
    this._endTime = map["endTime"];
    this._description = map["description"];
  }
}
