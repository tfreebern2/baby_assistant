enum Unit { ounce }

const Map<Unit, String> unitsOfMeasurement = {Unit.ounce: 'ounce(s)'};

class AteActivity {
  AteActivity({this.date, this.startTime, this.endTime, this.amount, this.unit, this.type});

  // id
  int id;

  // date of eating
  DateTime date;

  // start of eating
  DateTime startTime;

  // end of eating
  DateTime endTime;

  // numerical amount eaten
  int amount;

  // unit of measurement
  Unit unit;

  // type of food
  String type;
}



