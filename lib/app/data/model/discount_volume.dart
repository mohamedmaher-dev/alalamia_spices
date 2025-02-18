


class DiscountData {
  List<DiscountVolume>? discount;
  DiscountData({this.discount});
  factory DiscountData.fromJson(var json) {
    var list = json['data'] as List;
    List<DiscountVolume> discList = list.map((i) => DiscountVolume.fromJson(i)).toList();
    return DiscountData(
        discount: discList);
  }
}

class DiscountVolume {
  String? priceFrom,priceTo, value, valueType,id , type;
  DiscountVolume({this.priceFrom, this.priceTo, this.value,this.valueType,this.id , this.type});
  factory DiscountVolume.fromJson(Map<String, dynamic> json) {
    return DiscountVolume(
      id: json["id"].toString(),
      priceFrom: json["price_from"],
      priceTo: json["price_to"] ?? "",
      value: json["value"],
      valueType: json["value_type"],
      type: json["type"],
    );
  }
}