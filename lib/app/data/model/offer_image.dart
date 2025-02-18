class OfferImageData {
  bool? success;
  List<OfferImage>? offerImage;

  OfferImageData({this.success, this.offerImage});

  OfferImageData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      offerImage = <OfferImage>[];
      json['data'].forEach((v) {
        offerImage!.add( OfferImage.fromJson(v));
      });
    }
  }


}

class OfferImage {
  int? id;
  int? offerId;
  String? image;
  String? imagePath;


  OfferImage(
      {this.id,
        this.offerId,
        this.image,
        this.imagePath,

      });

  OfferImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offerId = json['offer_id'];
    image = json['image'];
    imagePath = json['image_path'];
  }


}

