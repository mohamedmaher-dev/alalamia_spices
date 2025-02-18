


import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/utils/url.dart';
import '../../module/app_config/app_config_screen.dart';

class SocialMediaModel extends QueryModel {
  SocialMediaModel(super.context);


  late List _phone ;
  late List _whatsApp ;
  String  _whatsApp2 ='';
  late List _telephone ;
  late List _email;
  late String _youtube, _twitter, _facebook, _instagram , _tiktok , _taxCertificate;


  List get phone => _phone;
  List get whatsApp => _whatsApp;
  String get whatsApp2 => _whatsApp2;
  List get telephone => _telephone;
  List get email => _email;

  String get youtube => _youtube;
  String get twitter => _twitter;
  String get facebook => _facebook;
  String get instagram => _instagram;
  String get tiktok => _tiktok;
  String get taxCertificate => _taxCertificate;


  @override
  Future loadData([BuildContext? context]) async {
    var data;
    if(appModel.token != ''){
      try{

        data = await fetchDataa(
            appModel.token == "visitor"
                ? "${AppUrl.socialMediaVisitor}?country_id=$countryId"
                : AppUrl.socialMedia, "");


      }catch (error) {
        if (kDebugMode) {
          print("socialMedia catch error$error");
        }
      }

      if(data != null){
        SocialMediaData socialMediaData = SocialMediaData.fromJson(data);
        List socialMediaList = socialMediaData.socialMedia!;
        items.addAll(socialMediaList);

        finishLoading();

        // if (kDebugMode) {
        //   print ("=====socialMedia model=====$data");
        //   print ("=====socialMedia api url ===== ${AppUrl.socialMediaVisitor}?country_id=$countryId");
        // }
      }
    }


  }
  SocialMedia get socialMedia => items[0];


  void getSocialLinks () async{

    _phone = [];
    _whatsApp = [];
    _telephone = [];
    _email = [];
    _youtube = "";
    _facebook = "";
    _twitter = "";
    _instagram = "";
    _tiktok = "";
    _taxCertificate = "";

    for (var i = 0; i < items.length; i++) {
      if (items[i].mediaType == "phone") {
        _phone.add(items[i].media);
      }
      if (items[i].mediaType == "whats_app") {
        // prefs.setString("wh", items[i].media[0].toString());
        _whatsApp.add(items[i].media);
      }
      if (items[i].mediaType == "telephone") {
        _telephone.add(items[i].media);
      }
      if (items[i].mediaType == "email") {
        _email.add(items[i].media);
      }
      if (items[i].mediaType == "YouTube") {
        _youtube = items[i].media;
      }
      if (items[i].mediaType == "twitter") {
        _twitter = items[i].media;
      }
      if (items[i].mediaType == "Facebook") {
        _facebook = items[i].media;
      }
      if (items[i].mediaType == "Instagram") {
        _instagram = items[i].media;
      }
      if (items[i].mediaType == "TikTok") {
        _tiktok = items[i].media;
      }

      if (items[i].mediaType == "TaxCertificate") {
        _taxCertificate = items[i].media;
      }
    }
  }

  // getWhatsApp() async{
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _whatsApp2 = prefs.getString("wh") ?? '';
  // }
}