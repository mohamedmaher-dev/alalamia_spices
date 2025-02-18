import 'dart:async';

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
//import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../core/utils/constants.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import '../../services/screen_navigation_service.dart';
import '../auth/auth_tabs_screen.dart';
import '../check_out/check_out_screen.dart';
import '../start/start.dart';

late CartModel cartModel;
late CeilingPriceModel ceilingPriceModel;

class CartTab extends StatefulWidget {
  final bool isFromProductDetails;
  const CartTab({super.key, required this.isFromProductDetails});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  bool condition = false;
  // String? extractedString;

  @override
  void initState() {
    Timer.periodic(const Duration(minutes: 5), (_) {
      cartModel.loadData();
      ceilingPriceModel.loadData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cartModel = Provider.of<CartModel>(context);
    ceilingPriceModel = Provider.of<CeilingPriceModel>(context);
    for (int i = 0; i < cartModel.items.length; i++) {
      condition = cartModel.items[i].type == "product" ||
          cartModel.items[i].type == "offer" ||
          cartModel.items[i].type == "special";
    }

    // print("ceilingPrice = ${ceilingPriceModel.ceilingPrice}");
    // String myString = freeAdd.toString();
    // RegExp regex = RegExp(r'\[(.*?)\]');
    // Iterable<RegExpMatch> matches = regex.allMatches(myString);
    //
    // for (RegExpMatch match in matches) {
    //    extractedString = match.group(1);
    //   // if (kDebugMode) {
    //   //   print("sssss ${extractedString!.trim()}");
    //   // }
    // }
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   for(int i = 0; i < cartModel.items.length; i++){
    //
    //     // print("ppppppppp ${cartModel.items[i].productId}");
    //     if(cartModel.items[i].productId == cartModel.items[i].productId && cartModel.items[i].isPaidAdd == true){
    //
    //         cartModel.combined = true;
    //
    //     }else {
    //       cartModel.combined = false;
    //     }
    //   }
    //
    // });

    return Consumer<ConnectivityNotifier>(
      builder: (context, connection, child) {
        return SafeArea(
          child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                child: widget.isFromProductDetails == true
                    ? const CustomAppBar(isCartScreen: true)
                    : const CustomAppBar(isHome: true),
              ),
              body: Column(
                mainAxisAlignment: cartModel.items.isNotEmpty
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  cartModel.items.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: cartModel.nCount,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  /// type of product
                                  Container(
                                    height: condition &&
                                            cartModel.items[index].isPaidAdd ==
                                                false
                                        ? 110.h
                                        : 90.h,
                                    padding: EdgeInsets.all(5.0.w),
                                    decoration: BoxDecoration(
                                        color: condition &&
                                                cartModel.items[index]
                                                        .isPaidAdd ==
                                                    false
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(0.3),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                AppConstants
                                                    .defaultBorderRadius.w),
                                            bottomLeft: Radius.circular(
                                                AppConstants
                                                    .defaultBorderRadius.w))),
                                    child: CustomRotatedBox(
                                      text: cartModel.items[index].type ==
                                                  "product" &&
                                              cartModel.items[index].isPaidAdd ==
                                                  false
                                          ? allTranslations.text("productType")
                                          : cartModel.items[index].type ==
                                                  "offer"
                                              ? allTranslations
                                                  .text("offerType")
                                              : cartModel.items[index].type ==
                                                      "special_product"
                                                  ? allTranslations
                                                      .text("specialProduct")
                                                  : cartModel.items[index].type ==
                                                          "special"
                                                      ? allTranslations.text(
                                                          "specialProduct")
                                                      : cartModel.items[index]
                                                                      .type ==
                                                                  "product" &&
                                                              cartModel
                                                                      .items[
                                                                          index]
                                                                      .isPaidAdd ==
                                                                  true
                                                          ? allTranslations
                                                              .text("adds")
                                                          : allTranslations
                                                              .text("productType"),
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5.0.h, horizontal: 3.w),
                                      child: Container(
                                        height: condition &&
                                                cartModel.items[index]
                                                        .isPaidAdd ==
                                                    false
                                            ? 110.h
                                            : 90.h,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(5.w),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                AppConstants
                                                    .defaultBorderRadius.w),
                                            color: condition &&
                                                    cartModel.items[index]
                                                            .isPaidAdd ==
                                                        false
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                    .withOpacity(
                                                        0.3) // white color
                                            ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  /// product name

                                                  CustomTowText(
                                                    title: condition &&
                                                            cartModel
                                                                    .items[
                                                                        index]
                                                                    .isPaidAdd ==
                                                                false
                                                        ? "${allTranslations.text("productName")}: "
                                                        : "${allTranslations.text("addName")}: ",
                                                    titleStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                    subWidget: SizedBox(
                                                      width: 130.w,
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Text(
                                                          condition &&
                                                                  cartModel
                                                                          .items[
                                                                              index]
                                                                          .isPaidAdd ==
                                                                      false
                                                              ? "${cartModel.items[index].name}"
                                                              : "${cartModel.items[index].unitName}",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      "cairo"),
                                                        ),
                                                      ),
                                                    ),
                                                    // subTitle: "${cartModel.items[index].name}",
                                                    textOverflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),

                                                  /// paid adds
                                                  // CustomTowText(
                                                  //   title: "${allTranslations.text("paidAdds")}:",
                                                  //   titleStyle: Theme.of(context).textTheme.bodyMedium!!.copyWith(
                                                  //     fontWeight: FontWeight.bold,
                                                  //   ),
                                                  //   subWidget: SizedBox(
                                                  //     width: 120.w,
                                                  //     child: SingleChildScrollView(
                                                  //       scrollDirection: Axis.horizontal,
                                                  //       child: Text(
                                                  //           cartModel.items[index].paidAdd.toString(),
                                                  //           style: Theme.of(context).textTheme.caption!.copyWith(
                                                  //               fontWeight: FontWeight.bold,
                                                  //               fontFamily: "cairo"
                                                  //           )
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  //   maxLines: 1,
                                                  //   textOverflow: TextOverflow.ellipsis,
                                                  //
                                                  // ),

                                                  /// adds
                                                  if ((cartModel.items[index]
                                                                  .addAr ==
                                                              '' ||
                                                          cartModel.items[index]
                                                                  .addAr ==
                                                              ".") ||
                                                      (condition &&
                                                          cartModel.items[index]
                                                                  .isPaidAdd ==
                                                              true))
                                                    0.ph
                                                  else
                                                    CustomTowText(
                                                      title:
                                                          "${allTranslations.text("add")}:",
                                                      titleStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                      subWidget: SizedBox(
                                                        width: 150.w,
                                                        child:
                                                            SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Text(
                                                              cartModel
                                                                  .items[index]
                                                                  .addAr
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          "cairo")),
                                                        ),
                                                      ),
                                                      maxLines: 1,
                                                      textOverflow:
                                                          TextOverflow.ellipsis,
                                                    ),

                                                  /// product price

                                                  CustomTowText(
                                                    title: condition &&
                                                            cartModel
                                                                    .items[
                                                                        index]
                                                                    .isPaidAdd ==
                                                                false
                                                        ? "${allTranslations.text("productPrice")}: "
                                                        : "${allTranslations.text("addPrice")}: ",
                                                    titleStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                    subWidget: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "${cartModel.items[index].price}",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      "cairo",
                                                                  fontSize:
                                                                      12.sp),
                                                        ),
                                                        5.pw,
                                                        Center(
                                                          child: Text(
                                                            "${cartModel.items[index].currency}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        "cairo",
                                                                    fontSize:
                                                                        10.sp),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),

                                                  /// increment & decrement & delete icon
                                                  Row(
                                                    children: [
                                                      /// increment & decrement
                                                      CustomIncDecButtons(
                                                        borderRadius: 30.0,
                                                        onIncTap: () async {
                                                          await cartModel
                                                              .increment(
                                                                  cartModel
                                                                          .items[
                                                                      index],
                                                                  cartModel
                                                                      .items[
                                                                          index]
                                                                      .type,
                                                                  1);
                                                          cartModel.loadData();
                                                        },
                                                        arrowIncIcon:
                                                            Icons.arrow_drop_up,
                                                        onDecTap: () async {
                                                          if (int.parse(cartModel
                                                                  .items[index]
                                                                  .quantity) >
                                                              1) {
                                                            await cartModel
                                                                .decrement(
                                                                    cartModel
                                                                            .items[
                                                                        index],
                                                                    cartModel
                                                                        .items[
                                                                            index]
                                                                        .type);
                                                          }
                                                        },
                                                        arrowDecIcon: Icons
                                                            .arrow_drop_down,
                                                        quantity: cartModel
                                                            .items[index]
                                                            .quantity
                                                            .toString(),
                                                        borderColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .secondary,
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .surface,
                                                        backgroundIconColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        arrowsIconColor: Theme
                                                                .of(context)
                                                            .secondaryHeaderColor,
                                                        iconSize: 20,
                                                      ),

                                                      20.pw,

                                                      InkWell(
                                                        onTap: () async {
                                                          await cartModel.delete(
                                                              cartModel
                                                                  .items[index],
                                                              cartModel
                                                                  .items[index]
                                                                  .type);
                                                        },
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                              size: 20,
                                                            ),
                                                            3.pw,
                                                            Text(
                                                                allTranslations
                                                                    .text(
                                                                        "delete"),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall)
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            if (condition &&
                                                cartModel.items[index]
                                                        .isPaidAdd ==
                                                    false)
                                              Expanded(
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .circular(AppConstants
                                                          .defaultBorderRadius
                                                          .w),
                                                  child: SizedBox(
                                                    height: 220.h,
                                                    width: 167.w,
                                                    child:
                                                        CustomCachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl: cartModel
                                                          .items[index].image
                                                          .toString(),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            else
                                              0.ph,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Column(
                            children: [
                              CustomMessage(
                                message: allTranslations.text("letsFillItIn"),
                                appLottieIcon: AppLottie.emptyCart,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: CustomButtons(
                                  text: "متابعة التسوق",
                                  buttonColor:
                                      Theme.of(context).secondaryHeaderColor,
                                  onTap: () {
                                    persistentController.jumpToTab(0);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                ],
              ),
              bottomNavigationBar: cartModel.items.isNotEmpty
                  ? connection.hasConnection
                      ? ceilingPriceModel.isLoading ||
                              ceilingPriceModel.loadingFailed
                          ? const CircularLoading()
                          : ContinuePurchasingButton(
                              ceilingPrice: cartModel.totalPrice <
                                  double.parse(ceilingPriceModel.ceiling.price
                                      .toString()),
                              childPurchasing: buildOrderDetails(context),
                              childShopping: ceilingPriceDetails(context),
                              // complete order
                              onTapShopping: () {
                                appModel.token == "visitor"
                                    ? PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: const AuthTabsScreen(),
                                        withNavBar: false,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      )
                                    : widget.isFromProductDetails == true
                                        ? pushScreenReplacement(
                                            context, const CheckOutScreen())
                                        : pushScreen(
                                            context, const CheckOutScreen());
                              },
                            )
                      : const NoInternetMessage()
                  : 0.ph),
        );
      },
    );
  }

  Widget buildOrderDetails(BuildContext context) {
    var cartModel = Provider.of<CartModel>(context);
    var cartList =
        cartModel.items.where((element) => element.isPaidAdd == false).toList();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTowText(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            title: "${allTranslations.text("billTotal")}: ",
            titleStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            subWidget: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cartModel.totalPrice.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: Theme.of(context).colorScheme.secondary,
                      fontFamily: "cairo"),
                ),
                5.pw,
                Center(
                  child: Text(
                    "${cartModel.items[0].currency}",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 10.sp,
                        color: Theme.of(context).colorScheme.secondary,
                        fontFamily: "cairo"),
                  ),
                )
              ],
            ),
          ),
          CustomTowText(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            title: allTranslations.text("itemsCount"),
            titleStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            subTitle: cartList.length.toString(),
            subTitleStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
                fontFamily: "cairo"),
          ),
        ],
      ),
    );
  }

  Widget ceilingPriceDetails(BuildContext context) {
    var ceilingPriceModel = Provider.of<CeilingPriceModel>(context);
    var cartModel = Provider.of<CartModel>(context);
    if (ceilingPriceModel.items.isEmpty && ceilingPriceModel.loadingFailed) {
      return 0.ph;
    } else {
      return Center(
        child: Text(
            cartModel.totalPrice <
                    double.parse(ceilingPriceModel.ceiling.price.toString())
                ? "${allTranslations.text("minimumPrice")}\n "
                    "${double.parse(ceilingPriceModel.ceiling.price.toString()).round()} ${cartModel.items[0].currency}"
                : allTranslations.text("completeOrder"),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: "cairo",
                  fontSize: 12.sp,
                )),
      );
    }
  }
}
