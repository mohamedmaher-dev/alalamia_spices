class UserLocations {
  String? id, name, desc, lat, long, areaId, phone;
  int? location;
  int? favorated;
  UserLocations(
      {this.id,
      this.name,
      this.desc,
      this.lat,
      this.long,
      this.areaId,
      this.phone,
      this.location,
      this.favorated});

  factory UserLocations.fromJson(Map<String, dynamic> json) {
    return UserLocations(
        id: json["id"].toString(),
        name: json["name"],
        desc: json["desc"],
        lat: json["lat"].toString(),
        long: json["long"].toString(),
        areaId: json["area_id"].toString(),
        phone: json["phone"].toString(),
        location: json["location"],
        favorated: json["favorated"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['desc'] = desc;
    data['lat'] = lat;
    data['long'] = long;
    data['area_id'] = areaId;
    data['phone'] = phone;
    data['location'] = location;
    data['favorated'] = favorated;
    return data;
  }
}
