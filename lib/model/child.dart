class Child {
  int _id;
  String _firstName;
  String _birthdate;

  Child(this._firstName, this._birthdate);

  Child.map(dynamic obj) {
    this._firstName = obj["first_name"];
    this._birthdate = obj["bithdate"];

    this._id = obj["id"];
  }

  // Getters
  String get dateOfBirth => _birthdate;
  String get firstName => _firstName;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["first_name"] = _firstName;
    map["birthdate"] = _birthdate;

    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  Child.fromMap(Map<String, dynamic> map) {
    this._firstName = map["first_name"];
    this._birthdate = map["birthdate"];
    this._id = map["id"];
  }
}
