class CeilingPrice{
  String? price;
  CeilingPrice({this.price});

  factory CeilingPrice.fromJson(var json) {
    return CeilingPrice(
      price: json["data"],
    );
  }
}