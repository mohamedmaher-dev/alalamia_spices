
class ViewData{
  final View? view ;

  ViewData({this.view});

  factory ViewData.fromJson(var json){
    return ViewData(
      view: View.fromJson(json['data'])
    );
  }
}
class View {

  final List<ViewItem>? products;

  View({
      this.products,
     });

  factory View.fromJson(Map<String, dynamic> json) {
    var listOfProduct = json["view_product_items"] as List;
    List<ViewItem> productList =
        listOfProduct.map((i) => ViewItem.fromJson(i)).toList();


    return View(
        products: productList,
      );
  }
}
class ViewItem {
   String? click_type, number, text,statisticable_id,id;

  ViewItem({this.click_type, this.number, this.text, this.statisticable_id,this.id});
  factory ViewItem.fromJson(var json) {
    return ViewItem(
      click_type: json["click_type"],
      number: json["number"],
      text: json["text"],
      statisticable_id: json["statisticable_id"],
      id: json["id"].toString(),
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['click_type'] = this.click_type;
    data['number'] = this.number;
    data['text'] = this.text;
    data['statisticable_id'] = this.statisticable_id;
    return data;
  }
}




