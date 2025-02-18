class AreaData {
  bool? success;
  List<Area>? area;

  AreaData({this.success, this.area});

  AreaData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      area = <Area>[];
      json['data'].forEach((v) {
        area!.add(Area.fromJson(v));
      });
    }
  }


}

class Area {
  String? id;
  String? stateId;
  int? status;
  bool? active;
  String? name;

  Area(
      {this.id,
        this.stateId,
        this.status,
        this.active,
        this.name});

  Area.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    stateId = json['state_id'].toString();
    status = json['status'];
    active = json['active'];
    name = json['name'];
  }

}

