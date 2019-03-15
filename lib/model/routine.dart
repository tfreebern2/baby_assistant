class Routine {
  int _id;
  String _date;
  int _ateActivityId;
  int _drinkActivityId;
  int _napActivityId;
  int _changeActivityId;

  Routine(this._date, this._ateActivityId, this._drinkActivityId,
      this._napActivityId, this._changeActivityId);

  Routine.map(dynamic obj) {
    this._date = obj["date"];
    this._ateActivityId = obj["ateActivity"];
    this._drinkActivityId = obj["drinkActivity"];
    this._napActivityId = obj["napActivity"];
    this._changeActivityId = obj["changeActivity"];
    this._id = obj["id"];
  }

  // Getters
  String get date => _date;

  int get ateActivity => _ateActivityId;

  int get drinkActivity => _drinkActivityId;

  int get napActivity => _napActivityId;

  int get changeActivity => _changeActivityId;

  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["date"] = _date;
    map["ate_activity_id"] = _ateActivityId;
    map["drink_activity_id"] = _drinkActivityId;
    map["nap_activity_id"] = _napActivityId;
    map["change_activity_id"] = _changeActivityId;

    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  Routine.fromMap(Map<String, dynamic> map) {
    this._date = map["date"];
    this._ateActivityId = map["ate_activity_id"];
    this._drinkActivityId = map["drink_activity_id"];
    this._napActivityId = map["nap_activity_id"];
    this._changeActivityId = map["change_activity_id"];
    this._id = map["id"];
  }
}
