class AllCategoriesData {
  bool? success;
  List<AllCategories>? allCategories;

  AllCategoriesData({this.success, this.allCategories});

  AllCategoriesData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      allCategories = <AllCategories>[];
      json['data'].forEach((v) {
        allCategories!.add( AllCategories.fromJson(v));
      });
    }
  }

}

class AllCategories {
  String? id;
  String? mainCategoryId;
  int? level;
  String? imageUrl;
  String? image64;
  String? image150;
  String? image360;
  String? image640;
  bool? isActiveProducts;
  String? name;
  String? details;
  String? image;

  AllCategories(
      {this.id,
        this.mainCategoryId,
        this.level,
        this.imageUrl,
        this.image64,
        this.image150,
        this.image360,
        this.image640,
        this.isActiveProducts,
        this.name,
        this.details,
        this.image});

  AllCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    mainCategoryId = json['main_category_id'].toString();
    level = json['level'];
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

