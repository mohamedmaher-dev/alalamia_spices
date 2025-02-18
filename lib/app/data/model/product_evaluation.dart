class ProductEvaluationData {
  bool? success;
  List<ProductEvaluation>? productEvaluation;

  ProductEvaluationData({this.success, this.productEvaluation});

  ProductEvaluationData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      productEvaluation = <ProductEvaluation>[];
      json['data'].forEach((v) {
        productEvaluation!.add(  ProductEvaluation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = this.success;
    if (this.productEvaluation != null) {
      data['data'] = this.productEvaluation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductEvaluation {
  String? id;
  String? rate;
  String? comment;
  String? userName;

  ProductEvaluation({this.id, this.rate, this.comment, this.userName});

  ProductEvaluation.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    rate = json['rate'].toString();
    comment = json['comment'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rate'] = this.rate;
    data['comment'] = this.comment;
    data['user_name'] = this.userName;
    return data;
  }
}

