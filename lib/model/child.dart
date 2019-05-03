class Child {
  Child(this._firstName);

  int _id;
  String _firstName;

  Child.map(dynamic obj) {
    this._id = obj["id"];
    this._firstName = obj["first_name"];
  }

  // Getters
  int get id => _id;
  String get firstName => _firstName;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (_id != null) {
      map["id"] = _id;
    }

    map["first_name"] = _firstName;

    return map;
  }

  Child.fromMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._firstName = map["first_name"];
  }
}
