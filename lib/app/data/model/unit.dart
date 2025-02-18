class UnitData {
  bool? success;
  List<Unit>? units;

  UnitData({this.success, this.units});

  UnitData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      units = <Unit>[];
      json['data'].forEach((v) {
        units!.add(  Unit.fromJson(v));
      });
    }
  }

}

class Unit {
  String? id;
  String? name;

  Unit({this.id, this.name});

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
  }

}

