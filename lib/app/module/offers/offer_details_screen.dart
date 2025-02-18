

import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_colors.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/module/cart/cart_tab.dart';
import 'package:alalamia_spices/app/module/offers/providers/offer_details_provider.dart';
import 'package:alalamia_spices/app/module/offers/widget/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';

class OfferDetailsScreen extends StatelessWidget {
  final Offers offers;
  final int? index;
  OfferDetailsScreen({
    super.key,
    required this.offers,
    this.index
});


  // int daysBetween(DateTime from, DateTime to) {
  //   from = DateTime(from.year, from.month, from.day);
  //   to = DateTime(to.year, to.month, to.day);
  //   return (to.difference(from).inHours / 24).round();
  // }


  Duration timeBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day, from.hour, from.minute, from.second);
    to = DateTime(to.year, to.month, to.day+1, to.hour, to.minute, to.second);
    return to.difference(from);
  }
  String cartQuantity = "0";


  @override
  Widget build(BuildContext context) {
    OfferDetailsProvider offerDetailsProvider = OfferDetailsProvider();
    // DateTime startOfferDate = DateTime.now();
    // DateTime endOfferDate = DateTime.parse(offers.endDate.toString());
    // var resultDays = daysBetween(startOfferDate, endOfferDate);
    var cartModel = Provider.of<CartModel>(context);
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.parse(offers.endDate.toString());
    // endDate = DateTime.parse(int.parse(offers.endDate.toString() +1) );
    Duration duration = timeBetween(startDate, endDate);


    if(cartModel.items.length > 0 ){
      cartQuantity = "0";
      for(int i = 0; i < cartModel.items.length; i++){
        if(offers.id == cartModel.items[i].id) {
          cartQuantity = cartModel.items[i].quantity.toString();
        }
      }
    }else {
      cartQuantity = "0";
    }




    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
          child: const CustomAppBar(),
        ),
        body : ListView(
          children: [

            /// offer image

             OffersDetailsSliders(
               offers: offers,
             ),



            /// offer details
            Card(
              elevation: 0.2,
              child: Padding(
                padding:  EdgeInsets.all(10.0.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomTowText(
                        title: allTranslations.text("offerName"),
                        titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold
                        ),
                        subTitle: offers.name.toString(),
                        subTitleStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14.sp
                        ),
                    ),


                    15.ph,

                    /// old price & new price
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [

                        // old price
                        CustomTowText(
                          title: allTranslations.text("oldPrice"),
                          titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold
                          ),
                          subTitle: "${offers.oldPrice.toString()} ${offers.currencyName}",
                          subTitleStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                              fontSize:  14.sp,
                              fontFamily: "cairo"
                          )
                        ),

                       10.ph,


                        // new price
                        CustomTowText(
                          title: allTranslations.text("newPrice"),
                          titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                          ),
                          subTitle: "${offers.price.toString()} ${offers.currencyName}",
                          subTitleStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 14.sp,
                              fontFamily: "cairo",
                              color: AppColors.accent
                          ),
                        ),

                      ],
                    ),




                  ],
                ),
              ),
            ),

            Card(
              elevation: 0.2,
              child: Padding(
                padding: EdgeInsets.all(10.0.w),
                child: Column(
                  children: [

                    CustomTowText(
                      title: allTranslations.text("offerExpireDate"),
                      titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold
                      ),
                      subTitle: offers.endDate.toString(),
                      subTitleStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14.sp,
                          fontFamily: "cairo"
                      ),
                    ),


                    15.ph,



                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: SlideCountdownSeparated(
                        duration: duration,
                        height: 70.h,
                        width: 70.w,
                        textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: "cairo"
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                        ),
                        separatorType: SeparatorType.symbol,
                        showZeroValue: true,






                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 30.0.w , vertical: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Expanded(
                                flex: 2,
                                child: Text(
                                  allTranslations.text("seconds"),
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                            ),

                            Expanded(
                                flex: 2,
                                child: Text(
                                  allTranslations.text("minutes"),
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  allTranslations.text("hours"),
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                            ),
                            Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    allTranslations.text("days"),
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),

            Card(
              elevation: 0.2,
              child:  OfferComponent(
                offerProductPrice: offers.offerProductPrice,
              ),
            ),

            5.ph



          ],
        ),
        bottomNavigationBar:  ContinuePurchasingButton(
          childPurchasing:  Padding(
            padding:  EdgeInsets.only(top:  10.0.h , bottom:  10.0.h , left: 20.w , right: 20.w),
            child: Row(
              mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    allTranslations.text("addToCart"),
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: "cairo"
                    )
                ),


                Container(
                  width: 30.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                  ),
                  child: Center(
                    child: Text(
                      "${cartQuantity}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: "cairo"
                      ),
                    ),
                  ),
                )


              ],
            )
          ),
          childShopping: Center(
            child: Text(
                allTranslations.text("continuePurchasing"),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                )
            ),
          ),
          onTapPurchasing: () async{

              try{
                await offerDetailsProvider.addToCart(
                    context,
                    offers
                );

                if (kDebugMode) {
                  print("adding to cart successfully");
                }

              }catch (error){
                if (kDebugMode) {
                  print("error adding to cart $error");
                }
              }


            },



          onTapShopping: (){
            cartModel.nCount == 0
                ? CustomToast.showFlutterToast(
              context: context,
              message: allTranslations.text("selectOneProduct"),
              toastLength: Toast.LENGTH_LONG,
              toastGravity: ToastGravity.SNACKBAR,
            )
                : Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartTab(isFromProductDetails: true))
            );
          },
        )
      ),
    );
  }
}
