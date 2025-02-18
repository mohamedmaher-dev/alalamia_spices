import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:like_button/like_button.dart';
import '../core/values/app_images.dart';
import '../data/model/new_arrival.dart';
import '../module/product_details/providers/product_details_provider.dart';
import 'custom_cached_network_image.dart';
import 'package:alalamia_spices/app/exports/provider.dart';

import 'custom_toast.dart';

class CustomProductCard extends StatelessWidget {
  final GestureTapCallback onTap;
  final String name;
  final String image;
  final String? firstPrice;
  final String? currency;
  final String? oldPrice;
  final String? discount;
  final bool? status;
  final String? overallAssessment;
  final String? numberResidents;
  final bool isNewProduct;
  final bool isMostSellingProduct;
  final LikeButtonTapCallback onTapFavorite;
  final IconData favoriteIcon;
  final Color favoriteIconColor;
  final Product product;
  final int index;

  const CustomProductCard(
      {super.key,
      required this.onTap,
      required this.name,
      required this.firstPrice,
      required this.image,
      this.currency,
      this.oldPrice,
      this.discount,
      this.status,
      this.overallAssessment,
      this.numberResidents,
      required this.isNewProduct,
      required this.isMostSellingProduct,
      required this.onTapFavorite,
      required this.favoriteIcon,
      required this.favoriteIconColor,
      required this.product,
      required this.index});

  @override
  Widget build(BuildContext context) {
    ProductDetailsProvider productDetailsProvider = ProductDetailsProvider();
    // final facebookAppEvents = FacebookAppEvents();
    String? extractedString;
    List<String> selectedAdds = [];

    var pricesList = product.prices!
        .where((element) =>
            element.paidAdds == "false" || element.paidAdds == null)
        .toList();
    var paidAddsList =
        product.prices!.where((element) => element.paidAdds == "true").toList();

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        child: Container(
          height: 220.h,
          width: 167.w,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(AppConstants.defaultBorderRadius.w),
            color: Theme.of(context).primaryColor, // white color
          ),
          child: Stack(
            children: [
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  /// image
                  Padding(
                    padding: EdgeInsets.only(top: 25.h),
                    child: SizedBox(
                        height: 220.h,
                        width: 167.w,
                        child: CustomCachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: image,
                        )),
                  ),

                  10.ph,

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /// name

                        Text(name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "cairo")),

                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: oldPrice != '' ? 0.0.h : 10.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: oldPrice != '' ? 117.w : null,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    /// first price
                                    Column(
                                      children: [
                                        if (pricesList.length > 1)
                                          Text('يبدأ من'),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text("$firstPrice",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: "cairo",
                                                        fontSize: 14.sp)),
                                            2.pw,
                                            Center(
                                              child: Text("$currency",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: "cairo",
                                                          fontSize: 10.sp)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    oldPrice != ''
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text("$oldPrice",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: "cairo",
                                                          fontSize: 12.sp)),
                                              2.pw,
                                              Center(
                                                child: Text("$currency",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily: "cairo",
                                                            fontSize: 8.sp)),
                                              ),
                                            ],
                                          )
                                        : 0.ph,
                                  ],
                                ),
                              ),
                              oldPrice != ''
                                  ? Text(
                                      "${allTranslations.text("discountPercentage")} \n $discount",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: Colors.red,
                                              fontFamily: "cairo"))
                                  : 0.ph,
                            ],
                          ),
                        ),

                        /// Availability && rating
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              status == true
                                  ? 0.ph
                                  : Container(
                                      height: 20.h,
                                      width: 70.w,
                                      // padding: const EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25.h),
                                            bottomRight: Radius.circular(25.h),
                                            bottomLeft: Radius.circular(32.h)),
                                        color: Theme.of(context)
                                            .secondaryHeaderColor, // black color
                                      ),
                                      child: Center(
                                        child: Text(
                                            allTranslations
                                                .text("productNotAvailable"),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: 10.sp)),
                                      ),
                                    ),
                              25.pw,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 7.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      size: 12,
                                    ),
                                    3.pw,
                                    Text(
                                      double.parse(overallAssessment.toString())
                                          .round()
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                              decoration: TextDecoration.none,
                                              fontFamily: "cairo"),
                                    ),
                                    2.pw,
                                    Container(
                                      height: 10.h,
                                      width: 2.w,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                    2.pw,
                                    Text(
                                      double.parse(numberResidents.toString())
                                          .round()
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                              decoration: TextDecoration.none,
                                              fontFamily: "cairo"),
                                    ),
                                  ],
                                ),
                              ),
                              if (status == true || pricesList.isNotEmpty)
                                Expanded(
                                  child: IconButton(
                                    onPressed: () async {
                                      try {
                                        String myString =
                                            selectedAdds.toString();
                                        RegExp regex = RegExp(r'\[(.*?)\]');
                                        Iterable<RegExpMatch> matches =
                                            regex.allMatches(myString);

                                        for (RegExpMatch match in matches) {
                                          extractedString = match.group(1);
                                        }
                                        await productDetailsProvider.addToCart(
                                          context,
                                          pricesList[0],
                                          product,
                                          extractedString.toString(),
                                          false,
                                        );
                                        // facebookAppEvents.logAddToCart(
                                        //   id: product.id.toString(),
                                        //   type: 'product',
                                        //   price: double.parse(
                                        //       pricesList[0].price.toString()),
                                        //   currency: "TRY",
                                        // );

                                        debugPrint(
                                            "adding to cart successfully");
                                      } catch (error) {
                                        debugPrint(
                                            "error adding to cart $error");
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.add_shopping_cart_outlined,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // : 0.ph,
                ],
              ),

              ///  label

              Positioned(
                top: 14.5.h,
                left: -26.w,
                right: -16.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isNewProduct == true)
                      allTranslations.currentLanguage == "ar"
                          ? Image.asset(
                              AppImages.ourNewLabelAr,
                              width: 80.w,
                              height: 80.h,
                            )
                          : Image.asset(
                              AppImages.ourNewLabelEn,
                              width: 80.w,
                              height: 80.h,
                            )
                    else if (isMostSellingProduct == true)
                      allTranslations.currentLanguage == "ar"
                          ? Image.asset(
                              AppImages.bestSellerLabelAr,
                              width: 80.w,
                              height: 80.h,
                            )
                          : Image.asset(
                              AppImages.bestSellerLabelEn,
                              width: 80.w,
                              height: 80.h,
                            )
                  ],
                ),
              ),

              /// favorite
              appModel.token == "visitor"
                  ? 0.ph
                  : Positioned(
                      top: 3,
                      left: 5,
                      right: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox.shrink(),
                          LikeButton(
                            size: 20,
                            circleColor: CircleColor(
                                start: Colors.redAccent[400]!,
                                end: Colors.redAccent[400]!),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Colors.redAccent[400]!,
                              dotSecondaryColor: Colors.redAccent[400]!,
                            ),
                            likeBuilder: (bool isLiked) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 2, right: 2, top: 1, bottom: 1),
                                child: Icon(
                                  favoriteIcon,
                                  color: favoriteIconColor,
                                  size: 20,
                                ),
                              );
                            },
                            onTap: onTapFavorite,
                          )
                        ],
                      ),
                    ),

              ///  share

              // Positioned(
              //   top: 50,
              //   left: 10,
              //   right: 10,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: const [
              //
              //        Padding(
              //         padding:  EdgeInsets.only(left: 2 , right: 2 , top: 1 , bottom: 1),
              //         child: Icon(
              //           Icons.share,
              //           color: Colors.grey,
              //           size: 20,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
