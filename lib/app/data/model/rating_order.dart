class RatingOrderData {
  String? requestId, carrierId, comment,branch_id;
  List<Rate>? details;
  RatingOrderData(
      {this.requestId, this.carrierId, this.comment, this.details,this.branch_id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.requestId;
    data['carrier_id'] = this.carrierId;
    data['comment'] = this.comment;
    data['branch_id'] = this.branch_id;
    data['details'] = this.details;
    return data;
  }
}

class Rate {
  final String? id;
  final String? name, rate;
  Rate({this.id, this.name, this.rate});

  factory Rate.fromJson(Map<String, dynamic> json) {
    return Rate(
      id: json["id"].toString(),
      name: json["name"],

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['rate_type_id'] = this.id;
    data['rate'] = this.rate;

    return data;
  }
}
