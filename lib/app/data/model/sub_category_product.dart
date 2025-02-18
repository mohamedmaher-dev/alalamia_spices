import 'new_arrival.dart';

class SubCategoryProductData {
  bool? success;
  List<Product>? categoryProduct;

  SubCategoryProductData({this.success, this.categoryProduct});

  SubCategoryProductData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      categoryProduct = <Product>[];
      json['data'].forEach((v) {
        categoryProduct!.add( Product.fromJson(v));
      });
    }
  }
}