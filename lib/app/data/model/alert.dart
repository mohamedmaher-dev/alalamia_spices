

class AlertData {
  List<Alert>? alert;
  AlertData({this.alert});
  factory AlertData.fromJson(var json) {
    var list = json['data'] as List;
    List<Alert> alertList = list.map((i) => Alert.fromJson(i)).toList();
    return AlertData(
        alert: alertList
    );
  }
}


class Alert {
  final String? id, title, content,imagePath;
  final bool? isActive;
  final String? startDate;
  final String? endDate;
  Alert(
      {this.id,
        this.title,
        this.content,
        this.isActive,
        this.imagePath,
        this.startDate,
        this.endDate

      });
  factory Alert.fromJson(Map<String, dynamic> parsedJson) {
    return Alert(
        id: parsedJson["id"].toString(),
        title: parsedJson['title'],
        content: parsedJson['content'],
        isActive: parsedJson['active'],
        imagePath: parsedJson['image_path'],
        startDate: parsedJson['start_date'],
        endDate: parsedJson['end_date'],

    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data["id"]= id;
    data["title"]= title;
    data["content"]= content;
    data["active"]= isActive;
    data["image_path"]= imagePath;
    return data;
  }
}