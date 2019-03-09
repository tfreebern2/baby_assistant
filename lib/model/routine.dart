import 'package:baby_assistant/model/ate_status.dart';
import 'package:baby_assistant/model/change_status.dart';
import 'package:baby_assistant/model/drink_status.dart';
import 'package:baby_assistant/model/nap_status.dart';

class Routine {
  int _id;
  DateTime _date;
  AteStatus _ateStatus;
  DrinkStatus _drinkStatus;
  NapStatus _napStatus;
  ChangeStatus _changeStatus;

  Routine(this._id, this._date, this._ateStatus, this._drinkStatus,
      this._napStatus, this._changeStatus);

  Routine.map(dynamic obj) {
    this._date = obj["date"];
    this._ateStatus = obj["ateStatus"];
    this._drinkStatus = obj["drinkStatus"];
    this._napStatus = obj["napStatus"];
    this._changeStatus = obj["changeStatus"];
    this._id = obj["id"];
  }

  // Getters
  DateTime get date => _date;

  AteStatus get ateStatus => _ateStatus;

  DrinkStatus get drinkStatus => _drinkStatus;

  NapStatus get napStatus => _napStatus;

  ChangeStatus get changeStatus => _changeStatus;

  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["date"] = _date;
    map["ateStatus"] = _ateStatus;
    map["drinkStatus"] = _drinkStatus;
    map["napStatus"] = _napStatus;
    map["changeStatus"] = _changeStatus;

    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  Routine.fromMap(Map<String, dynamic> map) {
    this._date = map["date"];
    this._ateStatus = map["ateStatus"];
    this._drinkStatus = map["drinkStatus"];
    this._napStatus = map["napStatus"];
    this._changeStatus = map["changeStatus"];
    this._id = map["id"];
  }
}
