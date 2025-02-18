class MainCategoryData {
  List<MainCategory>? mainCategory;

  MainCategoryData({ this.mainCategory});

  factory MainCategoryData.fromJson(Map<String, dynamic> json) {

    var list = json['data'] as List;
    List<MainCategory> mainCategoryList = list.map((i) => MainCategory.fromJson(i)).toList();
    return MainCategoryData(mainCategory: mainCategoryList,);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mainCategory != null) {
      data['data'] = this.mainCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainCategory {
  String? id;
  String? mainCategoryId;
  int? status;
  int? level;
  int? ranks;
  String? imagePath;
  String? imagePath2;
  int? leafsCount;
  int? isForPharmacy;
  String? name;

  MainCategory(
      {this.id,
        this.mainCategoryId,
        this.status,
        this.level,
        this.ranks,
        this.imagePath,
        this.imagePath2,
        this.leafsCount,
        this.isForPharmacy,
        this.name});

  factory MainCategory.fromJson(Map<String, dynamic> json) {
    return MainCategory(
    id : json['id'].toString(),
    mainCategoryId : json['main_category_id'].toString(),
    status : json['status'],
    level : json['level'],
    ranks : json['ranks'],
    imagePath : json['image_path'],
    imagePath2 : json['image_path2'],
    leafsCount : json['leafs_count'],
    isForPharmacy : json['is_for_pharmacy'],
    name : json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['main_category_id'] = mainCategoryId;
    data['status'] = status;
    data['level'] = level;
    data['ranks'] = ranks;
    data['image_path'] = imagePath;
    data['leafs_count'] = leafsCount;
    data['is_for_pharmacy'] = isForPharmacy;
    data['name'] = name;
    return data;
  }
}

