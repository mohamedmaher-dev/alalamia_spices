import 'new_arrival.dart';

class RelatedProductData {
  bool? success;
  List<Product>? relatedProduct;

  RelatedProductData({this.success, this.relatedProduct});

  RelatedProductData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      relatedProduct = <Product>[];
      json['data'].forEach((v) {
        relatedProduct!.add( Product.fromJson(v));
      });
    }
  }


}