

class StatusData{
  final String? status,carrierPhone;
  final int? rated;
  final int? carrierId;
  StatusData({this.status,this.rated,this.carrierId,this.carrierPhone});
  factory StatusData.fromJson(Map<String, dynamic> json) {
    return StatusData(
        status: json["status"].toString(),
        rated: json["rated"],
        carrierId:json["carrier_id"] ?? 0,
        carrierPhone:json["carrier_phone"] ?? 'not'

    );
  }




}