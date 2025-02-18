

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/global_widgets/circular_loading.dart';
import 'package:alalamia_spices/app/global_widgets/custom_app_bar.dart';
import 'package:alalamia_spices/app/global_widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import 'package:alalamia_spices/app/exports/provider.dart';

class TaxRegistrationCertificate extends StatelessWidget {
  const TaxRegistrationCertificate ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SocialMediaModel>(
      create: (context) => SocialMediaModel(context),
      child: Consumer<SocialMediaModel>(
        builder: (context , model , child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor:  Theme.of(context).colorScheme.surface,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                child: const CustomAppBar(),
              ),
              body: ListView(

                children: [

                  Padding(
                    padding: EdgeInsets.all(15.0.h),
                    child: Text(
                       allTranslations.text("taxRegistrationCertificate"),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp
                      ),
                    ),
                  ),

                  20.ph,
                  model.isLoading || model.loadingFailed
                  ? const CircularLoading()
                  : Container(
                    padding:  EdgeInsets.all(10.0.w),
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.only(
                          topLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
                          topRight: Radius.circular(AppConstants.defaultBorderRadius.w)
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: CustomCachedNetworkImage(
                        imageUrl: model.socialMedia.mediaType == "TaxCertificate"
                            ? model.socialMedia.media.toString()
                            : "",
                      fit: BoxFit.fitHeight,
                    ),
                  )
                ],
              ),
            ),
          );

        },
      ),
    );
  }
}

