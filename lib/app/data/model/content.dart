
class ContentData {
  List<Content>? content;

  ContentData({this.content});

  factory ContentData.fromJson(Map<String, dynamic> json) {

    var list = json['data'] as List;
    List<Content> contentList = list.map((i) => Content.fromJson(i)).toList();
    return ContentData(content: contentList,);

  }

}

class Content {
  int? id;
  String? theShop;
  String? returnPolicy;
  String? privacyPolicy;

  Content({this.id, this.theShop, this.returnPolicy, this.privacyPolicy});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
        id : json['id'],
        theShop : json['the_shop'],
        returnPolicy : json['return_policy'],
        privacyPolicy : json['privacy_policy'],
    );

  }


}

