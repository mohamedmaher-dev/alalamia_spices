// class AdsPopupData {
//   final List<AdsPopup>? adsPopup;
//
//   AdsPopupData({this.adsPopup});
//
//   factory AdsPopupData.fromJson(var json) {
//     var list = json['data'] as List;
//     List<AdsPopup> adsPopupList = list.map((i) => AdsPopup.fromJson(i)).toList();
//     return AdsPopupData(
//       adsPopup: adsPopupList,
//     );
//   }
// }
//
//
// class AdsPopup {
//
//   final String? adsPopupImg,id;
//   AdsPopup({this.adsPopupImg,this.id});
//
//   factory AdsPopup.fromJson(Map<String, dynamic> json) {
//     return AdsPopup(
//       adsPopupImg: json["image_path"],
//       id: json["id"].toString(),
//     );
//   }
// }


class AdsPopupData {
  bool? success;
  List<AdsPopup>? adsPopup;

  AdsPopupData({this.success, this.adsPopup});

  AdsPopupData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      adsPopup = <AdsPopup>[];
      json['data'].forEach((v) {
        adsPopup!.add( AdsPopup.fromJson(v));
      });
    }
  }


}

class AdsPopup {
  String? id;
  String? countryId;
  String? countryName;
  String? endDate;
  String? type;
  String? imagePath;
  String? image;
  String? advertisementableId;
  String? desc;
  String? clickType;
  var clickTo;

  AdsPopup(
      {this.id,
        this.countryId,
        this.countryName,
        this.endDate,
        this.type,
        this.imagePath,
        this.image,
        this.advertisementableId,
        this.desc,
        this.clickType,
        this.clickTo});

  AdsPopup.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    countryId = json['country_id'].toString();
    countryName = json['country_name'];
    endDate = json['end_date'];
    type = json['type'];
    imagePath = json['image_path'];
    image = json['image'];
    advertisementableId = json['advertisementable_id'].toString();
    desc = json['desc'];
    clickType = json['click_type'];
    clickTo = json['click_to'];
  }


}

