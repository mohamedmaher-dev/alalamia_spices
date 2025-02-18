
class CommonQuestionData {
  List<CommonQuestion>? commonQuestions;

  CommonQuestionData({this.commonQuestions});

  factory CommonQuestionData.fromJson(Map<String, dynamic> json) {

    var list = json['data'] as List;
    List<CommonQuestion> commonQuestionList = list.map((i) => CommonQuestion.fromJson(i)).toList();
    return CommonQuestionData(commonQuestions: commonQuestionList,);

  }


}

class CommonQuestion {
  int? id;
  String? answer;
  String? question;

  CommonQuestion({this.id, this.answer, this.question});

  factory CommonQuestion.fromJson(Map<String, dynamic> json) {
    return CommonQuestion (
        id : json['id'],
        answer : json['answer'],
        question : json['question'],
    );

  }


}

