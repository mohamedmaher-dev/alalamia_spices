class SocialMediaData {
  bool? success;
  List<SocialMedia>? socialMedia;

  SocialMediaData({this.success, this.socialMedia});

  SocialMediaData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      socialMedia = <SocialMedia>[];
      json['data'].forEach((v) {
        socialMedia!.add( SocialMedia.fromJson(v));
      });
    }
  }



}

class SocialMedia {
  int? id;
  int? countryId;
  String? mediaType;
  String? media;

  SocialMedia({this.id, this.countryId, this.mediaType, this.media});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    mediaType = json['media_type'];
    media = json['medias'];
  }

}

