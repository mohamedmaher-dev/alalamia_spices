class CountriesData {
  List<Countries>? countries;

  CountriesData({this.countries});

  factory CountriesData.fromJson(Map<String, dynamic> json) {

    var list = json['data'] as List;
    List<Countries> countriesList = list.map((i) => Countries.fromJson(i)).toList();
    return CountriesData(countries: countriesList,);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   Map<String, dynamic>();
    if (countries != null) {
      data['data'] =  countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countries {
  int? id;
  String? countryId;
  String? name;
  String? type;
  int? currencyId;
  String? gender;
  String? adminName;
  String? image;
  int? status;
  int? available;
  int? level;
  int? isApproved;
  String? phone;
  String? telephone;
  String? whatsApp;
  String? email;
  String? logNo;
  String? style;
  String? rememberToken;
  bool? isFavorite;
  int? branchesCount;
  String? imagePath;
  List<Branch>? branch;

  Countries(
      {this.id,
        this.countryId,
        this.name,
        this.type,
        this.currencyId,
        this.gender,
        this.adminName,
        this.image,
        this.status,
        this.available,
        this.level,
        this.isApproved,
        this.phone,
        this.telephone,
        this.whatsApp,
        this.email,
        this.logNo,
        this.style,
        this.rememberToken,
        this.isFavorite,
        this.branchesCount,
        this.imagePath,
        this.branch});

  factory Countries.fromJson(Map<String, dynamic> json) {

    var list = json['branch'] as List;
    List<Branch> branchList =list.map((i) => Branch.fromJson(i)).toList();



    return Countries(

    id : json['id'],
    countryId : json['country_id'].toString(),
    name : json['name'],
    type : json['type'],
    currencyId : json['currency_id'],
    gender : json['gender'],
    adminName : json['admin_name'],
    image : json['image'],
    status : json['status'],
    available : json['available'],
    level : json['level'],
    isApproved : json['is_approved'],
    phone : json['phone'],
    telephone : json['telephone'],
    whatsApp : json['whats_app'],
    email : json['email'],
    logNo : json['log_no'],
    style : json['style'],
    rememberToken : json['remember_token'],
    isFavorite : json['is_favorite'],
    branchesCount : json['branches_count'],
    imagePath : json['image_path'],
    branch: branchList
    // if (json['branch'] != null) {
    //   branch = <Branch>[];
    //   json['branch'].forEach((v) {
    //     branch!.add(  Branch.fromJson(v));
    //   });
    // }
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['id'] = id;
    data['country_id'] = countryId;
    data['name'] = name;
    data['type'] = type;
    data['currency_id'] = currencyId;
    data['gender'] = gender;
    data['admin_name'] = adminName;
    data['image'] = image;
    data['status'] = status;
    data['available'] = available;
    data['level'] = level;
    data['is_approved'] = isApproved;
    data['phone'] = phone;
    data['telephone'] = telephone;
    data['whats_app'] = whatsApp;
    data['email'] = email;
    data['log_no'] = logNo;
    data['style'] = style;
    data['remember_token'] = rememberToken;
    data['is_favorite'] = isFavorite;
    data['branches_count'] = branchesCount;
    data['image_path'] = imagePath;
    if (branch != null) {
      data['branch'] = branch!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Branch {
  int? id;
  int? countryId;
  int? areaId;
  String? phone;
  int? isApproved;
  bool? isFavorite;
  bool? isWorkingNow;
  int? isPharmacy;
  String? name;

  Branch(
      {this.id,
        this.countryId,
        this.areaId,
        this.phone,
        this.isApproved,
        this.isFavorite,
        this.isWorkingNow,
        this.isPharmacy,
        this.name,
      });

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    areaId = json['area_id'];
    phone = json['phone'];
    isApproved = json['is_approved'];
    isFavorite = json['is_favorite'];
    isWorkingNow = json['is_working_now'];
    isPharmacy = json['is_pharmacy'];
    name = json['name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['area_id'] = this.areaId;
    data['phone'] = this.phone;
    data['is_approved'] = this.isApproved;
    data['is_favorite'] = this.isFavorite;
    data['is_working_now'] = this.isWorkingNow;
    data['is_pharmacy'] = this.isPharmacy;
    data['name'] = this.name;
    return data;
  }
}



