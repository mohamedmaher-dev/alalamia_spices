class AlalmiaBranches {
  final String? id, email, phone, lat, long, name, address, sections;
  AlalmiaBranches(
      {this.id,
        this.email,
        this.phone,
        this.lat,
        this.long,
        this.name,
        this.address,
        this.sections});
  factory AlalmiaBranches.fromJson(Map<String, dynamic> json) {
    return AlalmiaBranches(
      id: json["id"].toString(),
      email: json["email"],
      phone: json["phone"],
      lat: json["lat"].toString(),
      long: json["long"].toString(),
      name: json["name"],
      address: json["address"],
      sections: json["sections"],
    );
  }
}