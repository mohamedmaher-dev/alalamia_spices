import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/offers/widget/index.dart';
import 'package:alalamia_spices/app/module/offers/widget/offer_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/utils/constants.dart';


class OfferTab extends StatelessWidget {
   OfferTab({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var offersModel = Provider.of<OffersModel>(context);
    return Consumer<ConnectivityNotifier>(
        builder: (context , connection , child) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
              child: const CustomAppBar(
                  isHome : true
              ),
            ),
            body: ListView(
              children: [

                const OffersCarouselSliders(),
                5.ph,

                offersModel.isLoading || offersModel.loadingFailed
                    ? const OfferShimmer()
                    : offersModel.items.isNotEmpty
                        ? const OfferBody()
                        : CustomMessage(
                        message: allTranslations.text("noData"),
                        appLottieIcon: AppLottie.noData

                    )
              ],
            ),
            bottomNavigationBar: connection.hasConnection
                ? 0.ph
                : const NoInternetMessage(),
          );
        }
    );
  }
}


