
//
// class OffersData {
//   bool? success;
//   List<Offers>? offers;
//
//   OffersData({this.success, this.offers});
//
//   OffersData.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['data'] != null) {
//       offers = <Offers>[];
//       json['data'].forEach((v) {
//         offers!.add(  Offers.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.offers != null) {
//       data['data'] = this.offers!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Offers {
//   String? id;
//   String? currency;
//   String? currencyName;
//   String? oldPrice;
//   String? price;
//   String? endDate;
//   String? imagePath;
//   String? name;
//   Type? type;
//   int? areaId;
//   List<OfferProductPrice>? offerProductPrice;
//   String? branchName;
//   int? branchId;
//
//   Offers(
//       {this.id,
//         this.currency,
//         this.oldPrice,
//         this.price,
//         this.endDate,
//         this.imagePath,
//         this.name,
//         this.type,
//         this.areaId,
//         this.offerProductPrice,
//         this.branchName,
//         this.branchId,
//         this.currencyName
//       });
//
//   Offers.fromJson(Map<String, dynamic> json) {
//     id = json['id'].toString();
//     currency = json['currency'].toString();
//     oldPrice = json['old_price'];
//     price = json['price'];
//     endDate = json['end_date'];
//     imagePath = json['image_path'];
//     name = json['name'];
//     type = json['type'] != null ? new Type.fromJson(json['type']) : null;
//     areaId = json['area_id'];
//     if (json['offer_product_price'] != null) {
//       offerProductPrice = <OfferProductPrice>[];
//       json['offer_product_price'].forEach((v) {
//         offerProductPrice!.add(new OfferProductPrice.fromJson(v));
//       });
//     }
//     branchName = json['branch_name'];
//     branchId = json['branch_id'];
//     branchId = json['currency_name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['currency'] = this.currency;
//     data['old_price'] = this.oldPrice;
//     data['price'] = this.price;
//     data['end_date'] = this.endDate;
//     data['image_path'] = this.imagePath;
//     data['name'] = this.name;
//     data['area_id'] = this.areaId;
//     if (this.offerProductPrice != null) {
//       data['offer_product_price'] =
//           this.offerProductPrice!.map((v) => v.toJson()).toList();
//     }
//     data['branch_name'] = this.branchName;
//     data['branch_id'] = this.branchId;
//     data['currency_name'] = this.currencyName;
//     return data;
//   }
// }
//
// class Type {
//   int? id;
//   String? name;
//
//   Type({this.id,  this.name});
//
//   Type.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
//
//
// }
//
// class OfferProductPrice {
//   int? id;
//   String? name;
//   String? unit;
//   String? price;
//   String? quantity;
//
//   OfferProductPrice({this.id, this.name, this.unit, this.price, this.quantity});
//
//   OfferProductPrice.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     unit = json['unit'];
//     price = json['price'];
//     quantity = json['quantity'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['unit'] = this.unit;
//     data['price'] = this.price;
//     data['quantity'] = this.quantity;
//     return data;
//   }
// }



class OffersData {
  bool? success;
  List<Offers>? offers;

  OffersData({this.success, this.offers});

  OffersData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      offers = <Offers>[];
      json['data'].forEach((v) {
        offers!.add(new Offers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    if (offers != null) {
      data['data'] = offers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offers {
  String? id;
  String? currency;
  String? currencyName;
  String? oldPrice;
  String? price;
  String? endDate;
  String? imagePath;
  String? name;
  Type? type;
  // String? areaId;
  List<OfferProductPrice>? offerProductPrice;
  String? branchName;
  int? branchId;

  Offers(
      {this.id,
        this.currency,
        this.currencyName,
        this.oldPrice,
        this.price,
        this.endDate,
        this.imagePath,
        this.name,
        this.type,
        // this.areaId,
        this.offerProductPrice,
        this.branchName,
        this.branchId});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    currency = json['currency'].toString();
    currencyName = json['currency_name'];
    oldPrice = json['old_price'];
    price = json['price'];
    endDate = json['end_date'];
    imagePath = json['image_path'];
    name = json['name'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    // areaId = json['area_id'];
    if (json['offer_product_price'] != null) {
      offerProductPrice = <OfferProductPrice>[];
      json['offer_product_price'].forEach((v) {
        offerProductPrice!.add(new OfferProductPrice.fromJson(v));
      });
    }
    branchName = json['branch_name'];
    branchId = json['branch_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['currency'] = currency;
    data['currency_name'] = currencyName;
    data['old_price'] = oldPrice;
    data['price'] = price;
    data['end_date'] = endDate;
    data['image_path'] = imagePath;
    data['name'] = name;
    if (type != null) {
      data['type'] = type!.toJson();
    }
    // data['area_id'] = areaId;
    if (offerProductPrice != null) {
      data['offer_product_price'] =
          offerProductPrice!.map((v) => v.toJson()).toList();
    }
    data['branch_name'] = branchName;
    data['branch_id'] = branchId;
    return data;
  }
}

class Type {
  int? id;
  int? status;
  String? name;

  Type({this.id, this.status, this.name});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['status'] = status;
    data['name'] = name;
    return data;
  }
}

class OfferProductPrice {
  int? id;
  String? name;
  String? unit;
  String? price;
  String? quantity;

  OfferProductPrice({this.id, this.name, this.unit, this.price, this.quantity});

  OfferProductPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    unit = json['unit'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['unit'] = unit;
    data['price'] = price;
    data['quantity'] = quantity;
    return data;
  }
}

