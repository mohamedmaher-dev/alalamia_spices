
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../alalamiah_app.dart';
import '../core/utils/constants.dart';
import '../core/values/app_images.dart';
import 'package:alalamia_spices/app/exports/provider.dart';



class LanguageBottomSheet {

  Future<void> showLanguageBottomSheet ({required BuildContext context}) async{
    final translationProvider = Provider.of<GlobalTranslations>(context, listen: false);
    final userModel = Provider.of<UserModel>(context, listen: false)..getUserInfo();
    final String language = allTranslations.currentLanguage;
    // final String buttonText = language == 'ar' ? 'العربية' : 'العربية';
    // final String buttonText1 = language == 'ar' ? 'English' : 'English';
    bool isSwitchedArabic = language == 'ar' ? true : false;
    bool isSwitchedEnglish = language == 'en' ? true : false;


    await showModalBottomSheet(

        context: context,
        elevation: 0.3,
        isScrollControlled: true,
        enableDrag: true,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppConstants.defaultBorderRadius.w)
          ),
        ),
        builder: (context) {
          return StatefulBuilder(
            builder: (context , mySetState){
              return Padding(
                  padding: EdgeInsets.all(10.0.w),
                  child: Wrap(
                    // spacing: 20.h,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runSpacing: 10.0.h,
                    runAlignment: WrapAlignment.spaceBetween,
                    children: [

                      BottomSheetHeader(title: allTranslations.text("language"), subTitle: allTranslations.text("choosePreferredLanguage")),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                          // border: Border.all(
                          //     color: isSwitchedArabic
                          //         ? Theme.of(context).secondaryHeaderColor
                          //         : isSwitchedEnglish
                          //         ? Theme.of(context).secondaryHeaderColor
                          //         : Colors.transparent
                          // )
                        ),
                        child: RadioListTile(
                          value: isSwitchedArabic ,   //isSwitchedArabic,
                          groupValue: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if(userModel.userCountry == "الإمارات - UAE")
                              Image.asset(
                                AppImages.unitedArabEmirates,
                                width: 30.w,
                                height: 30.h,
                              )
                              else
                              Image.asset(
                                  AppImages.saudiArabia,
                                  width: 30.w,
                                  height: 30.h,
                                ),
                              20.pw,
                              Text(
                                allTranslations.text("arabicLanguage"),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),

                          onChanged: (value) async{
                            await translationProvider.setNewLanguage('ar', true);
                            await MaterialAppWithTheme.restartApp(context);
                            mySetState(() {
                              value = !value!;
                            });


                          },
                          activeColor: Theme.of(context).colorScheme.secondary,
                          selected: isSwitchedArabic,
                        ),
                      ),
                      10.ph,
                      /// english
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                          // border: isSwitchedArabic ? Border.all(color: Theme.of(context).secondaryHeaderColor) : null
                        ),
                        child: RadioListTile(
                          value: isSwitchedEnglish,
                          groupValue: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.englishLanguageImage,
                                width: 30.w,
                                height: 30.h,
                              ),
                              20.pw,
                              Text(
                                allTranslations.text("englishLanguage"),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          onChanged: (value) async{
                            await translationProvider.setNewLanguage('en', true);
                            await MaterialAppWithTheme.restartApp(context);
                            mySetState(() {
                              value = !value!;
                            });
                          },
                          activeColor: Theme.of(context).colorScheme.secondary,
                          selected: isSwitchedEnglish,
                        ),
                      ),

                      20.ph,

                      // CustomButtons(
                      //   height: 40.h,
                      //   text: allTranslations.text("save"),
                      //   buttonColor: Theme.of(context).secondaryHeaderColor,
                      //   onTap: () async {
                      //     // await AlalmiaApp.restartApp(context);
                      //     Navigator.pop(context);
                      //     // if (isSwitchedEnglish) {
                      //     //   await provider1.setNewLanguage('en', true);
                      //     //   if (appModel.token != '' ) {
                      //     //     await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Start()));
                      //     //   }
                      //     //
                      //     //   else {
                      //     //     Navigator.of(context).pushReplacement(
                      //     //         MaterialPageRoute(
                      //     //             builder: (context) => OnBoardingScreen()));
                      //     //   }
                      //     // }
                      //     //
                      //     // else {
                      //     //   await provider1.setNewLanguage('ar', true);
                      //     //   if (appModel.token != '' ) {
                      //     //     await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Start()));
                      //     //   }
                      //     //   else {
                      //     //     Navigator.of(context).pushReplacement(
                      //     //         MaterialPageRoute(
                      //     //             builder: (context) => OnBoardingScreen()));
                      //     //   }
                      //     // }
                      //
                      //   },
                      // )
                    ],
                  )
              );
            },
          );
        });
  }

}