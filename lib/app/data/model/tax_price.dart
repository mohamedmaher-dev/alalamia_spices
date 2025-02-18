class TaxPriceData {
  bool? success;
  List<TaxPrice>? taxPrice;

  TaxPriceData({this.success, this.taxPrice});

  TaxPriceData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      taxPrice = <TaxPrice>[];
      json['data'].forEach((v) {
        taxPrice!.add( TaxPrice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.taxPrice != null) {
      data['data'] = this.taxPrice!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaxPrice {
  String? id;
  int? status;
  String? price;
  String? countryId;
  bool? active;
  String? countryName;

  TaxPrice(
      {this.id,
        this.status,
        this.price,
        this.countryId,
        this.active,
        this.countryName});

  TaxPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    status = json['status'];
    price = json['price'];
    countryId = json['country_id'].toString();
    active = json['active'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['price'] = this.price;
    data['country_id'] = this.countryId;
    data['active'] = this.active;
    data['country_name'] = this.countryName;
    return data;
  }
}

