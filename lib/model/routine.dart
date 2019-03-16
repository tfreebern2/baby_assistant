class Routine {
  int _id;
  int _childId;
  String _date;
  int _ateActivityId;
  int _drinkActivityId;
  int _napActivityId;
  int _changeActivityId;

  Routine(this._childId, this._date, this._ateActivityId, this._drinkActivityId,
      this._napActivityId, this._changeActivityId);

  Routine.map(dynamic obj) {
    this._childId = obj["child_id"];
    this._date = obj["date"];
    this._ateActivityId = obj["ate_activity_id"];
    this._drinkActivityId = obj["drink_activity_id"];
    this._napActivityId = obj["nap_activity_id"];
    this._changeActivityId = obj["change_activity_id"];

    this._id = obj["id"];
  }

  // Getters
  int get childId => _childId;
  String get date => _date;
  int get ateActivityId => _ateActivityId;
  int get drinkActivityId => _drinkActivityId;
  int get napActivityId => _napActivityId;
  int get changeActivityId => _changeActivityId;

  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["child_id"] = _childId;
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
    this._childId = map["child_id"];
    this._date = map["date"];
    this._ateActivityId = map["ate_activity_id"];
    this._drinkActivityId = map["drink_activity_id"];
    this._napActivityId = map["nap_activity_id"];
    this._changeActivityId = map["change_activity_id"];
    this._id = map["id"];
  }
}
