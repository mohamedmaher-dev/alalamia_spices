class BranchesData {
  bool? success;
  List<Branches>? branches;

  BranchesData({this.success, this.branches});

  BranchesData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      branches = <Branches>[];
      json['data'].forEach((v) {
        branches!.add( Branches.fromJson(v));
      });
    }
  }


}

class Branches {
  String? id;
  String? countryId;
  String? lat;
  String? long;
  String? email;
  int? areaId;
  String? phone;
  int? isApproved;
  bool? isFavorite;
  bool? isWorkingNow;
  int? isPharmacy;
  String? name;


  Branches(
      {this.id,
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

  Branches.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    countryId = json['country_id'].toString();
    lat = json['lat'];
    long = json['long'];
    email = json['email'];
    areaId = json['area_id'];
    phone = json['phone'];
    isApproved = json['is_approved'];
    isFavorite = json['is_favorite'];
    isWorkingNow = json['is_working_now'];
    isPharmacy = json['is_pharmacy'];
    name = json['name'];

  }


}

