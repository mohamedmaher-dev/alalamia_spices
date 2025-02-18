class NewCartData {
  bool? success;
  List<NewCart>? data;

  NewCartData({this.success, this.data});

  NewCartData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <NewCart>[];
      json['data'].forEach((v) {
        data!.add(  NewCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewCart {
  int? cartId;
  int? deliveryPricing;
  String? price;
  String? name;
  String? type;
  String? quantity;
  String? branchId;
  String? currency;
  String? image;
  String? addAr;
  String? cartDetailsId;
  String? priceId;
  String? insurance_rate;

  NewCart(
      {this.cartId,
        this.deliveryPricing,
        this.price,
        this.name,
        this.type,
        this.quantity,
        this.branchId,
        this.currency,
        this.image,
        this.addAr,
        this.cartDetailsId,
        this.priceId,
        this.insurance_rate,
      });

  NewCart.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    deliveryPricing = json['delivery_pricing'];
    price = json['price'];
    name = json['name'];
    type = json['type'];
    quantity = json['quantity'];
    branchId = json['branchId'].toString();
    currency = json['currency'];
    image = json['image'];
    addAr = json['addAr'];
    cartDetailsId = json['cart_details_id'].toString();
    priceId = json['price_id'].toString();
    insurance_rate = json["insurance_rate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['delivery_pricing'] = this.deliveryPricing;
    data['price'] = this.price;
    data['name'] = this.name;
    data['type'] = this.type;
    data['quantity'] = this.quantity;
    data['branchId'] = this.branchId;
    data['currency'] = this.currency;
    data['image'] = this.image;
    data['addAr'] = this.addAr;
    data['price_id'] = this.priceId;
    data['cart_details_id'] = this.cartDetailsId;
    data['insurance_rate'] = this.insurance_rate;
    return data;
  }
}

