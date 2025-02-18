class NewArrivalData {
  List<Product>? product;

  NewArrivalData({this.product});

  factory NewArrivalData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Product> productList = list.map((i) => Product.fromJson(i)).toList();
    return NewArrivalData(product: productList,);
  }


}


class Product {
  String? id;
  String? name;
  String? countryName;
  String? specification;
  bool? favorite;
  String? overview;
  String? image;
  String? image64;
  String? image150;
  String? image360;
  String? image640;
  String? discount;
  String? firstPrice;
  bool? mostSell;
  bool? productFavorite;
  bool? isNewProduct;
  // bool? status;
  String? overallAssessment;
  String? numberResidents;
  List<Prices>? prices;
  String? link;
  bool? morePricese;
  Branch? branch;
  List<Categories>? categories;
  List<Adds>?  adds;
  List<AddSize>?  addSize;

  Product(
      {this.id,
        this.name,
        this.countryName,
        this.specification,
        this.overview,
        this.image,
        this.image64,
        this.image150,
        this.image360,
        this.image640,
        this.discount,
        this.firstPrice,
        this.mostSell,
        this.productFavorite,
        this.isNewProduct,
        // this.status,
        this.overallAssessment,
        this.numberResidents,
        this.prices,
        this.link,
        this.morePricese,
        this.branch,
        this.categories,
        this.favorite,
        this.adds,
        this.addSize

      });

  factory Product.fromJson(Map<String, dynamic> json) {


    var list = json['prices'] as List;
    List<Prices> priceList =list.map((i) => Prices.fromJson(i)).toList();

    var addlist = json['adds']  != null ? json['adds'] as List  : null;
    List<Adds>? addsList = addlist != null ? addlist.map((i) => Adds.fromJson(i)).toList() : null;

    var sizeslist = json['addssize'] != null ? json['addssize']  as List  : null  ;
    List<AddSize>? sizeList = sizeslist != null ?  sizeslist.map((i) => AddSize.fromJson(i)).toList() : null;

    return Product(
    id : json['id'].toString(),
    name : json['name'],
    countryName : json['country_name'],
    specification : json['specification'],
    overview : json['overview'],
    image : json['image'],
    image64 : json['image64'],
    image150 : json['image150'],
    image360 : json['image360'],
    image640 : json['image640'],
    discount : json['discount'],
    firstPrice : json['first_price'].toString(),
    mostSell : json['most_sell'],
    productFavorite : json['productFavorite'],
    isNewProduct : json['is_new_product'],
    // status : json['status'],
    overallAssessment : json['overall_assessment'].toString(),
    numberResidents : json['number_residents'].toString(),
    prices : priceList,
    adds : addsList,
    addSize: sizeList,
    // if (json['prices'] != null) {
    //   prices = <Prices>[];
    //   json['prices'].forEach((v) {
    //     prices!.add( Prices.fromJson(v));
    //   });
    // }
    // if(json['adds'] != null){
    //   adds = <Adds>[];
    //   json['adds'].forEach((v) {
    //     adds!.add( Adds.fromJson(v));
    //   });
    // }
    //
    // if (json['addssize'] != null) {
    //   addSize = <AddSize>[];
    //   json['addssize'].forEach((v) {
    //     addSize!.add( AddSize.fromJson(v));
    //   });
    // }

    link : json['link'],
    morePricese : json['more_pricese'],
    favorite :  json["productFavorite"],
    branch : json['branch'] != null ?  Branch.fromJson(json['branch']) : null,
    // if (json['categories'] != null) {
    //   categories = <Categories>[];
    //   json['categories'].forEach((v) {
    //     categories!.add( Categories.fromJson(v));
    //   });
    // }
    );
  }


}

class Adds {
  String? id;
  String? productId;
  String? typeId;
  String? addAr;
  String? addEn;
  String? typeAr;
  String? typeEn;


  Adds(
      {this.id,
        this.productId,
        this.typeId,
        this.addAr,
        this.addEn,
        this.typeEn,
        this.typeAr

      });

  factory Adds.fromJson(Map<String, dynamic> json) {
    return Adds(
      id : json['id'].toString(),
      productId : json['product_id'].toString(),
      typeId : json['type_id'].toString(),
      addAr : json['add_ar'] ?? "",
      addEn : json['add_en'] ?? "",
      typeAr : json['type_ar'] ?? " ",
      typeEn : json['type_en'] ?? "" ,

    );

  }


}

class AddSize {
  String? id;
  String? productId;
  String? addAr;
  String? addEn;
  String? typeAr;
  String? typeEn;


  AddSize(
      {this.id,
        this.productId,
        this.addAr,
        this.addEn,
        this.typeAr,
        this.typeEn
      });

  factory AddSize.fromJson(Map<String, dynamic> json) {
    return AddSize(
      id : json['id'].toString(),
      productId : json['product_id'].toString(),
      addAr : json['add_ar'] != null ? json['add_ar'] : "",
      addEn : json['add_en'] != null ? json['add_en'] : "",
      typeAr : json['type_ar'] != null ? json['type_ar'] : " ",
      typeEn : json['type_en'] != null ?  json['type_en'] : "" ,

    );

  }
//  HexColor.fromHex(json['color'])

}

