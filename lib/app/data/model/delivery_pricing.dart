//
//
// class DeliveryPricingData {
//   List<DeliveryPricing>? deliveryPricing;
//   DeliveryPricingData({this.deliveryPricing});
//   factory DeliveryPricingData.fromJson(var json) {
//     var list = json['data'] as List;
//     List<DeliveryPricing> priceList = list.map((i) => DeliveryPricing.fromJson(i)).toList();
//     return DeliveryPricingData(
//         deliveryPricing: priceList);
//   }
// }
//
// class DeliveryPricing {
//   String? id, price;
//   DeliveryPricing({this.id, this.price});
//
//   factory DeliveryPricing.fromJson(Map<String, dynamic> json) {
//     return DeliveryPricing(
//       id: json["id"].toString(),
//       price: json["price"],
//     );
//   }
//
//
//
// }