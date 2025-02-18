
class SpecialOrder {
  String? name,
      desc,
      price,
      date,
      adminMessage,
      branchId,
      branchName,
      image,
      currency;
  int? id;
  int? status;
  Branch? branch;
  SpecialOrder(
      {this.id,
        this.name,
        this.desc,
        this.price,
        this.date,
        this.branchId,
        this.branchName,
        this.adminMessage,
        this.image,
        this.currency,
        this.status,
        this.branch
      });

  factory SpecialOrder.fromJson(Map<String, dynamic> json) {
    return SpecialOrder(
      id: json["id"],
      name: json["name"],
      desc: json["desc"],
      currency: json["currency"].toString(),
      price: json["price"],
      date: json["date"],
      adminMessage: json["admin_message"] ?? "",
      branchId: json["branch_id"].toString(),
      branchName: json["branch"]["name"],
      image:json["image_path"] ?? "",
      status:json["status"] ?? "",
      branch: json['branch'] != null ?  Branch.fromJson(json['branch']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   Map<String, dynamic>();
    data['name'] = name;
    data['desc'] = desc;
    data["date"] = date;
    data["branch_id"] = branchId;
    return data;
  }
}

class Branch {
  String? id;
  int? countryId;
  String? lat;
  String? long;
  String? email;
  String? areaId;
  String? phone;
  int? isApproved;
  bool? isFavorite;
  bool? isWorkingNow;
  int? isPharmacy;
  String? name;


  Branch({this.id,
    this.countryId,
    this.lat,
    this.long,
    this.email,
    this.areaId,
    this.phone,
    this.isApproved,
    this.isFavorite,
    this.isWorkingNow,
    this.isPharmacy,
    this.name,
  });

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    countryId = json['country_id'];
    lat = json['lat'];
    long = json['long'];
    email = json['email'];
    areaId = json['area_id'].toString();
    phone = json['phone'];
    isApproved = json['is_approved'];
    isFavorite = json['is_favorite'];
    isWorkingNow = json['is_working_now'];
    isPharmacy = json['is_pharmacy'];
    name = json['name'];
  }
}