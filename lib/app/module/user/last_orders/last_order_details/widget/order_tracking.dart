import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/cart/cart_tab.dart';
import 'package:alalamia_spices/app/module/user/last_orders/last_order_details/rating_order/rating_order_screen.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import '../../../../../data/model/request.dart';
import '../last_order_details_screen.dart';

class OrderTracking extends StatelessWidget {
  final Request request;
  const OrderTracking({required this.request, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ListenToRequestStatusModel(context, request.requestId.toString()),
      child: SubOrderTracking(
        request: request,
      ),
    );
  }
}

class SubOrderTracking extends StatefulWidget {
  final Request request;
  const SubOrderTracking({required this.request, Key? key}) : super(key: key);

  @override
  State<SubOrderTracking> createState() => _SubOrderTrackingState();
}

class _SubOrderTrackingState extends State<SubOrderTracking> {
  // late String status;
  String lastStatus = "";
  int lastRated = 1;
  int? lastCarrierId;
  // late Timer timer;

  // void startTimer(BuildContext context) {
  //   timer = Timer.periodic(const Duration(seconds: 2), (time) {
  //     Provider.of<ListenToRequestStatusModel>(context, listen: false)
  //         .loadData();
  //   });
  // }
  //
  var i;

  @override
  void initState() {
    super.initState();
    status = "";
    i = 0;

      Provider.of<ListenToRequestStatusModel>(context, listen: false).loadData();
      if (Provider.of<ListenToRequestStatusModel>(context, listen: false).isLoaded) {
        status = Provider.of<ListenToRequestStatusModel>(context, listen: false).status.status!;
        rated = Provider.of<ListenToRequestStatusModel>(context, listen: false).status.rated!;
        carrierId =
            Provider.of<ListenToRequestStatusModel>(context, listen: false).status.carrierId;
        lastStatus = status;
        lastRated = rated;
        lastCarrierId = carrierId;
        debugPrint(carrierId.toString());
        if (lastStatus == "canceled") {
          i++;
        }
      } else {
        status = lastStatus;
        rated = lastRated;
        carrierId = lastCarrierId;
        debugPrint(status);
      }

  }

  @override
  void dispose() {
    // timer.cancel();
    status = '';
    rated = lastRated;
    super.dispose();
  }

  // showDialogIfFirstLoaded(BuildContext context) async {
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     // await showDialog(
  //     //   context: context,
  //     //   builder: (BuildContext context) => CustomDialog(
  //     //     title: allTranslations.text('order_alert'),
  //     //     description: allTranslations.text('order_canceled'),
  //     //     buttonText: allTranslations.text('all_done'),
  //     //     onPress: () {
  //     //       Navigator.pushReplacementNamed(context, '/Start');
  //     //       //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => UserLastOrdersContainer()));
  //     //     },
  //     //     icon: Icons.info,
  //     //   ),
  //     // );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ListenToRequestStatusModel>(
      builder: (context , model , child){
        if(model.isLoading || model.loadingFailed){
          const CircularLoading();
        }else {
          status = model.status.status!;
          rated = model.status.rated!;
          carrierId = model.status.carrierId;
        }
        return  model.isLoading || model.loadingFailed
            ? const CircularLoading()
            : Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  status == "delivered" ||
                      status == "on_branch" ||
                      status == "reviewed"
                   ? Padding(
                    padding:  EdgeInsets.symmetric(vertical : 10.h , horizontal: 10.w),
                     child: Text(
                      allTranslations.text("orderStatus"),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp),
                  ),
                   )
                   : 0.ph,

