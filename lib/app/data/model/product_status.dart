

class ProductStatus {
  String? id;
  int? countryId;
  String? productId;
  int? status;
  int? isApproved;

  ProductStatus({this.id, this.countryId, this.productId, this.status, this.isApproved});

  ProductStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    countryId = json['country_id'];
    productId = json['product_id'].toString();
    status = json['status'];
    isApproved = json['is_approved'];
  }


}

