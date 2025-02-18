
class Coupon {
  String? price, startDate, endDate,valueType;
  int? id;
  String? productId;
  Coupon({this.id, this.price, this.startDate, this.endDate,this.valueType , this.productId});
  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json["id"],
      productId: json["product_id"],
      price: json["price"],
      startDate: json["start_date"],
      endDate: json["end_date"],
      valueType: json["value_type"],
    );
  }
}


// class CouponData {
//   bool? success;
//   Coupon? coupon;
//
//   CouponData({this.success, this.coupon});
//
//   CouponData.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     coupon = json['data'] != null ?   Coupon.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =   Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.coupon != null) {
//       data['data'] = this.coupon!.toJson();
//     }
//     return data;
//   }
// }
//
// class Coupon {
//   int? id;
//   int? countryId;
//   int? isApproved;
//   int? customizeCoupon;
//   int? productId;
//   String? number;
//   String? price;
//   String? valueType;
//   String? startDate;
//   String? endDate;
//
//   Coupon(
//       {this.id,
//         this.countryId,
//         this.isApproved,
//         this.customizeCoupon,
//         this.productId,
//         this.number,
//         this.price,
//         this.valueType,
//         this.startDate,
//         this.endDate});
//
//   Coupon.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     countryId = json['country_id'];
//     isApproved = json['is_approved'];
//     customizeCoupon = json['customize_coupon'];
//     productId = json['product_id'];
//     number = json['number'];
//     price = json['price'];
//     valueType = json['value_type'];
//     startDate = json['start_date'];
//     endDate = json['end_date'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['country_id'] = this.countryId;
//     data['is_approved'] = this.isApproved;
//     data['customize_coupon'] = this.customizeCoupon;
//     data['product_id'] = this.productId;
//     data['number'] = this.number;
//     data['price'] = this.price;
//     data['value_type'] = this.valueType;
//     data['start_date'] = this.startDate;
//     data['end_date'] = this.endDate;
//     return data;
//   }
// }

