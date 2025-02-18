

class Suggestions {
  String? text,branchId;
  Suggestions({this.text,this.branchId});

  factory Suggestions.fromJson(Map<String, dynamic> json) {
    return Suggestions(
      text: json["text"], branchId: json["branch_id"],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['branch_id'] = this.branchId;
    return data;
  }
}