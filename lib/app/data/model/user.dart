class UserData {
  final User? user;

  UserData({this.user});
  factory UserData.fromJson(var json) {
    return UserData(user: User.fromJson(json['data']));
  }
}

// class Wallet {
//   String? openingBalance, currentBalance , currency;
//   Wallet({
//     this.openingBalance,
//     this.currentBalance,
//     this.currency
//   });
//   factory Wallet.fromJson(Map<String, dynamic> json) {
//     return Wallet(
//       openingBalance: json["openning_balance"].toString(),
//       currentBalance: json["current_balance"].toString(),
//       currency: json["currency"].toString(),
//     );
//   }
// }

class Errors {
  String? statusMessage;
  Errors({statusMessage});
  factory Errors.fromJson(Map<String, dynamic> json) {
    return Errors(
      statusMessage: json["status_message"].toString(),
    );
  }
}

class User {
  String? name, phone, email, gender, status, image, statusMessage , oldPassword , newPassword , confirmPassword;
  String? userType;
  String? countryId;
  String? countryName;
  // Wallet? wallet;
  Country? country;
  String? currencyName;
  User({
    this.name,
    this.phone,
    this.email,
    this.gender,
    this.status,
    // this.wallet,
    this.image,
    this.statusMessage,
    this.oldPassword,
    this.newPassword,
    this.confirmPassword,
    this.userType,
    this.countryId,
    this.countryName,
    this.country,
    this.currencyName

  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      gender: json["gender"],
      image: json["image_path"] == null ? "" : json["image_path"],
      status: json["status"].toString(),
      statusMessage: json["status_message"],
      countryName: json["country_name"],
      country: Country.fromJson(json["country"]),
      // wallet: json["wallet"] == null
      //     ? Wallet(openingBalance: "0.0", currentBalance: "0.0")
      //     : Wallet.fromJson(json["wallet"]),

      oldPassword: json["old_password"],
      newPassword : json["password"],
      confirmPassword: json["confirm_password"],
      userType: json["user_type"],
      countryId: json["country_id"].toString(),
      currencyName: json["currency_name"],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = name ?? "";
    data['email'] = email ?? "";
    data['phone'] = phone ?? "";
    data['gender'] = gender ?? " ";
    data["image_path"] = image ?? " ";
    data["old_password"] = oldPassword ?? " ";
    data["password"] = newPassword ?? " ";
    data["confirm_password"] = confirmPassword ?? " ";
    data["country_id"] = countryId ?? "18";
    return data;
  }
}

class ChangPasswordClass {
  String? phone, newPassword;
  ChangPasswordClass({
    this.phone,
    this.newPassword,
  });
  factory ChangPasswordClass.fromJson(Map<String, dynamic> json) {
    return ChangPasswordClass(
      phone: json["phone"],
      newPassword: json["password"],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = this.phone;
    data['password'] = this.newPassword;

    return data;
  }
}

class Country {
  String? id;
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
  String? style;
  String? rememberToken;
  bool? isFavorite;
  int? branchesCount;
  String? imagePath;
  String? aramexStatus;

  Country({this.id,
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
    this.style,
    this.rememberToken,
    this.isFavorite,
    this.branchesCount,
    this.imagePath,
    this.aramexStatus,
  });

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    type = json['type'];
    currencyId = json['currency_id'];
    gender = json['gender'];
    adminName = json['admin_name'];
    image = json['image'];
    status = json['status'];
    available = json['available'];
    level = json['level'];
    isApproved = json['is_approved'];
    phone = json['phone'];
    telephone = json['telephone'];
    whatsApp = json['whats_app'];
    email = json['email'];
    style = json['style'];
    rememberToken = json['remember_token'];
    isFavorite = json['is_favorite'];
    branchesCount = json['branches_count'];
    imagePath = json['image_path'];
    aramexStatus = json['aramex_status'];
  }
}


