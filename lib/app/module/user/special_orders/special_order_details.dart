import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/module/user/special_orders/providers/special_product_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import '../../../data/model/special_order.dart';
import '../../cart/cart_tab.dart';

class SpecialOrderDetails extends StatelessWidget {
  final SpecialOrder specialOrder;
  SpecialOrderDetails({super.key, required this.specialOrder});

  String productQuantity = "0";

  @override
  Widget build(BuildContext context) {
    var cartModel = Provider.of<CartModel>(context);
    SpecialOrderProvider specialOrderProvider = SpecialOrderProvider();

    if (cartModel.items.isNotEmpty) {
      productQuantity = "0";
      for (int i = 0; i < cartModel.items.length; i++) {
        if (specialOrder.id.toString() == cartModel.items[i].id) {
          productQuantity = cartModel.items[i].quantity.toString();
        }
      }
    } else {
      productQuantity = "0";
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
          child: const CustomAppBar(),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                allTranslations.text("orderDetails"),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
              20.ph,
              Flexible(
                child: ListView(
                  children: [
                    /// branch
                    CustomCardIconText(
                        color: Theme.of(context).primaryColor,
                        icon: Icons.language,
                        iconColor: Colors.grey,
                        height: 40.h,
                        width: 45.w,
                        itemsName: allTranslations.text("theBranch"),
                        subItemsName: specialOrder.branchName,
                        itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
                        // secondIcon: Icons.arrow_forward_ios,
                        // secondIconColor: Colors.grey,
                        onTap: null),

                    20.ph,

                    /// order name
                    Container(
                      padding: EdgeInsets.all(10.0.w),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(
                            AppConstants.defaultBorderRadius.w),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(allTranslations.text("specialOrderName"),
                              style: Theme.of(context).textTheme.bodyMedium!),
                          5.ph,
                          Text(specialOrder.name.toString(),
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),

                    20.ph,

                    /// description order
                    Container(
                      padding: EdgeInsets.all(10.0.w),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(
                            AppConstants.defaultBorderRadius.w),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(allTranslations.text("describeOrder"),
                              style: Theme.of(context).textTheme.bodyMedium!),
                          5.ph,
                          Text(specialOrder.desc.toString(),
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),

                    20.ph,

                    /// date
                    CustomCardIconText(
                        color: Theme.of(context).primaryColor,
                        icon: Icons.date_range,
                        iconColor: Colors.grey,
                        height: 40.h,
                        width: 45.w,
                        itemsName: allTranslations.text("deliverTime"),
                        subItemsName: specialOrder.date.toString(),
                        subItemsNameStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontFamily: "cairo"),
                        itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
                        // secondIcon: Icons.arrow_forward_ios,
                        // secondIconColor: Colors.grey,
                        onTap: null),

                    20.ph,

                    /// order price
                    CustomCardIconText(
                        color: Theme.of(context).primaryColor,
                        icon: Icons.monetization_on_sharp,
                        iconColor: Colors.grey,
                        height: 40.h,
                        width: 45.w,
                        itemsName: allTranslations.text("orderPrice"),
                        subItemsName: specialOrder.price == null
                            ? "0.0"
                            : specialOrder.price.toString(),
                        subItemsNameStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontFamily: "cairo"),
                        itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
                        // secondIcon: Icons.arrow_forward_ios,
                        // secondIconColor: Colors.grey,
                        onTap: null),

                    20.ph,

                    /// order status
                    CustomCardIconText(
                        color: Theme.of(context).primaryColor,
                        icon: Icons.done,
                        iconColor: Colors.grey,
                        height: 40.h,
                        width: 45.w,
                        itemsName: allTranslations.text("orderStatus"),
                        itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
                        secondWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 30.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(
                                    AppConstants.defaultBorderRadius.w),
                              ),
                              child: Center(
                                child: Text(
                                  specialOrder.status == 0
                                      ? allTranslations.text("underReview")
                                      : specialOrder.status == 1
                                          ? allTranslations.text("accepted")
                                          : specialOrder.status == 2
                                              ? allTranslations.text("canceled")
                                              : specialOrder.status == 3
                                                  ? allTranslations
                                                      .text("accepted")
                                                  : allTranslations
                                                      .text("underReview"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: null),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: specialOrder.status == 3
            ? ContinuePurchasingButton(
                childPurchasing: Padding(
                  padding: EdgeInsets.only(
                      top: 10.0.h, bottom: 10.0.h, left: 20.w, right: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(allTranslations.text("addToCart"),
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                      Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              AppConstants.defaultBorderRadius.w),
                        ),
                        child: Center(
                          child: Text(
                            productQuantity,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "cairo"),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                childShopping: Center(
                  child: Text(allTranslations.text("continuePurchasing"),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                ),
                onTapPurchasing: () async {
                  try {
                    await specialOrderProvider.addToCart(
                      context: context,
                      id: specialOrder.id.toString(),
                      price: specialOrder.price.toString(),
                      productName: specialOrder.name.toString(),
                      specialOrder: specialOrder,
                    );

                    if (kDebugMode) {
                      print("adding to cart successfully");
                    }
                  } catch (error) {
                    if (kDebugMode) {
                      print("error adding to cart $error");
                    }
                  }
                },
                onTapShopping: () {
                  cartModel.nCount == 0
                      ? CustomToast.showFlutterToast(
                          context: context,
                          message: allTranslations.text("selectOneProduct"),
                          toastLength: Toast.LENGTH_LONG,
                          toastGravity: ToastGravity.SNACKBAR,
                        )
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CartTab(isFromProductDetails: true)));
                },
              )
            : 0.ph,
      ),
    );
  }
}
