import 'new_arrival.dart';

class MostSellData {
  List<Product>? product;

  MostSellData({this.product});

  factory MostSellData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Product> productList = list.map((i) => Product.fromJson(i)).toList();
    return MostSellData(product: productList,);
  }


}