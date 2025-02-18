class AdvertisementSliderData {
  bool? success;
  List<AdvertisementSlider>? advertisementSlider;

  AdvertisementSliderData({this.success, this.advertisementSlider});

  AdvertisementSliderData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      advertisementSlider = <AdvertisementSlider>[];
      json['data'].forEach((v) {
        advertisementSlider!.add(  AdvertisementSlider.fromJson(v));
      });
    }
  }


}

class AdvertisementSlider {
  String? id;
  String? endDate;
  String? type;
  String? imagePath;
  String? image;
  String? desc;
  String? slideNumber;
  int? advertisementableId;
  String? clickType;
  var clickTo;

  AdvertisementSlider(
      {this.id,
        this.endDate,
        this.type,
        this.imagePath,
        this.image,
        this.desc,
        this.slideNumber,
        this.advertisementableId,
        this.clickType,
        this.clickTo});

  factory AdvertisementSlider.fromJson(Map<String, dynamic> json) {
    return AdvertisementSlider(
    id : json['id'].toString(),
    endDate : json['end_date'],
    type : json['type'],
    imagePath : json['image_path'],
    image : json['image'],
    desc : json['desc'],
    slideNumber : json['slide_number'].toString(),
    advertisementableId : json['advertisementable_id'],
    clickType : json['click_type'] != null ? json['click_type'] : null,
    clickTo : json['click_to'],
    );
  }

}

