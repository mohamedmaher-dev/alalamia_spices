class ProductImageData {
  bool? success;
  List<ProductImage>? productImage;

  ProductImageData({this.success, this.productImage});

  ProductImageData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      productImage = <ProductImage>[];
      json['data'].forEach((v) {
        productImage!.add( ProductImage.fromJson(v));
      });
    }
  }


}

class ProductImage {
  int? id;
  int? productId;
  String? image;
  String? imagePath;

  ProductImage({this.id, this.productId, this.image, this.imagePath});

  ProductImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    image = json['image'];
    imagePath = json['image_path'];
  }


}

