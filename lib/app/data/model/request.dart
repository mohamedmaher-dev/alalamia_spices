
import 'package:alalamia_spices/app/exports/model.dart';

import 'cart.dart';

class RequestData {
  List<Request>? requests;
  RequestData({this.requests});
  factory RequestData.fromJson(var json) {
    var list = json['data'] as List;
    List<Request> requestList = list.map((i) => Request.fromJson(i)).toList();
    return RequestData(requests: requestList);
  }
}

class RequestItems {
  final String? priceSum;
  final List<CartItem>? cartProductItems;
  final List<CartItem>? cartOfferItems;
  final List<CartItem>? cartSpecialItems;
  // final List<CartItem>? cartHospitalityItem;
  // final List<CartItem>? customProduct;
  RequestItems({this.priceSum, this.cartProductItems, this.cartOfferItems, this.cartSpecialItems  });
  factory RequestItems.fromJson(Map<String, dynamic> json) {
    var productlist = json['cart_product_items'] as List;
    List<CartItem> cartProductItemList = productlist.map((i) => CartItem.fromJson(i)).toList();
    var offerlist = json['cart_offer_items'] as List;
    List<CartItem> cartOfferItemList = offerlist.map((i) => CartItem.fromJson(i)).toList();
    var speciallist = json['cart_special_items'] as List;
    List<CartItem> cartSpecialItemList = speciallist.map((i) => CartItem.fromJson(i)).toList();
    // var hospitalitylist = json['cart_prescription_reply_items'] as List;
    // List<CartItem> hospitalityItemlist = hospitalitylist.map((i) => CartItem.fromJson(i)).toList();

    // custom product

    // var listOfCustomProduct = json["custom_product_items"] as List;
    // List<CartItem> customProductList = listOfCustomProduct.map((i) => CartItem.fromJson(i)).toList();


    return RequestItems(
      priceSum: json["price_sum"].toString(),
      cartProductItems: cartProductItemList,
      cartOfferItems: cartOfferItemList,
      cartSpecialItems: cartSpecialItemList,
      // cartHospitalityItem: hospitalityItemlist,
      // customProduct: customProductList
    );
  }

}

class Request {
  final int? rated;
  final String? id;
  final String? addedPrice;
  final String? addedNote;
  final String? requestNumber;
  final String? paymentType, receivingType, status, cartId, paymentSum,
      createdAt, deliverLocationId, couponNumber, requestNote, deliveryPriceId, carrierId, requestId,branchId;
  final bool? canReorder;
  final RequestItems? requestItems;
  final User? user;
  final bool? confirm;
  // success;
  final  String? area_id,address_id,discountid;
  final String? deliveryPrice;
  final String? deliveryPricing;
  final String?  chargeId;
  final Branch? branch;
  final String? bookingDate;
  final String? countryId;
  final String? currency;

  // final String? externalDeliveryPrice;



  Request(
      {
        this.id,
        this.deliveryPrice,
        this.paymentType,
        this.requestNumber,
        this.receivingType,
        this.rated,
        this.status,
        this.cartId,
        this.canReorder,
        this.paymentSum,
        this.createdAt,
        this.carrierId,
        this.requestId,
        this.requestItems,
        this.user,
        this.deliverLocationId,
        this.couponNumber,
        this.requestNote,
        this.deliveryPriceId,
        this.confirm,
        // this.success,
        this.branchId,
        this.area_id,
        this.address_id,
        this.discountid,
        this.addedNote,
        this.addedPrice,
        this.deliveryPricing,
        this.branch,
        this.chargeId,
        this.bookingDate,
        this.countryId,
        this.currency,
        // this.externalDeliveryPrice

      });
  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      requestNumber: json["request_number"].toString(),
      id: json["id"].toString(),
      branchId: json["branch"] != null ? json["branch"]["id"].toString() : null,
      area_id: json["branch"] != null ? json["branch"]["area_id"].toString() : null,
      paymentType: json["payment_type"].toString(),
      receivingType: json["receiving_type"],
      status: json["status"],
      cartId: json["cart_id"].toString(),
      discountid: json["id"].toString(),
      paymentSum: json["payment_sum"].toString(),
      createdAt: json["created_at"].toString(),
      carrierId: json["request_carrier"].toString(),
      requestId: json["id"].toString(),
      requestItems: RequestItems.fromJson(json["request_items"]),
      requestNote: json["request_note"],
      rated: json["rated"],
      canReorder: json["can_be_reordered"] as bool,
      deliveryPrice: json["deliveryPrice"] ,
      addedPrice: json["add_price"] != null ? json["add_price"].toString() : "0.0" ,
      addedNote: json["price_note"] ,
      deliveryPricing: json["delivery_pricing"] ,
      chargeId: json["charge_id"].toString() ,
      bookingDate: json["booking_date"].toString() ,
      countryId: json["country_id"].toString(),
      currency: json["currency"] != null ? json["currency"].toString() : null,
      address_id : json["address_id"].toString(),
      // externalDeliveryPrice: json["deliveryPrice"],
      branch : json['branch'] != null ?  Branch.fromJson(json['branch']) : null,


    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_type'] = paymentType;
    data['receiving_type'] = receivingType;
    data['deliver_location_id'] = deliverLocationId;
    data['cart_id'] = cartId;
    data['volume_discount_id'] = discountid;
    data['branch_id'] = branchId;
    data['coupon_number'] = couponNumber;
    data['request_note'] = requestNote;
    data['status'] = status;
    data['delivery_price_id'] = deliveryPriceId;
    data['address_id'] = address_id;
    data['confirm'] = confirm;
    data['deliveryPrice']=deliveryPrice;
    data['added_price']=addedPrice;
    data['added_note']=addedNote;
    data['charge_id']=chargeId;
    data['delivery_pricing']=deliveryPricing;
    data['booking_date']=bookingDate;
    data['country_id']=countryId;
    data['currency']=currency;

    return data;
  }
}

class Branch {
  int? id;
  String? image;
  String? imageProviderPath;
  String? imagePath;
  String? imagePath150;
  String? imagePath64;
  String? name;
  ProviderDetailsData? providerDetailsData;

  Branch({this.id,
    this.image,
    this.imageProviderPath,
    this.imagePath,
    this.imagePath150,
    this.imagePath64,
    this.name,
    this.providerDetailsData
  });

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    image = json['image'];

    imageProviderPath = json['image_provider_path'];
    imagePath = json['image_path'];
    imagePath150 = json['image_path150'];
    imagePath64 = json['image_path64'];
    name = json['name'];
    providerDetailsData = json['provider'] != null
        ? ProviderDetailsData.fromJson(json['provider'])
        : null;
  }
}

class ProviderDetailsData {
  String? branchesCount;

  ProviderDetailsData({
    this.branchesCount,
  });

  ProviderDetailsData.fromJson(Map<String, dynamic> json) {
    branchesCount = json['branches_count'].toString();
  }
}