class Prices {
  String? id;
  String? countryName;
  int? productQuantity;
  String? price;
  String? currency;
  String? pricingType;
  String? note;
  String? orderAvailability;
  String? image;
  String? productName;
  String? unitName;
  String? productLink;
  String? imagePath;
  String? imagePath64;
  String? imagePath150;
  String? imagePath360;
  String? imagePath640;
  String? oldPrice;
  bool? reorderable;
  Branch? branch;
  String? priceNote;
  String? productDiscount;
  String? productDiscountWithDeactivated;
  String? paidAdds;

  Prices(
      {this.id,
        this.countryName,
        this.price,
        this.currency,
        this.pricingType,
        this.note,
        this.orderAvailability,
        this.image,
        this.productName,
        this.unitName,
        this.productLink,
        this.imagePath,
        this.imagePath64,
        this.imagePath150,
        this.imagePath360,
        this.imagePath640,
        this.oldPrice,
        this.reorderable,
        this.branch,
        this.priceNote,
        this.productDiscount,
        this.productDiscountWithDeactivated,
        this.productQuantity = 0,
        this.paidAdds
      });

  Prices.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    countryName = json['country_name'];
    productQuantity = json['product_quantity'] ?? 0;
    price = json['price'];
    currency = json['currency'];
    pricingType = json['pricing_type'];
    note = json['note'];
    orderAvailability = json['order_availability'].toString();
    image = json['image'];
    productName = json['productName'];
    unitName = json['unitName'];
    productLink = json['productLink'];
    imagePath = json['image_path'];
    imagePath64 = json['image_path_64'];
    imagePath150 = json['image_path_150'];
    imagePath360 = json['image_path_360'];
    imagePath640 = json['image_path_640'];
    oldPrice = json['old_price'];
    reorderable = json['reorderable'];
    branch = json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
    priceNote = json['price_note'];
    productDiscount = json['product_discount'];
    productDiscountWithDeactivated = json['product_discount_with_deactivated'];
    paidAdds = json['add_price'];
  }

}

class Branch {
  String? id;
  String? countryId;
  String? areaId;
  String? phone;
  int? isApproved;
  bool? isFavorite;
  bool? isWorkingNow;
  int? isPharmacy;
  String? avgRate;
  String? name;
  List<PharmacyCategory>? pharmacyCategory;

  Branch(
      {this.id,
        this.countryId,
        this.areaId,
        this.phone,
        this.isApproved,
        this.isFavorite,
        this.isWorkingNow,
        this.isPharmacy,
        this.avgRate,
        this.name,
        this.pharmacyCategory,
      });

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    countryId = json['country_id'].toString();
    areaId = json['area_id'].toString();
    phone = json['phone'];
    isApproved = json['is_approved'];
    isFavorite = json['is_favorite'];
    isWorkingNow = json['is_working_now'];
    isPharmacy = json['is_pharmacy'];
    avgRate = json['avg_rate'].toString();
    name = json['name'];
    if (json['pharmacy_category'] != null) {
      pharmacyCategory = <PharmacyCategory>[];
      json['pharmacy_category'].forEach((v) {
        pharmacyCategory!.add( PharmacyCategory.fromJson(v));
      });
    }
  }

}

class PharmacyCategory {
  String? id;
  String? insuranceCompanyId;
  String? branchId;
  int? mainCategory;
  String? commission;
  int? status;

  PharmacyCategory(
      {this.id,
        this.insuranceCompanyId,
        this.branchId,
        this.mainCategory,
        this.commission,
        this.status,
      });

  PharmacyCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    insuranceCompanyId = json['insurance_company_id'].toString();
    branchId = json['branch_id'].toString();
    mainCategory = json['main_category'];
    commission = json['commission'];
    status = json['status'];

  }

}

class Categories {
  String? id;
  String? mainCategoryId;
  int? level;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? imageUrl;
  String? image64;
  String? image150;
  String? image360;
  String? image640;
  bool? isActiveProducts;
  String? name;
  String? details;
  String? image;
  Pivot? pivot;

  Categories(
      {this.id,
        this.mainCategoryId,
        this.level,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.imageUrl,
        this.image64,
        this.image150,
        this.image360,
        this.image640,
        this.isActiveProducts,
        this.name,
        this.details,
        this.image,
        this.pivot});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    mainCategoryId = json['main_category_id'].toString();
    level = json['level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    imageUrl = json['image_url'];
    image64 = json['Image64'];
    image150 = json['image150'];
    image360 = json['image360'];
    image640 = json['image640'];
    isActiveProducts = json['is_active_products'];
    name = json['name'];
    details = json['details'];
    image = json['image'];
    pivot = json['pivot'] != null ?  Pivot.fromJson(json['pivot']) : null;
  }

}

class Pivot {
  String? productId;
  String? categoryId;

  Pivot({this.productId, this.categoryId});

  Pivot.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'].toString();
    categoryId = json['category_id'].toString();
  }

}

