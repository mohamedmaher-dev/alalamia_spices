
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/values/app_colors.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import '../../../../global_widgets/custom_card_icon_text.dart';


class ContactUsShimmer extends StatelessWidget {
  const ContactUsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.25),
      highlightColor: Colors.white.withOpacity(0.6),
      child:  Padding(
        padding: EdgeInsets.all(10.0.w),
        child: ListView(
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
            20.ph,

            /// phone
            CustomCardIconText(
                color: Theme.of(context).primaryColor,
                icon: Icons.phone,
                iconColor: Colors.grey,
                height: 40.h,
                width: 45.w,
                itemsName: "+96777128028",
                itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
                secondIcon: Icons.arrow_forward_ios,
                secondIconColor: Colors.grey,
                onTap: () {

                }
            ),

            /// phone
            20.ph,
            CustomCardIconText(
                color: Theme.of(context).primaryColor,
                icon: Icons.phone,
                iconColor: Colors.grey,
                height: 40.h,
                width: 45.w,
                itemsName: "+967776702207",
                itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
                secondIcon: Icons.arrow_forward_ios,
                secondIconColor: Colors.grey,
                onTap: () {

                }
            ),


            /// whatsapp
            20.ph,
            CustomCardIconText(
                color: AppColors.green,
                icon: Icons.phone,
                backIconColor: Colors.white24,
                iconColor: AppColors.green,
                secondIcon: Icons.arrow_forward_ios,
                secondIconColor: Theme.of(context).primaryColor,
                height: 40.h,
                width: 45.w,
                itemsName: "+967776702207",
                itemsNameStyle: Theme.of(context).textTheme.displayLarge,
                onTap: () {

                }
            ),


            /// whatsapp
            20.ph,
            CustomCardIconText(
                color: AppColors.green,
                icon: Icons.phone,
                backIconColor: Colors.white24,
                iconColor: AppColors.green,
                secondIcon: Icons.arrow_forward_ios,
                secondIconColor: Theme.of(context).primaryColor,
                height: 40.h,
                width: 45.w,
                itemsName: "+967777128028",
                itemsNameStyle: Theme.of(context).textTheme.displayLarge,
                onTap: () {

                }
            ),


            /// email
            20.ph,
            CustomCardIconText(
                color: Theme.of(context).primaryColor,
                icon: Icons.mail,
                iconColor: Colors.grey,
                height: 40.h,
                width: 45.w,
                itemsName: "mohammedfouad@gmail.com",
                itemsNameStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12.sp,
                ),
                secondIcon: Icons.arrow_forward_ios,
                secondIconColor: Colors.grey,
                onTap: () {

                }
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

                }
            ),


            /// tax Registration Certificate
            20.ph,
            CustomCardIconText(
                color: Theme.of(context).primaryColor,
                icon: Icons.insert_drive_file,
                iconColor: Colors.grey,
                height: 40.h,
                width: 45.w,
                itemsName: allTranslations.text("taxRegistrationCertificate"),
                itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
                secondIcon: Icons.arrow_forward_ios,
                secondIconColor: Colors.grey,
                onTap: () {

                }
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

                }
            ),


          ],
        ),
      ),
    );
  }
}
