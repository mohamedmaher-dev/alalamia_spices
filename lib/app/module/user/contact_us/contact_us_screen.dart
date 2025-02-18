
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/module/user/contact_us/common_question_screen.dart';
import 'package:alalamia_spices/app/module/user/contact_us/privacy__return_policy_screen.dart';
import 'package:alalamia_spices/app/module/user/contact_us/tax_registration_certificate.dart';
import 'package:alalamia_spices/app/module/user/contact_us/widget/contact_us_shimmer.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/utils/constants.dart';
import '../../../core/values/app_colors.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';


class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<SocialMediaModel>(
      create: (context) => SocialMediaModel(context),
      child: Consumer<SocialMediaModel> (
        builder: (context , model , child){
          model.getSocialLinks();
          return SafeArea(
            child: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.surface,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                  child: const CustomAppBar(),
                ),
                body: model.isLoading || model.loadingFailed
                    ? const ContactUsShimmer()
                    : Padding(
                  padding: EdgeInsets.all(10.0.w),
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        allTranslations.text("technicalSupport"),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp
                        ),
                      ),
                      10.ph,
                      Text(
                        allTranslations.text("technicalSupportSubTitle"),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      /// phone
                      20.ph,
                      ListView.separated(
                        itemCount: model.phone.length,
                        shrinkWrap: true,
                        primary: false,
                        separatorBuilder: (context , _) => 20.ph,
                        itemBuilder: (context , index){
                          return CustomCardIconText(
                              color: Theme.of(context).primaryColor,
                              icon: Icons.phone_android,
                              iconColor: Colors.grey,
                              height: 40.h,
                              width: 45.w,
                              itemsName: model.phone[index],
                              itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
                              secondIcon: Icons.arrow_forward_ios,
                              secondIconColor: Colors.grey,
                              onTap: () {
                                _launchURL(
                                    'tel:' + model.phone[index],
                                    "لا يمكن الوصول لهذا الرقم");
                              }
                          );
                        },

                      ),


                      /// telephone
                      20.ph,
                      ListView.separated(
                        itemCount: model.telephone.length,
                        shrinkWrap: true,
                        primary: false,
                        separatorBuilder: (context , _) => 20.ph,
                        itemBuilder: (context , index){
                          return CustomCardIconText(
                              color: Theme.of(context).primaryColor,
                              icon: Icons.phone,
                              iconColor: Colors.grey,
                              height: 40.h,
                              width: 45.w,
                              itemsName: model.telephone[index],
                              itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
                              secondIcon: Icons.arrow_forward_ios,
                              secondIconColor: Colors.grey,
                              onTap: () {
                                _launchURL(
                                    'tel:' + model.telephone[index],
                                    "لا يمكن الوصول لهذا الرقم");
                              }
                          );
                        },

                      ),


                      /// whatsApp
                      20.ph,
                      ListView.separated(
                        itemCount: model.whatsApp.length,
                        shrinkWrap: true,
                        primary: false,
                        separatorBuilder: (context , _) => 20.ph,
                        itemBuilder: (context , index){
                          return  CustomCardIconText(
                              color: AppColors.green,
                              icon: Icons.phone,
                              backIconColor: Colors.white24,
                              iconColor: AppColors.green,
                              secondIcon: Icons.arrow_forward_ios,
                              secondIconColor: Theme.of(context).primaryColor,
                              height: 40.h,
                              width: 45.w,
                              itemsName: model.whatsApp[index],
                              itemsNameStyle: Theme.of(context).textTheme.displayLarge,
                              onTap: () {
                                _launchURL(
                                    'https://api.whatsapp.com/send?phone=' +
                                        model.whatsApp[index],
                                    "لا يمكن الدخول الى واتساب");
                              }
                          );
                        },

                      ),

                      /// website
                      20.ph,
                      CustomCardIconText(
                          color: Theme.of(context).primaryColor,
                          icon: Icons.language,
                          iconColor: Colors.grey,
                          height: 40.h,
                          width: 45.w,
                          itemsName: "www.alalamiaspices.com",
                          itemsNameStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 12.sp,
                          ),
                          secondIcon: Icons.arrow_forward_ios,
                          secondIconColor: Colors.grey,
                          onTap: () {
                            _launchURL("https://www.alalamiaspices.com/", "لا يمكن الوصول الى الموقع");
                          }
                      ),



                      /// email
                      20.ph,
                      ListView.separated(
                        itemCount: model.email.length,
                        shrinkWrap: true,
                        primary: false,
                        separatorBuilder: (context , _) => 20.ph,
                        itemBuilder: (context , index){
                          return  CustomCardIconText(
                              color: Theme.of(context).primaryColor,
                              icon: Icons.mail,
                              iconColor: Colors.grey,
                              height: 40.h,
                              width: 45.w,
                              itemsName: model.email[index],
                              itemsNameStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 12.sp,
                              ),
                              secondIcon: Icons.arrow_forward_ios,
                              secondIconColor: Colors.grey,
                              onTap: () {
                                _launchURL(
                                    'mailto:' + model.email[index],
                                    "لا يمكن الدخول الى الايميل");
                              }
                          );
                        },

                      ),





                      /// privacy policy
                      20.ph,
                      CustomCardIconText(
                          color: Theme.of(context).primaryColor,
                          icon: Icons.privacy_tip,
                          iconColor: Colors.grey,
                          height: 40.h,
                          width: 45.w,
                          itemsName: allTranslations.text("privacyPolicy"),
                          itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
                          secondIcon: Icons.arrow_forward_ios,
                          secondIconColor: Colors.grey,
                          onTap: () {
                            pushScreen(context,  const PrivacyReturnPolicyScreen(
                              isPrivacyPolicy : true
                            ));
                          }
                      ),


                      /// return policy
                      20.ph,
                      CustomCardIconText(
                          color: Theme.of(context).primaryColor,
                          icon: Icons.keyboard_return,
                          iconColor: Colors.grey,
                          height: 40.h,
                          width: 45.w,
                          itemsName: allTranslations.text("returnPolicy"),
                          itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
                          secondIcon: Icons.arrow_forward_ios,
                          secondIconColor: Colors.grey,
                          onTap: () {
                            pushScreen(context, const PrivacyReturnPolicyScreen(isPrivacyPolicy: false));
                          }
                      ),


                      /// tax Registration Certificate


                      model.taxCertificate.isEmpty
                      ? 0.ph
                      : Padding(
                        padding:   EdgeInsets.only(top: 20.0.h),
                        child: CustomCardIconText(
                            color: Theme.of(context).primaryColor,
                            icon: Icons.insert_drive_file,
                            iconColor: Colors.grey,
                            height: 40.h,
                            width: 45.w,
                            itemsName: allTranslations.text("taxRegistrationCertificate"),
                            itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
                            secondIcon: Icons.arrow_forward_ios,
                            secondIconColor: Colors.grey,
                            onTap: () async{
                              // await _launchURL(
                              //     'https:' + model.taxCertificate[0],
                              //     "لا يمكن الدخول الى واتساب");

                              pushScreen(context, const TaxRegistrationCertificate());
                            }
                        ),
                      ),


                      /// common questions
                      20.ph,
                      CustomCardIconText(
                          color: Theme.of(context).primaryColor,
                          icon: Icons.info,
                          iconColor: Colors.grey,
                          height: 40.h,
                          width: 45.w,
                          itemsName: allTranslations.text("commonQuestions"),
                          itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
                          secondIcon: Icons.arrow_forward_ios,
                          secondIconColor: Colors.grey,
                          onTap: () {
                            pushScreen(context,   CommonQuestionScreen());
                          }
                      ),

                    ],
                  ),
                ),
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
