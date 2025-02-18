

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_icons.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import '../core/values/app_colors.dart';

class DraggableFloatingButton extends StatelessWidget {
   const DraggableFloatingButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SocialMediaModel>(
      create: (context) => SocialMediaModel(context),
      child: Consumer<SocialMediaModel>(
        builder: (context , model , child){
          model.getSocialLinks();
          // model.getWhatsApp();

          return  model.isLoading || model.loadingFailed
              ? 0.ph
              : DraggableFab(
            child: FloatingActionButton(
              mini: false,
              backgroundColor: AppColors.green,
              tooltip: "Whatsapp contact",
              onPressed: () {
                // print("wwwwwwwwww ${model.whatsApp2}");
                _launchURL(
                    'https://api.whatsapp.com/send?phone=' +
                        model.whatsApp[0],
                    "لا يمكن الدخول الى واتساب");
              },
              child:  Image.asset(
                AppIcons.whatsapp,
                color: Colors.white,
                width: 30.w,
                height: 30.h,

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
