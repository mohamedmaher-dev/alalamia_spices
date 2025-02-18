import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/global_widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/constants.dart';
import '../../../global_widgets/custom_app_bar.dart';
import 'package:alalamia_spices/app/exports/model.dart';


class NotificationDetailsScreen extends StatelessWidget {
  final Alert alert;
  const NotificationDetailsScreen({
    Key? key,
    required this.alert
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize:Size.fromHeight(AppConstants.appBarHeight.h),
          child: const CustomAppBar(),
        ),
        body: ListView(

          children: [
            Divider(color:  Theme.of(context).colorScheme.surface,),
            SizedBox(
                height: 250.h,
                width: MediaQuery.of(context).size.width,
                child: CustomCachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: alert.imagePath.toString(),
                )
            ),


            Container(
              color: Theme.of(context).primaryColor,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color:  Theme.of(context).colorScheme.surface,),
                  20.ph,

                  Text(
                    alert.title.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  30.ph,
                  Divider(color:  Theme.of(context).colorScheme.surface,),
                  Text(
                    alert.content.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  10.ph,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
