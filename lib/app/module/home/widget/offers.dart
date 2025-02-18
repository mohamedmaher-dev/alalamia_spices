import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/global_widgets/custom_cached_network_image.dart';
import 'package:alalamia_spices/app/global_widgets/custom_rotated_box.dart';
import 'package:alalamia_spices/app/module/offers/offer_details_screen.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../offers/widget/offer_shimmer.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});

  // static final facebookAppEvents = FacebookAppEvents();

  @override
  Widget build(BuildContext context) {
    var offersModel = Provider.of<OffersModel>(context);
    return offersModel.isLoading || offersModel.loadingFailed
        ? const OfferShimmer()
        : offersModel.items.isEmpty
            ? 0.ph
            : SizedBox(
                height: 250.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.3),
                        height: 250.h,
                        child: CustomRotatedBox(
                          text: allTranslations.text("offers"),
                        )),
                    // 3.pw,
                    Expanded(
                      child: Container(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.3), //
                        padding: EdgeInsets.all(5.w),
                        child: ListView.builder(
                          itemCount: offersModel.items.length,
                          shrinkWrap: true,
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                pushScreen(
                                    context,
                                    OfferDetailsScreen(
                                      offers: offersModel.items[index],
                                    ));

                                // facebookAppEvents.logAddToWishlist(
                                //     id: offersModel.items[index].id.toString(),
                                //     type: 'offer',
                                //     currency: "RY",
                                //     price: double.parse(offersModel.items[index].price.toString())
                                // );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Container(
                                  height: 200.w,
                                  width: 200.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppConstants.defaultBorderRadius.w),
                                      color: Theme.of(context).primaryColor),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        AppConstants.defaultBorderRadius.w),
                                    child: CustomCachedNetworkImage(
                                      height: 200.w,
                                      width: 200.w,
                                      fit: BoxFit.fill,
                                      imageUrl:
                                          offersModel.items[index].imagePath,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