                  status == "delivered" ||
                      status == "on_branch" ||
                      status == "reviewed"
                      ? Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // height: 200.h,
                              padding: EdgeInsets.all(10.0.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      AppConstants.defaultBorderRadius),
                                  color: Theme.of(context).primaryColor),
                              child: status == "delivered" ||
                                  status == "on_branch" ||
                                  status == "reviewed"
                                  ? Center(
                                child: CustomMessage(
                                  message: allTranslations
                                      .text("delivered"),
                                  messageStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                  appLottieIcon: AppLottie.checkMark,
                                  repeat: false,
                                ),
                              )
                                  : 0.ph,
                            ),
                          ],
                        ),
                      )
                      : status == "canceled"
                      ? Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.w),
                        child: Container(
                          padding: EdgeInsets.all(10.0.w),
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                          AppConstants.defaultBorderRadius),
                          color: Theme.of(context).primaryColor),
                          child: Center(
                    child: CustomMessage(
                          message: allTranslations.text("requestNotApproved"),
                          messageStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp),
                          customWidget: Icon(
                            Icons.cancel,
                            color: Colors.grey.withOpacity(0.8),
                            size: 50,
                          ),
                          repeat: false,
                    ),
                  ),
                        ),
                      )
                      : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.0.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          allTranslations.text("orderStatus"),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp),
                        ),
                        InkWell(
                          onTap: () async{
                            CustomLoadingDialog.showLoading(context);
                            await model.loadData().then((value) {
                              CustomLoadingDialog.hideLoading(context);
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                allTranslations.text("refresh"),
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              5.pw,
                              Icon(
                                Icons.refresh,
                                size: 20,
                                color: Theme.of(context).secondaryHeaderColor,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),





                  status == "delivered" ||
                      status == "on_branch" ||
                      status == "reviewed" ||
                      status == "canceled"
                      ? 0.ph
                      : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(20.0.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppConstants.defaultBorderRadius),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 10.0.w),
                        child: orderStatus(
                            context,
                            widget.request,
                            model.isLoaded ? model.status.status! : '',
                            model),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            10.ph,

            //
            // /// canceling order
            // (status == "repair" ||
            //     status == "deliver" ||
            //     status == "delivered" ||
            //     status == "on_branch" ||
            //     status == "reviewed" ||
            //     status == "canceled"
            // )
            //  ? 0.ph
            //  : Padding(
            //   padding:  EdgeInsets.all(10.0.w),
            //   child: CustomButtons(
            //     text: allTranslations.text("cancelOrder"),
            //     buttonColor: Theme.of(context).secondaryHeaderColor,
            //     isLoading: model.cancelingOrder,
            //     onTap: () {
            //       CustomDialog.showCustomDialog(
            //           context: context,
            //           barrierDismissible: false,
            //         title: allTranslations.text("confirmCancelOrder"),
            //         icon: Lottie.asset(
            //           AppLottie.error,
            //           width: 100.w,
            //           height: 100.h,
            //           repeat: false,
            //         ),
            //         withYesButton: true,
            //         withActions: true,
            //         withNoButton: true,
            //         onPressed: () async{
            //           model.cancelingOrder = true;
            //           await model.cancelRequestFunction(
            //               id: widget.request.id.toString()
            //           ).then((value) {
            //             Navigator.pop(context);
            //             CustomDialog.hideCustomDialog(context);
            //           });
            //
            //
            //         },
            //       );
            //     },
            //   ),
            // ),

            /// buttons
            Padding(
              padding:  EdgeInsets.all(10.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  model.isLoaded && rated == 0 && status == "delivered" ||
                      status == "on_branch" ||
                      status == "reviewed"
                      ? Expanded(
                      child: CustomButtons(
                        height: 45.h,
                        text: allTranslations.text("rateOrder"),
                        buttonColor: Theme.of(context).secondaryHeaderColor,
                        onTap: () {
                          pushScreenReplacement(context, RatingOrderScreen(
                            requestId: widget.request.requestId.toString(),
                            carrierId: widget.request.carrierId.toString(),
                            branchId: widget.request.branchId.toString(),
                          ));
                        },
                      ))
                      : 0.ph,
                  10.pw,
                  status == "delivered" ||
                      status == "on_branch" ||
                      status == "reviewed"
                      ? Expanded(
                    child: CustomButtons(
                      // width : 120.w,
                      height: 45.h,
                      text: allTranslations.text("reorder"),
                      buttonColor: Theme.of(context).secondaryHeaderColor,
                      onTap: () async {
                        var cartModel = Provider.of<CartModel>(context, listen: false);
                        var listPro = widget.request.requestItems!.cartProductItems;
                        var listOffer = widget.request.requestItems!.cartOfferItems;
                        try {
                          if ((await cartModel
                              .findDifferent("special")) ||
                              (await cartModel
                                  .findDifferent("prescription_reply")) ||
                              (await cartModel
                                  .findDifferent("product")) ||
                              (await cartModel.findDifferent("offer"))) {

                            CustomDialog.showCustomDialog(
                                context: context,
                                barrierDismissible: false,
                                title: allTranslations.text("replaceSpecialProduct"),
                                withActions: true,
                                withYesButton: true,
                                withNoButton: true,
                                onPressed: () async {
                                  await cartModel.deleteAll();
                                  CustomLoadingDialog.hideLoading(context);
                                  if (listPro!.isNotEmpty) {
                                    for (var i = 0; i < listPro.length; i++) {

                                        debugPrint(listPro[i].id);

                                      CartItem cartItem = CartItem(
                                          id: listPro[i].id,
                                          price: listPro[i].price,
                                          name: "${listPro[i].name} ${listPro[i].productUnit}",
                                          type: "product",
                                          quantity: double.parse(listPro[i].quantity!).round().toString(),
                                          currency: listPro[i].currency,
                                          isPaidAdd: false,
                                          image: ""
                                      );
                                      await cartModel.addToCart(
                                        cartItem : cartItem,
                                        type: "product",
                                        // widget.request.branchId!,
                                        // widget.request.area_id!
                                      );
                                      await cartModel.loadData();
                                      pushScreenReplacement(context, const CartTab(isFromProductDetails: false));
                                    }
                                  }
                                  if (listOffer!.isNotEmpty) {
                                    for (var i = 0; i < listOffer.length; i++) {
                                      CartItem cartItem = CartItem(
                                        id: listOffer[i].id,
                                        price: listOffer[i].price,
                                        name: listOffer[i].name,
                                        type: "offer",
                                        image: "",
                                        isPaidAdd: false,
                                        quantity: double.parse(listOffer[i].quantity!).round().toString(),
                                        branchId: widget.request.branchId,
                                        currency: listOffer[i].currency,
                                      );
                                      await cartModel.addToCart(
                                        cartItem : cartItem,
                                        type: "offer",
                                        // widget.request.branchId!,
                                        // widget.request.area_id!
                                      );
                                      await cartModel.loadData();
                                    }
                                  }
                                  await cartModel.loadData();

                                  pushScreenReplacement(context, CartTab(isFromProductDetails: false));
                                }
                            );

                          } else {
                            if (listPro!.isNotEmpty) {
                              for (var i = 0; i < listPro.length; i++) {

                                  debugPrint(listPro[i].id);

                                CartItem cartItem = CartItem(
                                    id: listPro[i].id,
                                    price: listPro[i].price,
                                    name: "${listPro[i].name} ${listPro[i].productUnit} ",
                                    type: "product",
                                    quantity: double.parse(listPro[i].quantity!).round().toString(),
                                    currency: listPro[i].currency,
                                    isPaidAdd: false,
                                    image: "");
                                await cartModel.addToCart(
                                  cartItem : cartItem,
                                  type:  "product",
                                  // widget.request.branchId!,
                                  // widget.request.area_id!,
                                );
                                await cartModel.loadData();

                                pushScreenReplacement(context, CartTab(isFromProductDetails: false));
                              }
                            }
                            if (listOffer!.isNotEmpty) {
                              for (var i = 0; i < listOffer.length; i++) {
                                CartItem cartItem = CartItem(
                                  id: listOffer[i].id,
                                  price: listOffer[i].price,
                                  name: listOffer[i].name,
                                  type: "offer",
                                  quantity: double.parse(listOffer[i].quantity!).round().toString(),
                                  image: "",
                                  currency: listOffer[i].currency,
                                  isPaidAdd: false,
                                );
                                await cartModel.addToCart(
                                  cartItem : cartItem,
                                  type: "offer",
                                    // widget.request.branchId!,
                                    // widget.request.area_id!
                                );
                              }
                            }
                            await cartModel.loadData();
                            pushScreenReplacement(context, CartTab(isFromProductDetails: false));


                          }
                          //   }
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                    ),
                  )
                      : 0.ph

                ],
              ),
            )
          ],
        );
      },
    );
  }

  // _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'لا يمكن الدخول الى واتساب';
  //   }
  // }

  Widget orderStatus(BuildContext context, Request request, String status,
      ListenToRequestStatusModel model) {

    try {
      final ceilingPrice = Provider.of<CeilingPriceModel>(context, listen: false);
      double ceiling = ceilingPrice.isLoading || ceilingPrice.loadingFailed
          ? 0.0
          : double.parse(ceilingPrice.ceiling.price.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        10.ph,

        /// under review

        (status == "requested" ||
                status == "received" ||
                status == "repair" ||
                status == "deliver" ||
                status == "delivered" ||
                status == "on_branch" ||
                status == "reviewed")
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    allTranslations.text("underReview"),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    width: 20.w,
                    height: 20.h,
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    allTranslations.text("underReview"),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    width: 20.w,
                    height: 20.h,
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).secondaryHeaderColor),
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),

        40.ph,

        /// order approved

        (status == "received" ||
                status == "repair" ||
                status == "deliver" ||
                status == "delivered" ||
                status == "on_branch" ||
                status == "reviewed")
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    allTranslations.text("requestApproved"),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    width: 20.w,
                    height: 20.h,
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    allTranslations.text("requestApproved"),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    width: 20.w,
                    height: 20.h,
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).secondaryHeaderColor),
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),

        40.ph,

        /// repair

        (status == "repair" ||
                status == "deliver" ||
                status == "delivered" ||
                status == "on_branch" ||
                status == "reviewed")
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    allTranslations.text("beingProcessed"),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    width: 20.w,
                    height: 20.h,
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    allTranslations.text("beingProcessed"),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    width: 20.w,
                    height: 20.h,
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).secondaryHeaderColor),
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),

        40.ph,

        /// in the road

        (status == "deliver" ||
                status == "delivered" ||
                status == "on_branch" ||
                status == "reviewed")
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    allTranslations.text("onTheWay"),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    width: 20.w,
                    height: 20.h,
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    allTranslations.text("onTheWay"),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    width: 20.w,
                    height: 20.h,
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).secondaryHeaderColor),
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),

        40.ph,

        /// Delivered

        status == "delivered" || status == "on_branch" || status == "reviewed"
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    allTranslations.text("delivered"),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    width: 20.w,
                    height: 20.h,
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    allTranslations.text("delivered"),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    width: 20.w,
                    height: 20.h,
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).secondaryHeaderColor),
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
      ],
    );
  }
}
