import 'package:alalamia_spices/app/data/model/product_status.dart';

class CartData {
  List<Cart>? cart;

  CartData({this.cart});

  factory CartData.fromJson(var json) {
    var list = json['data'] as List;
    List<Cart> cartList = list.map((i) => Cart.fromJson(i)).toList();
    return CartData(cart: cartList);
  }
}

class Cart {
  final String? priceSum;
  final int? id;
  final double? deliveryPricing;
  final List<CartItem>? products;
  final List<CartItem>? offers;
  final List<CartItem>? specialOrders;
  final String? branch_count;
  Cart({
    this.priceSum,
    this.products,
    this.offers,
    this.specialOrders,
    this.branch_count,
    this.id,
    this.deliveryPricing,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var listOfProduct = json["cart_product_items"] as List;
    List<CartItem> productList =
        listOfProduct.map((i) => CartItem.fromJson(i)).toList();

    // custom product

    var listOfOffers = json["cart_offer_items"] as List;
    List<CartItem> offerList =
        listOfOffers.map((i) => CartItem.fromJson(i)).toList();

    var listOfSpecial = json["cart_special_items"] as List;
    List<CartItem> specialOrdersList =
        listOfSpecial.map((i) => CartItem.fromJson(i)).toList();

    return Cart(
      priceSum: json["price_sum"].toString(),
      products: productList,
      offers: offerList,
      specialOrders: specialOrdersList,
      id: json["cart_id"],
      branch_count: json["branch_count"] ?? "",
      deliveryPricing: json["delivery_pricing"] ?? "empty",
    );
  }
}

class CartItem {
  final String? id, price, name, type, image, cartItemId;
  String? quantity,
      branchId,
      replayid,
      currency,
      insurance_rate,
      breadAdd,
      branchName;
  String? addAr;
  String? paidAdd;
  bool? isPaidAdd;
  final String? customProduct;
  final String? productUnit;
  String? productQuantity;
  String? unitName;
  String? productId;
  // final String? productId;

  CartItem({
    this.id,
    this.cartItemId,
    this.quantity,
    this.price,
    this.name,
    this.type,
    this.branchId,
    this.replayid,
    this.currency,
    this.insurance_rate,
    this.branchName,
    this.breadAdd,
    this.addAr,
    this.customProduct,
    this.image,
    this.productUnit,
    this.productQuantity,
    this.paidAdd,
    this.isPaidAdd,
    this.unitName,
    this.productId,
    // this.productId
  });
  factory CartItem.fromJson(var json) {
    return CartItem(
      id: json["id"].toString(),
      cartItemId: json["cart_item_id"].toString(),
      branchId: json["branchId"].toString(),
      quantity: json["quantity"],
      price: json["price"],
      name: json["name"],
      type: json["type"],
      replayid: json["replayid"],
      currency: json["currency"].toString(),
      insurance_rate: json["insurance_rate"],
      addAr: json['new_add_ar'] ?? "",
      branchName: json['branch'],
      customProduct: json['custom_product'],
      image: json['image360'],
      productUnit: json['productUnit'],
      productQuantity: json['product_count'],
      paidAdd: json['paid_add'],
      isPaidAdd: json['is_paid_add'],
      unitName: json['unitName'],
      productId: json['productId'],
      // productId: json['product_id'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cart_item_id'] = id;
    data['branchId'] = branchId;
    data['price'] = price;
    data['name'] = name;
    data['quantity'] = quantity;
    data['type'] = type;
    data['replayid'] = replayid;
    data['currency'] = currency;
    data['insurance_rate'] = insurance_rate;
    data['branch'] = branchName;
    data['custom_product'] = customProduct;
    data['image360'] = image;
    data['productUnit'] = productUnit;
    data['product_count'] = productQuantity;
    data['paid_add'] = paidAdd;
    data['is_paid_add'] = isPaidAdd;
    data['unitName'] = unitName;
    data['productId'] = productId;
    // data['product_id'] = productId;
    if (addAr != null) {
      data['new_add_ar'] = addAr;
    } else {
      data['new_add_ar'] = ".";
    }

    return data;
  }
}
