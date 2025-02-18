import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:alalamia_spices/app/module/bill/provider/bill_provider.dart';
import 'package:alalamia_spices/app/module/bill/widget/bill_shimmer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/utils/constants.dart';
import '../../core/values/app_colors.dart';
import '../../core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import '../../data/model/request.dart';
import '../check_out/widget/location_details.dart';
import '../user/last_orders/last_orders_screen.dart';
import 'bill_screen.dart';

class ExternalOrderBill extends StatelessWidget {
  final Request request;
  const ExternalOrderBill({
    Key? key,
    required this.request
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => CartModel(context)),
      ChangeNotifierProvider(create: (context) => TaxModel(context)),
      // ChangeNotifierProvider(create: (context) => DeliveryPricingModel(context)),
      ChangeNotifierProvider(create: (context) => DiscountModel(context)),
      ChangeNotifierProvider(create: (context) => FinancialPortfoliosModel(context)),
      ChangeNotifierProvider(create: (context) => RequestModel(context)),
      ChangeNotifierProvider(create: (context) => CouponModel(context)),
      ChangeNotifierProvider(create: (context) => UserWalletModel(context)),
      ChangeNotifierProvider(create: (context) => NewDeliveryPriceModel(context)),
      ChangeNotifierProvider(create: (context) => CeilingPriceModel(context)),
      ChangeNotifierProvider(create: (context) => BillProvider()),
      ChangeNotifierProvider(create: (context) => PayPalModel(context)),
      ChangeNotifierProvider(create: (context) => TapModel(context)),
    ], child:  SubExternalOrderBill(
      request:  request,

    ));
  }
}

class SubExternalOrderBill extends StatefulWidget {
  final Request request;
  const SubExternalOrderBill({
    Key? key,
    required this.request
  }) : super(key: key);

  @override
  State<SubExternalOrderBill> createState() => _SubExternalOrderBillState();
}

class _SubExternalOrderBillState extends State<SubExternalOrderBill> {
  // String? chosenPayment;
  late TextEditingController noteController;
  late TextEditingController couponController;
  late TextEditingController payerController;
  double deliveryPrice = 0.0;
  double totalPrice = 0.0;
  String deliveryPriceId = "";
  double  amountToBePaid = 0.0 ;
  var cartStatus;
  int? cartId;
  bool? isLoading = false;
  bool? isCouponCheck = false;
  // String? branchId ;
  double couponPrice = 0.0;
  String? couponType;
  String? couponText;
  String? error;
  String? status;
  double couponDiscount = 0.0;
  double discount = 0.0;
  double tax = 0.0;
  double total = 0.0;
  double deliveryPriceAfterDiscount = 0.0;
  int paymentIndex = 1 ;
  double ceiling = 0.0;
  bool  isUnsupportedCurrency = false;
  String chosenPayment = allTranslations.text("receipt");

