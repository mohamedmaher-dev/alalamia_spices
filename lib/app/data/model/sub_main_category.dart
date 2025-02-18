class SubMainCategoryData {
  bool? success;
  List<SubMainCategory>? subMainCategory;

  SubMainCategoryData({this.success, this.subMainCategory});

  SubMainCategoryData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      subMainCategory = <SubMainCategory>[];
      json['data'].forEach((v) {
        subMainCategory!.add( SubMainCategory.fromJson(v));
      });
    }
  }


}

class SubMainCategory {
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

  SubMainCategory(
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
      });

  SubMainCategory.fromJson(Map<String, dynamic> json) {
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
  }

}

