class Note {
  int? id;
  int? status;
  int? countryId;
  String? startDate;
  String? endDate;
  bool? active;
  String? message;

  Note(
      {this.id,
        this.status,
        this.countryId,
        this.startDate,
        this.endDate,
        this.active,
        this.message});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    countryId = json['country_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    active = json['active'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['country_id'] = this.countryId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['active'] = this.active;
    data['message'] = this.message;
    return data;
  }
}

