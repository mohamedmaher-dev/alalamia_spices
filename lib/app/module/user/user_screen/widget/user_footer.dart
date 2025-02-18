

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_images.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/values/app_icons.dart';

class UserFooter extends StatelessWidget {
  const UserFooter({Key? key}) : super(key: key);


  _infiniteURL() async {
    const url = 'https://www.infinitecloud.co/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'لا يمكن الدخول الى الصفحة';
    }
  }

  Widget _buildSocialIcon(
      {required BuildContext context, required String icon, required GestureTapCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.0.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
            color: Theme.of(context).primaryColor
        ),
        child: Image.asset(
          icon,
          width: 25.w,
          height: 25.h,
          color: Theme.of(context).secondaryHeaderColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SocialMediaModel(context)),
      ],
      child: Consumer<SocialMediaModel>(
        builder: (context , socialMediaModel , child){
          socialMediaModel.getSocialLinks();
          return Padding(
            padding: EdgeInsets.all(10.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// social media links
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildSocialIcon(
                        context : context,
                        icon : AppIcons.facebook,
                        onTap: (){
                          _launchURL(socialMediaModel.facebook, "لا يمكن الدخول الى فيسبوك");
                        }
                    ),

                    _buildSocialIcon(
                        context : context,
                        icon : AppIcons.twitter,
                        onTap: (){
                          _launchURL(socialMediaModel.twitter, "لا يمكن الدخول الى تويتر");
                        }
                    ),

                    _buildSocialIcon(
                        context : context,
                        icon : AppIcons.instagram,
                        onTap: (){
                          _launchURL(socialMediaModel.instagram, "لا يمكن الدخول الى إنستغرام");
                        }
                    ),

                    _buildSocialIcon(
                        context : context,
                        icon : AppIcons.youtube,
                        onTap: (){
                          _launchURL(socialMediaModel.youtube, "لا يمكن الدخول الى يوتيوب");
                        }
                    ),

                    _buildSocialIcon(
                        context : context,
                        icon : AppIcons.tiktok,
                        onTap: (){
                          _launchURL(socialMediaModel.tiktok, "لا يمكن الدخول الى تيك توك");
                        }
                    ),

                  ],
                ),


                10.ph,
                // 20.ph,
                // Text(
                //   allTranslations.text("aboutAlalamiaAndApp"),
                //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                //       fontWeight: FontWeight.bold
                //   ),
                // ),
                //
                // 10.ph,
                // Align(
                //   alignment: allTranslations.currentLanguage == "ar"
                //    ? Alignment.centerRight
                //    : Alignment.centerLeft,
                //   child: HtmlWidget(
                //     contentModel.aboutMatjer.toString(),
                //     renderMode: RenderMode.column,
                //     textStyle: Theme.of(context).textTheme.bodyLarge,
                //     customStylesBuilder: (element) {
                //       if (element != null && themeModel.darkTheme == true){
                //         return {'color': 'white'};
                //       }
                //
                //     },
                //   ),
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        allTranslations.text('builtWith'),
                        style: Theme.of(context).textTheme.bodySmall
                    ),
                    5.pw,
                    Icon(
                      Icons.favorite ,
                      color: Theme.of(context).colorScheme.secondary ,
                      size:  18,),
                    5.pw,
                    Text(
                      allTranslations.text('by'),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    10.pw,
                    InkWell(
                        onTap: () => _infiniteURL(),
                        child: Image.asset(
                          themeModel.darkTheme == false
                           ? AppImages.companyLogo
                           : AppImages.companyLogoDark ,
                            width: themeModel.darkTheme == false
                                ? 50.w
                                : 80.w,
                            height: themeModel.darkTheme == false
                                ? 50.h
                                : 80.h,
                        )
                    )
                  ],
                )

              ],
            ),
          );
        },
      ),
    );
  }
  _launchURL(url, msg) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url),
     mode: LaunchMode.externalApplication);
    } else {
      throw msg;
    }
  }
}