  // Future getCartId(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   cartID = prefs.getString('cart_id') ?? "";
  //   setState(() {
  //
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // getCartId(context);
    noteController = TextEditingController();
    couponController = TextEditingController();
    payerController = TextEditingController();
    deliveryPrice = double.parse(widget.request.deliveryPricing.toString());
    totalPrice = double.parse(widget.request.requestItems!.priceSum.toString());

  }

  @override
  void dispose() {
    super.dispose();
    noteController.dispose();
    couponController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    var cartModel = Provider.of<CartModel>(context);
    var taxModel = Provider.of<TaxModel>(context);
    var userModel = Provider.of<UserModel>(context);
    userModel.getUserInfo();
    var userWalletModel = Provider.of<UserWalletModel>(context);
    var requestModel = Provider.of<RequestModel>(context);
    var discountModel = Provider.of<DiscountModel>(context);
    var financialPortfoliosModel = Provider.of<FinancialPortfoliosModel>(context);
    var billProvider = Provider.of<BillProvider>(context);
    var payPalModel = Provider.of<PayPalModel>(context);
    var tapPaymentModel = Provider.of<TapModel>(context);
    var themeModel = Provider.of<ThemeModel>(context);
    DiscountVolume? discountVolume;
    var returnOfRequest;

    try{

      // branchId = cartModel.items.length > 0 ? cartModel.items[0].branchId : null;

      if(taxModel.items.isNotEmpty){
        tax = ((double.parse(totalPrice.toString()) + double.parse(deliveryPrice.toString()))
            *(double.parse(taxModel.taxPrice.price.toString())/100));
        setState(() {
          amountToBePaid = double.parse(totalPrice.toString()) + double.parse(deliveryPrice.toString()) + double.parse(tax.toString());
        });
      }else {
        setState(() {
          amountToBePaid = double.parse(totalPrice.toString()) + double.parse(deliveryPrice.toString());
        });
      }

      // if (kDebugMode) {
      //   debugPrint("*********** tax $tax");
      //   debugPrint(chosenAreaId);
      // }



    }catch (error){
      if(kDebugMode) {
        debugPrint("NewDeliveryPriceModel bill screen error $error");
      }
    }

    // debugPrint("hgdhasghdghasgdhsagd ${widget.request.address_id}");

    Future sendRequest() async {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // if (kDebugMode) {
      //   debugPrint('Booking daaaaaaaaate ${billProvider.selectedDate} -  ${billProvider.selectedHour} : ${billProvider.selectedMinute}');
      // }
      Request request;
      // CartList cartList = CartList(items: List<CartItem>.from(cartModel.items));
      // cartStatus = await cartModel.sendCart(cartList);
      // NewCartList cartList = NewCartList(items: List<NewCart>.from(newCartModel.items));
      //  cartStatus = await newCartModel.sendCart(cartList);
      if (cartModel.isLoaded) {
        // cartId = cartID;
        // cartId = cartStatus["cart_id"];
        cartId = int.parse(widget.request.cartId.toString());
        if (kDebugMode) {
          debugPrint("******** cart id $cartId");
        }
        request = Request(
            countryId: userModel.user.countryId,
            currency: userModel.countryCurrencyId.toString(),
            deliveryPricing: deliveryPrice.toString(),
            paymentType: chosenPayment ==  allTranslations.text("paymentCards")
                ? "4"
                : chosenPayment == allTranslations.text("receipt")
                ? "2"
                : chosenPayment == allTranslations.text("fromWallet")
                ? "1"
                : chosenPayment == allTranslations.text("payPal")
                ? "3"
                : "2",
            receivingType: widget.request.receivingType == "external"
                ? "afterExternal"
                :  "afterUrgent",
            cartId: cartId.toString(),
            couponNumber: couponText.toString().isEmpty
                ? ""
                : couponText,
            discountid: discountVolume?.id,
            requestNote: noteController.text,
            // branchId: branchId ,
            address_id: widget.request.address_id,
            deliverLocationId: deliveryPriceId == ""
                ? "4"
                : deliveryPriceId,
            deliveryPriceId: deliveryPriceId ,
            bookingDate:  widget.request.bookingDate.toString()

        );
        returnOfRequest = await requestModel.addNewRequest(request);
        if (kDebugMode) {
          debugPrint(returnOfRequest);
        }

        if (requestModel.isLoaded) {
          setState(() {
            isLoading = false;
          });

          CustomDialog.showCustomDialog(
            context: context,
            barrierDismissible: false,
            title: allTranslations.text("requestSent"),
            icon: Lottie.asset(
              AppLottie.checkMark,
              width: 100.w,
              height: 100.h,
              repeat: false,
            ),
            withYesButton: true,
            withActions: true,
            onPressed: () async{
              await cartModel.deleteAll().then((value) {
                pushScreenReplacement(context, const LastOrdersScreen(isFromBill : true));
                billProvider.selectedShippingType = '';
                currentLocationId = null;
                chosenLocationId = null;
                billProvider.selectedMinute = '';
                billProvider.selectedDate = '';
                billProvider.selectedHour = '';
                CustomDialog.hideCustomDialog(context);
              });

              await cartModel.loadData();

            },
          );

        } else {
          if (requestModel.errors.isNotEmpty) {

            CustomDialog.showCustomDialog(
                context: context,
                barrierDismissible: false,
                title: allTranslations.text("requestSentFailed"),
                description: Text(
                  requestModel.errors["message"].toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold
                  ),
                ),
                icon: Lottie.asset(
                  AppLottie.error,
                  width: 100.w,
                  height: 100.h,
                  repeat: false,
                ),
                withActions: true,
                withYesButton: true,
                onPressed: (){
                  CustomDialog.hideCustomDialog(context);
                }
            );

            setState(() {
              isLoading = false;
            });
            if (kDebugMode) {
              debugPrint(requestModel.errors.toString());
              debugPrint(requestModel.errors["message"].toString());
            }
            await cartModel.loadData();

          }
        }
      }

    }


    // this if condition check the type of coupon price or percentage
    if (cartModel.isLoaded) {
      if (couponType == "price") {
        total = (amountToBePaid - couponPrice) < 0
            ? 0.0
            : (amountToBePaid - couponPrice);
      } else {
        total = (amountToBePaid -
            (amountToBePaid * (couponPrice / 100))) <
            0
            ? 0.0
            : (amountToBePaid -
            (amountToBePaid * (couponPrice / 100)));
      }

      if (cartModel.items.isNotEmpty) {
        if (cartModel.items[0].insurance_rate != "0.0" &&
            cartModel.items[0].insurance_rate != null) {
          total = (amountToBePaid -
              (amountToBePaid *
                  (double.parse(cartModel.items[0].insurance_rate) /
                      100))) <
              0
              ? 0.0
              : (amountToBePaid -
              (amountToBePaid *
                  (double.parse(cartModel.items[0].insurance_rate) / 100)));
        }
      }
      couponDiscount = amountToBePaid - total;
    }
    //////////////////////////////////////////////////////////////////



    if(discountVolume != null && discountModel.items.isNotEmpty){
      if ( discountModel.isLoaded) {
        for (int i = 0; i < discountModel.items.length; i++) {
          if (discountModel.items[i].priceTo == "") {
            if (double.parse(discountModel.items[i].priceFrom) <= total) {
              if (discountVolume == null) {
                discountVolume = discountModel.items[i];
              } else {
                if (double.parse(discountVolume.priceFrom.toString()) <
                    double.parse(discountModel.items[i].priceFrom)) {
                  discountVolume = discountModel.items[i];
                }
              }
              if (kDebugMode) {
                debugPrint(discountVolume!.priceFrom.toString());
              }
            }
          } else {
            if (amountToBePaid >= double.parse(discountModel.items[i].priceFrom) &&
                amountToBePaid < double.parse(discountModel.items[i].priceTo)) {
              if (discountVolume == null) {
                discountVolume = discountModel.items[i];
              } else {
                if (double.parse("${discountVolume.priceFrom}") <
                    double.parse("${discountModel.items[i].priceFrom}")) {
                  discountVolume = discountModel.items[i];
                }
              }
              // if (kDebugMode) {
              //   debugPrint(discountVolume.priceFrom);
              // }
            }
          }
        }
        if (discountVolume != null && cartModel.items.isNotEmpty) {
          if (discountVolume.valueType == "price" &&
              discountVolume.type == "minimum") {
            total = (amountToBePaid - double.parse(discountVolume.value.toString())) < 0
                ? 0.0
                : (amountToBePaid - double.parse(discountVolume.value.toString()));
          } else if (discountVolume.valueType != "price" &&
              discountVolume.type == "minimum") {

            total =
            (amountToBePaid - (amountToBePaid * (double.parse(discountVolume.value.toString()) / 100))) < 0
                ? 0.0
                : (amountToBePaid -
                (amountToBePaid * (double.parse(discountVolume.value.toString()) / 100)));

          } else if (discountVolume.valueType == "price" &&
              discountVolume.type == "balance" &&
              chosenPayment == allTranslations.text("fromWallet")) {
            total = (amountToBePaid - double.parse(discountVolume.value.toString())) < 0
                ? 0.0
                : (amountToBePaid - double.parse(discountVolume.value.toString()));
          } else if (discountVolume.valueType == "percentage" &&
              discountVolume.type == "balance" &&
              chosenPayment == allTranslations.text("fromWallet")) {
            total =
            (amountToBePaid - (amountToBePaid * (double.parse(discountVolume.value.toString()) / 100))) < 0
                ? 0.0
                : (amountToBePaid -
                (amountToBePaid * (double.parse(discountVolume.value.toString()) / 100)));
          }

          else if (discountVolume.valueType == "price" &&
              discountVolume.type == "delivery" &&
              cartModel.items[0].currency == "ريال يمني" &&
              chosenPayment == allTranslations.text("receipt")) {
            total = (amountToBePaid - double.parse(discountVolume.value.toString())) < 0
                ? 0.0
                : double.parse(deliveryPrice.toString()) - double.parse(discountVolume.value.toString()) < 0
                ? total = (amountToBePaid - double.parse(deliveryPrice.toString()))
                : (amountToBePaid - double.parse(discountVolume.value.toString()));
          } else if (discountVolume.valueType == "percentage" &&
              discountVolume.type == "delivery" &&
              chosenPayment == allTranslations.text("receipt") &&
              cartModel.items[0].currency == "ريال يمني") {
            total = ((double.parse(deliveryPrice.toString()) *
                (double.parse(discountVolume.value.toString()) / 100))) <
                0
                ? 0.0
                : (amountToBePaid -
                (double.parse(deliveryPrice.toString()) *
                    (double.parse(discountVolume.value.toString()) / 100)));
          } else if (discountVolume.valueType == "price" &&
              discountVolume.type == "delivery" &&
              chosenPayment == allTranslations.text("receipt") &&
              cartModel.items[0].currency != "ريال يمني") {
            deliveryPriceAfterDiscount = (double.parse(deliveryPrice.toString()) - double.parse(discountVolume.value.toString())) < 0
                ? 0.0
                : double.parse(deliveryPrice.toString()) - double.parse(discountVolume.value.toString()) < 0
                ? deliveryPrice = 0.0
                : (double.parse(deliveryPrice.toString()) - double.parse(discountVolume.value.toString()));
          } else if (discountVolume.valueType == "percentage" &&
              discountVolume.type == "delivery" &&
              chosenPayment == allTranslations.text("receipt") &&
              cartModel.items[0].currency != "ريال يمني") {
            deliveryPriceAfterDiscount = ((double.parse(deliveryPrice.toString()) *
                (double.parse(discountVolume.value.toString()) / 100))) <
                0
                ? 0.0
                : (double.parse(deliveryPrice.toString()) -
                (double.parse(deliveryPrice.toString()) *
                    (double.parse(discountVolume.value.toString()) / 100)));
          }
        }
        discount = amountToBePaid - total;
      }
    }
    Widget calculationDiscount(BuildContext context) {
      Widget? child;

      if(discountVolume != null && cartModel.items.isNotEmpty){
        /// discount of balance
        if ( discountVolume.valueType == "price" &&
            discountVolume.type == "balance" &&
            chosenPayment == allTranslations.text("fromWallet")) {
          child = Text(
              "${discountVolume.value}   ${userModel.user.currencyName} ",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontFamily: "cairo"
              ));
        } else if (discountVolume.valueType == "percentage" &&
            discountVolume.type == "balance" &&
            chosenPayment == allTranslations.text("fromWallet")) {
          child = Text(
              ("${(double.parse(discountVolume.value.toString())).round()} %").toString(),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontFamily: "cairo"
              )
          );
        }

        /// discount of minimum

        if (discountVolume.valueType == "price" &&
            discountVolume.type == "minimum" &&
            chosenPayment == allTranslations.text("receipt")) {
          child = Text(
              "${discountVolume.value}   ${userModel.user.currencyName}",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontFamily: "cairo"
              )
          );
        } else if (discountVolume.valueType == "percentage" &&
            discountVolume.type == "minimum" &&
            chosenPayment == allTranslations.text("receipt")) {
          child = Text(
              ("${(double.parse(discountVolume.value.toString())).round()} %").toString(),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontFamily: "cairo"
              )
          );
        }

        /// discount of delivery

        if (discountVolume.valueType == "price" &&
            discountVolume.type == "delivery" &&
            chosenPayment == allTranslations.text("receipt")) {
          child = Text(
              "${discountVolume.value.toString()} ${userModel.user.currencyName}",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontFamily: "cairo"
              )
          );
        } else if (discountVolume.valueType == "percentage" &&
            discountVolume.type == "delivery" &&
            chosenPayment == allTranslations.text("receipt")) {
          child = Text(
              ("${(double.parse(discountVolume.value.toString())).round()} %").toString(),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontFamily: "cairo"
              )
          );

        }
      }

      return Container(child: child);

    }
    try {
      total = amountToBePaid - discount - couponDiscount - deliveryPriceAfterDiscount;
    } catch (e) {
      if(kDebugMode){
        debugPrint("error bill $e");
      }
    }
    return Consumer<ConnectivityNotifier>(
      builder: (context , connection , child){
        return SafeArea(
            child: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.surface,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                  child: const CustomAppBar(),
                ),
                body: connection.hasConnection
                    ? Padding(
                    padding:  EdgeInsets.all(10.0.w),
                    child: ListView(
                      children: [


                        /// coupon details
                        ChangeNotifierProvider<CouponModel>(
                          create: (context) => CouponModel(context),
                          child: Consumer<CouponModel>(
                            builder: (context, model, child) {
                              return Container(
                                padding: EdgeInsets.all(10.0.w),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormFieldWithName(
                                      controller: couponController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      hintTextFormField: allTranslations.text("couponHint"),
                                      fieldName: allTranslations.text("couponDetails"),
                                      textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontFamily: "cairo"
                                      ),
                                      fieldNameStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),

                                      onFieldSubmitted: () {
                                        FocusScope.of(context).unfocus();
                                      },

                                    ),



                                    10.ph,
                                    couponController.text.isEmpty
                                        ? 0.ph
                                        : InkWell(
                                      onTap: () async {
                                        if (couponController.text.isNotEmpty) {
                                          setState(() {
                                            isCouponCheck = true;
                                          });
                                          if (await model.checkNormalCoupon(
                                            number: couponController.text,

                                          )) {
                                            setState(() {
                                              couponPrice = double.parse(model.coupon.price.toString());
                                              couponType = model.coupon.valueType;
                                              couponText = couponController.text;
                                            });

                                            CustomDialog.showCustomDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                title: allTranslations.text("correctCoupon"),
                                                description: Text(
                                                  couponType == "price"
                                                      ? "${double.parse(model.coupon.price.toString())}"
                                                      : "${double.parse(model.coupon.price.toString()).round()} %",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: "cairo"

                                                  ),
                                                ),
                                                withActions: true,
                                                withYesButton: true,
                                                onPressed: (){
                                                  CustomDialog.hideCustomDialog(context);
                                                }
                                            );
                                            setState(() {
                                              isCouponCheck = false;
                                            });
                                          } else {
                                            CustomDialog.showCustomDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                title: allTranslations.text("errorCoupon"),
                                                icon: Lottie.asset(
                                                  AppLottie.error,
                                                  width: 100.w,
                                                  height: 100.h,
                                                  repeat: true,
                                                ),
                                                withActions: true,
                                                withYesButton: true,
                                                onPressed: (){
                                                  CustomDialog.hideCustomDialog(context);
                                                }
                                            );

                                            setState(() {
                                              couponText = "";
                                              couponPrice = 0.0;
                                              couponType = "price";
                                              isCouponCheck = false;
                                              couponController.clear();
                                            });
                                            text = Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  allTranslations.text("errorCoupon"),
                                                  style: const TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12,
                                                      fontFamily: "cairo",
                                                      fontWeight: FontWeight.normal),
                                                ),
                                              ],
                                            );
                                          }
                                          setState(() {
                                            checkState = true;
                                          });
                                        }
                                      },
                                      child:  isCouponCheck == false
                                          ? CustomButtons(
                                        text: allTranslations.text("checkCoupon"),
                                        buttonColor: Theme.of(context).secondaryHeaderColor,
                                      )
                                          : const CircularLoading(),
                                    ),


                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        15.ph,

                        /// note text filed

                        Container(
                          padding: EdgeInsets.all(10.0.w),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                          ),
                          child: TextFormFieldWithName(
                            controller: noteController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            hintTextFormField:  allTranslations.text("noteHint"),
                            fieldName: allTranslations.text("note"),
                            fieldNameStyle : Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 20.h , horizontal: 10.w),
                            // validator: (value){
                            //
                            // },
                            onFieldSubmitted: (){
                              FocusScope.of(context).unfocus();
                            },
                          ),
                        ),

                        15.ph,

                        /// payment method
                        financialPortfoliosModel.isLoading || financialPortfoliosModel.loadingFailed
                            ? const CircularLoading()
                            : Consumer<FinancialPortfoliosModel>(
                          builder: (context , model , child){
                            // model.getFinancialPortfolios();
                            return   Container(
                              padding:  EdgeInsets.all(10.0.w),
                              height: 140.h,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color:  Theme.of(context).primaryColor,
                                borderRadius:  BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    allTranslations.text("paymentMethods"),
                                    style:   Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

                                  5.ph,
                                  Flexible(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: model.items.length,
                                      itemBuilder: (context , index){
                                        return Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: 5.w , vertical: 10.h),
                                          child: InkWell(
                                            onTap: () async{

                                              setState(() {
                                                paymentIndex = index;
                                                isUnsupportedCurrency = false;
                                                chosenPayment = model.items[paymentIndex].name.toString();
                                              });
                                              // financialPortfoliosModel.chosenPayment = model.items[paymentIndex].name.toString();

                                              // if(financialPortfoliosModel.chosenPayment == allTranslations.text("card")){
                                              //   if(userModel.user.currencyName == "ريال يمني" || userModel.user.currencyName == "RY"){
                                              //     setState(() {
                                              //       isUnsupportedCurrency = true;
                                              //     });
                                              //     CustomToast.showFlutterToast(
                                              //         context: context,
                                              //         message: allTranslations.text('unsupportedCurrency')
                                              //     );
                                              //
                                              //   }else {
                                              //
                                              //     pushScreen(context,   StripePaymentScreen(
                                              //       orderTotal: total.toStringAsFixed(2),
                                              //       currency: userModel.user.currencyName.toString(),
                                              //     ));
                                              //   }
                                              //
                                              //   // await payPalModel.loginPayPal();
                                              // }


                                              /// paypal
                                              if (chosenPayment == allTranslations.text("payPal")) {
                                                if(userModel.user.currencyName == "دولار إمريكي" || userModel.user.currencyName == "USD"){
                                                  // LoadingDialog().showSimpleDialog(context);
                                                  CustomLoadingDialog.showLoading(context);
                                                  await payPalModel.loginPayPal();
                                                  await payPalModel.payPal(
                                                    auth: payPalModel.accessToken,
                                                    total: total.round().toString(),
                                                  );
                                                  if(kDebugMode){
                                                    debugPrint("login payPal auth = ${payPalModel.accessToken}");
                                                    debugPrint("href = ${payPalModel.href}");
                                                  }

                                                  if(payPalModel.href != ""){
                                                    CustomLoadingDialog.hideLoading(context);
                                                    CustomDialog.showCustomDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      title: allTranslations.text("paypalInstructions"),
                                                      icon: const Icon(
                                                        Icons.info_outline_rounded,
                                                        size: 90,
                                                        color: Colors.grey,
                                                      ),
                                                      description: Text(
                                                        allTranslations.text("instructions"),
                                                        textAlign: TextAlign.center,
                                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      withYesButton: true,
                                                      withActions: true,
                                                      withNoButton: true,
                                                      onPressed: () async{
                                                        _launchURL(payPalModel.href, "لا يمكن الوصول الى الموقع");
                                                        CustomLoadingDialog.hideLoading(context);
                                                        Future.delayed(const Duration(seconds: 10) , (){
                                                          CustomDialog.showCustomDialog(
                                                            context: context,
                                                            barrierDismissible: true,
                                                            title: allTranslations.text("enterPayerId"),
                                                            description: CustomTextFormField(
                                                              controller: payerController,
                                                              keyboardType: TextInputType.number,
                                                              textInputAction: TextInputAction.done,
                                                              hintText:  allTranslations.text("enterPayerId"),
                                                              textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                  fontFamily: "cairo"
                                                              ),
                                                              hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                  fontFamily: "cairo"
                                                              ),
                                                              contentPadding: EdgeInsets.symmetric(vertical: 10.h , horizontal: 10.w),
                                                              // validator: (v) {
                                                              //   if (v.length == 0) {
                                                              //     return allTranslations.text('fieldRequired');
                                                              //   }
                                                              //   return null;
                                                              // },
                                                              onFieldSubmitted: () {
                                                                FocusScope.of(context).unfocus();
                                                              },
                                                            ),
                                                            withYesButton: true,
                                                            withActions: true,
                                                            onPressed: () async{
                                                              CustomLoadingDialog.showLoading(context);
                                                              await payPalModel.executePayPal(
                                                                  auth: payPalModel.accessToken,
                                                                  payerId: payerController.text
                                                              );
                                                              if(payPalModel.message != "Requested resource ID was not found."){
                                                                await sendRequest();
                                                                CustomLoadingDialog.hideLoading(context);
                                                              }else {
                                                                CustomLoadingDialog.hideLoading(context);
                                                                CustomLoadingDialog.hideLoading(context);
                                                                CustomDialog.showCustomDialog(
                                                                  context: context,
                                                                  barrierDismissible: false,
                                                                  title: allTranslations.text("alert"),
                                                                  description: Text(
                                                                    payPalModel.message,
                                                                    textAlign: TextAlign.center,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                        fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                  withYesButton: true,
                                                                  withActions: true,
                                                                  onPressed: ()  {
                                                                    CustomLoadingDialog.hideLoading(context);
                                                                  },
                                                                );
                                                              }
                                                            },
                                                          );
                                                        });
                                                      },
                                                    );
                                                  }

                                                }else {
                                                  setState(() {
                                                    isUnsupportedCurrency = true;
                                                  });
                                                  CustomToast.showFlutterToast(
                                                      context: context,
                                                      message: allTranslations.text('unsupportedCurrency')
                                                  );
                                                }

                                              }


                                              /// tap payment
                                              else if (chosenPayment == allTranslations.text("paymentCards")){
                                                CustomLoadingDialog.showLoading(context);
                                                tapPaymentModel.createCharge(
                                                    amount: total.toStringAsFixed(2).toString(),
                                                    currency: userModel.shortcutCurrency
                                                ).then((value) {
                                                  if(tapPaymentModel.tapId != ''){
                                                    _launchURL(tapPaymentModel.transactionUrl, "لا يمكن الوصول الى الموقع");
                                                    CustomLoadingDialog.hideLoading(context);
                                                  }else {
                                                    CustomLoadingDialog.hideLoading(context);
                                                    CustomDialog.showCustomDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      title: tapPaymentModel.errorDescription,
                                                      withYesButton: true,
                                                      withActions: true,
                                                      onPressed: () async{
                                                        CustomDialog.hideCustomDialog(context);
                                                      },
                                                    );
                                                  }
                                                });



                                              }




                                            },
                                            child: Container(
                                                width: 100.w,
                                                padding: EdgeInsets.all(5.w),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                                    color: themeModel.darkTheme == true
                                                        ? Colors.grey[300]
                                                        : Theme.of(context).primaryColor,
                                                    border: Border.all(
                                                        width: 3.w,
                                                        color: paymentIndex == index
                                                            ? Theme.of(context).colorScheme.secondary
                                                            : Theme.of(context).colorScheme.surface
                                                    )
                                                ),
                                                child:  Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                                      child: CustomCachedNetworkImage(
                                                        imageUrl: model.items[index].imagePath100.toString(),
                                                        fit: BoxFit.contain,
                                                        width: 30.w,
                                                        height: 30.h,
                                                      ),
                                                    ),
                                                    10.ph,
                                                    Text(
                                                      model.items[index].name.toString(),
                                                      textAlign: TextAlign.center,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                          color: Theme.of(context).textTheme.bodyLarge?.color
                                                      ),
                                                    ),

                                                  ],
                                                )
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );

                          },
                        ),

                        15.ph,

                        chosenPayment == allTranslations.text("fromWallet")
                            ?  getStateOfWalletBalanceWidget()
                            : 0.ph,

                        15.ph,
                        /// bill details

                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(5.0.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.0.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  allTranslations.text("billDetails"),
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),


                                15.ph,

                                /// items count
                                CustomTowText(
                                  title: allTranslations.text("itemsCount"),
                                  titleStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold
                                  ),
                                  subTitle : widget.request.requestItems!.cartProductItems!.length.toString(),
                                  subTitleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                                      fontFamily: "cairo"
                                  ),
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                ),
                                15.ph,

                                const Divider(),

                                /// total
                                CustomTowText(
                                  title: allTranslations.text("total"),
                                  titleStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold
                                  ),
                                  subTitle : "${widget.request.requestItems!.priceSum} ${userModel.user.currencyName}",
                                  subTitleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                                      fontFamily: "cairo"
                                  ),
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                ),
                                15.ph,
                                const Divider(),

                                /// shipping fee

                                CustomTowText(
                                  title: allTranslations.text("shippingFee"),
                                  titleStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold
                                  ),
                                  subTitle :  "$deliveryPrice ${userModel.user.currencyName}",
                                  subTitleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                                      fontFamily: "cairo"
                                  ),
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                ),
                                15.ph,
                                const Divider(),




                                /// tax fee

                                if (taxModel.items.isEmpty)
                                  0.ph
                                else if(taxModel.isLoading || taxModel.loadingFailed)
                                  const CircularLoading()
                                else if (userModel.loadingFailed || userModel.isLoading)
                                    const CircularLoading()
                                  else if (taxModel.taxPrice.price == "0.00")
                                      0.ph
                                    else if (userModel.user.countryId == taxModel.taxPrice.countryId)
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(bottom: 15.0.h),
                                              child: CustomTowText(
                                                title: "${allTranslations.text("taxFee")}  " " ${taxModel.taxPrice.price} %",
                                                titleStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "cairo"
                                                ),

                                                subWidget: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      tax.toStringAsFixed(2),
                                                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                          fontFamily: "cairo"
                                                      ),
                                                    ),
                                                    5.pw,
                                                    Center(
                                                      child: Text(
                                                        "${userModel.user.currencyName}",
                                                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                            fontFamily: "cairo",
                                                            fontSize: 10.sp
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),

                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              ),
                                            ),
                                            const Divider(),
                                          ],
                                        ),




                                /// coupon
                                couponPrice == 0.0
                                    ? 0.ph
                                    : CustomTowText(
                                  title: allTranslations.text("coupon"),
                                  titleStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold
                                  ),
                                  subTitle : couponType == "price"
                                      ? "$couponPrice  ${userModel.user.currencyName}"
                                      : ("${couponPrice.round()} %" ).toString(),
                                  subTitleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                                      fontFamily: "cairo"
                                  ),
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                ),

                                15.ph,

                                couponPrice == 0.0
                                    ? 0.ph
                                    : const Divider(),

                                /// discount

                                if(discountModel.isLoading || discountModel.loadingFailed)
                                  const Align(alignment: Alignment.centerLeft, child:   CircularLoading(),)
                                else if (discountVolume != null && discountVolume.type == "balance"
                                    && chosenPayment == allTranslations.text("fromWallet"))
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomTowText(
                                        title: chosenPayment == allTranslations.text("fromWallet") && discountVolume.type.toString() == "balance"
                                            ? "${allTranslations.text("discountOfBalance")}:"
                                            : discountVolume.type.toString() == "minimum"
                                            ? "${allTranslations.text("discount")}:"
                                            : discountVolume.type.toString() == "delivery"
                                            ? "${allTranslations.text("discountOfDeliver")}:"
                                            : "${allTranslations.text("discount")}:",
                                        titleStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold
                                        ),
                                        subWidget : calculationDiscount(context),
                                        subTitleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                                            fontFamily: "cairo"
                                        ),
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      ),
                                      const Divider()
                                    ],
                                  )
                                else if(discountVolume != null && discountVolume.type != "balance"
                                      && chosenPayment == allTranslations.text("receipt"))
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomTowText(
                                          title:  discountVolume.type.toString() == "minimum"
                                              ? "${allTranslations.text("discount")}:"
                                              : discountVolume.type.toString() == "delivery"
                                              ? "${allTranslations.text("discountOfDeliver")}:"
                                              : "${allTranslations.text("discount")}:",
                                          titleStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.bold
                                          ),
                                          subWidget : calculationDiscount(context),
                                          subTitleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                                              fontFamily: "cairo"
                                          ),
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        ),
                                        const Divider()
                                      ],
                                    )
                                  else  0.ph,

                                15.ph,

                                /// amount to be Paid
                                CustomTowText(
                                  title: allTranslations.text("amountToBePaid"),
                                  titleStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold
                                  ),
                                  subTitle : "${total.toStringAsFixed(2)} ${userModel.user.currencyName}",
                                  subTitleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                                      fontFamily: "cairo"
                                  ),
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                ),
                                15.ph,



                              ],
                            ),

                          ) ,
                        ),




                      ],
                    )
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: CustomMessage(
                          appLottieIcon: AppLottie.noConnection,
                          message: allTranslations.text("networkConnection"),
                        ))
                  ],
                ),
                bottomNavigationBar:  userModel.isLoading || userModel.loadingFailed
                    ? const BillShimmer()
                    : Padding(
                  padding:  EdgeInsets.all(10.0.w),
                  child: isUnsupportedCurrency == true
                      ? CustomButtons(
                      height: 45.h,
                      text: allTranslations.text("confirmPurchase"),
                      buttonColor: Colors.grey
                  )
                      : CustomButtons(
                    height: 45.h,
                    text: allTranslations.text("confirmPurchase"),
                    textWidget: isLoading == false
                        ? null
                        : const CircularLoading(),
                    buttonColor: isLoading == false
                        ? Theme.of(context).secondaryHeaderColor
                        : Theme.of(context).colorScheme.surface,
                    onTap: () async{

                      if(connection.hasConnection){

                        if(chosenPayment == null){
                          return CustomToast.showFlutterToast(
                              context: context,
                              message: allTranslations.text("selectPaymentFirst")
                          );
                        }
                        else if(chosenPayment == allTranslations.text("fromWallet") && total > double.parse(userWalletModel.userCurrentBalance.currentBalance.toString())){
                          return CustomToast.showFlutterToast(
                              context: context,
                              message: allTranslations.text("noEnoughBalance")
                          );
                        }
                        else if(chosenPayment == allTranslations.text("payPal") && (payPalModel.message == "Requested resource ID was not found." || payPalModel.message == "")){
                          return CustomToast.showFlutterToast(
                              context: context,
                              message: allTranslations.text("paymentNotComplete")
                          );
                        }

                        else if(chosenPayment == allTranslations.text("paymentCards")){
                          CustomLoadingDialog.showLoading(context);
                          tapPaymentModel.getRetrieveCharge().then((value) {
                            if(tapPaymentModel.chargeId != '' && tapPaymentModel.tapId != ''){
                              CustomLoadingDialog.hideLoading(context);
                              if(tapPaymentModel.chargeId == tapPaymentModel.tapId && tapPaymentModel.chargeStatus == "CAPTURED"){
                                setState((){
                                  isLoading = true;
                                });

                                /// send request
                                sendRequest();
                              }else {
                                return CustomToast.showFlutterToast(
                                    context: context,
                                    message: allTranslations.text("paymentNotComplete")
                                );
                              }
                            }
                          });

                        }
                        else{
                          setState((){
                            isLoading = true;
                          });

                          /// send request
                          await sendRequest();
                        }

                      }
                      else {
                        CustomToast.showFlutterToast(
                          context: context,
                          message: allTranslations.text("networkConnection"),
                          toastLength: Toast.LENGTH_LONG,
                        );
                      }



                    },
                  ),
                )
            )

        );
      },
    );
  }
  Widget getStateOfWalletBalanceWidget() {

    return Consumer<UserModel>(builder: (context, model, child) {
      var userWalletModel = Provider.of<UserWalletModel>(context);
      var cartProvider = Provider.of<CartModel>(context);
      var userBalance;
      model.isLoaded
          ? userWalletModel.items.isEmpty
          ? userBalance = "0.0"
          : userBalance = userWalletModel.userCurrentBalance.currentBalance
          : userBalance = 0.0;
      var sumOfCart;
      cartProvider.isLoaded
          ? sumOfCart =  total
          : sumOfCart = 0.0;
      return userWalletModel.isLoading || userWalletModel.loadingFailed
          ? const CircularLoading()
          :  CustomCardIconText(
        color: double.parse(userBalance) >= sumOfCart
            ? AppColors.green
            : AppColors.red,
        icon: Icons.wallet,
        backIconColor: Colors.white24,
        iconColor: Colors.white,
        height: 40.h,
        width: 45.w,
        secondWidget: Text(
            userWalletModel.items.isEmpty
                ? "0.0"
                : userWalletModel.userCurrentBalance.currentBalance.toString(),
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: "cairo"
            )
        ),
        itemsName: double.parse(userBalance) >= sumOfCart
            ? allTranslations.text('enoughBalance')
            : allTranslations.text('noEnoughBalance'),
        itemsNameStyle: Theme.of(context).textTheme.displayLarge,
      );
    });
  }

  _launchURL(url, msg) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url),
        // mode: LaunchMode.externalApplication
      );
    } else {
      throw msg;
    }
  }

}