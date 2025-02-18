//
// class NewDeliveryPriceData {
//   bool? success;
//   List<NewDeliveryPrice>? newDeliveryPrice;
//
//   NewDeliveryPriceData({this.success, this.newDeliveryPrice});
//
//   NewDeliveryPriceData.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['data'] != null) {
//       newDeliveryPrice = <NewDeliveryPrice>[];
//       json['data'].forEach((v) {
//         newDeliveryPrice!.add(  NewDeliveryPrice.fromJson(v));
//       });
//     }
//   }
//
//
// }

class NewDeliveryPrice {
  String? id;
  int? deliveryType;
  int? countryId;
  String? minimum;
  String? fixedDeliveryRate;

  NewDeliveryPrice(
      {this.id,
        this.deliveryType,
        this.countryId,
        this.minimum,
        this.fixedDeliveryRate});

  NewDeliveryPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    deliveryType = json['delivery_type'];
    countryId = json['country_id'];
    minimum = json['minimum'].toString();
    fixedDeliveryRate = json['fixed_delivery_rate'].toString();
  }



}

