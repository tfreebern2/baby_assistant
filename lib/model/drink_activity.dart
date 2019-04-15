class DrinkActivity {

  DrinkActivity(this._date, this._startTime, this._endTime, this._description,
    this._amount, this._unit);

  int _id;
  int _routineId;
  String _date;
  String _startTime;
  String _endTime;
  String _description;
  String _amount;
  Unit _unit;

  DrinkActivity.map(dynamic obj) {
    this._date = obj["date"];
    this._startTime = obj["start_time"];
    this._endTime = obj["end_time"];
    this._description = obj["description"];
    this._amount = obj["amount"];
    this._unit = obj["unit"];

    this._routineId = obj["routineId"];
    this._id = obj["id"];
  }

  String get date => _date;
  String get startTime => _startTime;
  String get endTime => _endTime;
  String get description => _description;
  String get amount => _amount;
  Unit get unit => _unit;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["date"] = _date;
    map["start_time"] = _startTime;
    map["end_time"] =_endTime;
    map["description"] = _description;
    map["amount"] = _amount;
    map["unit"] = _unit;
    map["routineId"] = _routineId;

    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  DrinkActivity.fromMap(Map<String, dynamic> map) {
    this._date = map["date"];
    this._startTime = map["start_time"];
    this._endTime = map["end_time"];
    this._description = map["description"];
    this._amount = map["amount"];
    this._unit = map["unit"];
    this._routineId = map["routineId"];
    this._id = map["id"];
  }

}

enum Unit { ounce }

const Map<Unit, String> unitsOfMeasurement = {Unit.ounce: 'ounce(s)'};
