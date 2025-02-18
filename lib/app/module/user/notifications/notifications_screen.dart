import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_lottie.dart';
import 'package:alalamia_spices/app/module/user/last_orders/widget/last_orders_shimmer.dart';
import 'package:alalamia_spices/app/module/user/notifications/notification_details_screen.dart';
import 'package:alalamia_spices/app/module/user/notifications/widget/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppAlertModel>(
      create: (context) => AppAlertModel(context),
      child: Consumer<AppAlertModel>(
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.surface,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                  child: const CustomAppBar(isNotifiScreen: true),
                ),
                body: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                        child: Text(
                          allTranslations.text("notifications"),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 22.sp),
                        ),
                      ),
                      3.ph,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                        child: Text(
                          allTranslations.text("notificationsSubTitle"),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      15.ph,
                      model.isLoading || model.loadingFailed
                          ? const Flexible(child: LastOrdersShimmer())
                          : Flexible(
                              child: model.items.isEmpty
                                  ? Center(
                                      child: CustomMessage(
                                        message: allTranslations.text("noData"),
                                        appLottieIcon: AppLottie.noData,
                                        repeat: false,
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: model.items.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NotificationDetailsScreen(
                                                            alert: model
                                                                .items[index],
                                                          )));
                                            },
                                            child: NotificationCard(
                                              alert: model.items[index],
                                            ));
                                      },
                                    ),
                            ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
