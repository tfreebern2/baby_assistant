import 'package:baby_assistant/model/ate_activity.dart';
import 'package:baby_assistant/model/change_activity.dart';
import 'package:baby_assistant/model/drink_activity.dart';
import 'package:baby_assistant/model/nap_activity.dart';

class Routine {
  int _id;
  DateTime _date;
  AteActivity _ateStatusId;
  DrinkActivity _drinkStatusId;
  NapActivity _napStatusId;
  ChangeActivity _changeStatusId;

  Routine(this._id, this._date, this._ateStatusId, this._drinkStatusId,
      this._napStatusId, this._changeStatusId);

  Routine.map(dynamic obj) {
    this._date = obj["date"];
    this._ateStatusId = obj["ateStatus"];
    this._drinkStatusId = obj["drinkStatus"];
    this._napStatusId = obj["napStatus"];
    this._changeStatusId = obj["changeStatus"];
    this._id = obj["id"];
  }

  // Getters
  DateTime get date => _date;

  AteActivity get ateStatus => _ateStatusId;

  DrinkActivity get drinkStatus => _drinkStatusId;

  NapActivity get napStatus => _napStatusId;

  ChangeActivity get changeStatus => _changeStatusId;

  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["date"] = _date;
    map["ate_status_id"] = _ateStatusId;
    map["drink_status_id"] = _drinkStatusId;
    map["nap_status_id"] = _napStatusId;
    map["change_status_id"] = _changeStatusId;

    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  Routine.fromMap(Map<String, dynamic> map) {
    this._date = map["date"];
    this._ateStatusId = map["ate_status_id"];
    this._drinkStatusId = map["drink_status_id"];
    this._napStatusId = map["nap_status_id"];
    this._changeStatusId = map["change_status_id"];
    this._id = map["id"];
  }
}
