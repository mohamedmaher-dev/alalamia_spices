import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/data/model/aramex_shipment.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:alalamia_spices/app/global_widgets/svg_picture_assets.dart';
import 'package:alalamia_spices/app/module/bill/bill_screen.dart';
import 'package:alalamia_spices/app/module/bill/provider/bill_provider.dart';
import 'package:alalamia_spices/app/module/check_out/providers/shipping_type_provider.dart';
import 'package:alalamia_spices/app/module/check_out/widget/aramex_details.dart';
import 'package:alalamia_spices/app/module/check_out/widget/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../core/utils/constants.dart';
import '../../core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import '../../data/model/request.dart';
import '../user/last_orders/last_orders_screen.dart';
import 'package:alalamia_spices/app/exports/model.dart';


class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BillProvider())
      ],
      child: const SubCheckOutScreen(),
    );
  }
}


class SubCheckOutScreen extends StatefulWidget {
  const  SubCheckOutScreen({Key? key}) : super(key: key);

  @override
  State<SubCheckOutScreen> createState() => _SubCheckOutScreenState();
}

class _SubCheckOutScreenState extends State<SubCheckOutScreen> {
  bool isShippingHidden = false;
  bool isLoading = false;
  late TextEditingController dateController;
  late TextEditingController hourController;
  late TextEditingController minuteController;
  ShippingTypeProvider shippingTypeModel = ShippingTypeProvider();

  double  deliveryPrice = 0.0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var returnOfRequest;
  var cartStatus;
  int? cartId;
  String? _selectedDeliveryType;


  @override
  void initState() {
    super.initState();
    // getCartId(context);
    dateController  = TextEditingController();
    hourController  = TextEditingController();
    minuteController  = TextEditingController();
    Future.delayed(const Duration(seconds: 0) , () async{
      await Provider.of<NewDeliveryPriceModel>(context , listen: false).loadData(context);
      await Provider.of<NewDeliveryPriceModel>(context , listen: false).getMinimumTotalOrder(context);
    });

  }



  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    hourController.dispose();
    minuteController.dispose();
  }

  Future sendExternalRequest(BuildContext context) async {
    var requestModel = Provider.of<RequestModel>(context , listen: false);
    var cartModel = Provider.of<CartModel>(context , listen: false);
    var userModel = Provider.of<UserModel>(context , listen: false);
    var billProvider = Provider.of<BillProvider>(context, listen: false);
    Request request;
    CartList cartList = CartList(items: List<CartItem>.from(cartModel.items));
    cartStatus = await cartModel.sendCart(cartList);
    // NewCartList cartList = NewCartList(items: List<NewCart>.from(newCartModel.items));
    //  cartStatus = await newCartModel.sendCart(cartList);
    if (cartModel.isLoaded) {
      // cartId = cartID.toString();
      cartId = cartStatus["cart_id"];
      if (kDebugMode) {
        debugPrint("******** cart id $cartId");
      }
      request = Request(
          countryId: userModel.user.countryId..toString(),
          deliveryPricing: deliveryPrice.toString(),
          currency: userModel.countryCurrencyId.toString(),
          paymentType: "2",
          receivingType: billProvider.currentIndex == 1 && billProvider.currentShippingType == allTranslations.text("normalDelivery")
              ? "urgent"
              : "external",
          cartId: cartId.toString(),
          address_id: chosenLocationId ?? currentLocationId,
          deliverLocationId: "4",
          deliveryPriceId: "4",
          bookingDate: "${billProvider.selectedDate} -  ${billProvider.selectedHour} : ${billProvider.selectedMinute}"

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
              icon: Lottie.asset(
                AppLottie.error,
                width: 100.w,
                height: 100.h,
                repeat: false,
              ),
              description: Text(
                requestModel.errors["message"].toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold
                ),
              ),
              withActions: true,
              withYesButton: true,
              onPressed: (){
                CustomLoadingDialog.hideLoading(context);
              }
          );


          setState(() {
            isLoading = false;
            // selectedShippingType = null;
            // locationId = null;
            // selectedMinute = null;
            // selectedDate = null;
            // selectedHour = null;
          });
          if (kDebugMode) {
            debugPrint(requestModel.errors.toString());
            debugPrint(requestModel.errors["message"].toString());
          }
          await cartModel.loadData();
          // await newCartModel.loadData();

        }
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    shippingTypeModel.getShippingList(context);
    final cartModel = Provider.of<CartModel>(context);
    final userModel = Provider.of<UserModel>(context)..getUserInfo();
    final newDeliveryPriceModel = Provider.of<NewDeliveryPriceModel>(context);
    final billProvider = Provider.of<BillProvider>(context);
    final ceilingPriceModel = Provider.of<CeilingPriceModel>(context);

    return SafeArea(
      child: cartModel.items.length > 0
          ? Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
          child: const CustomAppBar(),
        ),
        body: ChangeNotifierProvider<UserModel>(
          create: (context) => UserModel(context),
          child: Consumer<UserModel>(
            builder: (context , model , child) {
              newDeliveryPriceModel.getMinimumTotalOrder(context);
              return  Padding(
                padding: EdgeInsets.all(10.0.w),
                child: ListView(
                  children: [
                    /// order details

                    const CartDetails(),
                    15.ph,

                    const LocationDetails(),

                    /// shipping type

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10.0.w),
                          decoration: BoxDecoration(
                            borderRadius:  BorderRadius.only(
                              bottomRight: Radius.circular(AppConstants.defaultBorderRadius.w),
                              bottomLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
                            ),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                allTranslations.text("shippingType"),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              15.ph,

                              ListView.separated(
                                itemCount: shippingTypeModel.shippingTypeList.length,
                                shrinkWrap: true,
                                primary: false,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context , _) => 5.ph,
                                itemBuilder: (context , index){
                                  final shippingType = shippingTypeModel.shippingTypeList[index];

                                  if (shippingType.name == allTranslations.text("aramex") && userModel.aramexStatus == "false") {
                                    return const SizedBox.shrink();
                                  }
                                  return Container(
                                    padding: EdgeInsets.all(5.w),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                        border: Border.all(
                                            color: _selectedDeliveryType == shippingType.name
                                                ? Theme.of(context).colorScheme.secondary
                                                : Colors.transparent,
                                            width: 2.w
                                        )
                                    ),
                                    child: Column(
                                      children: [
                                        _buildDeliveryTypeCard(
                                          title: shippingType.name.toString(),
                                          icon: shippingType.icon.toString(),
                                          value: shippingType.name.toString(),
                                          size: index == 1 ? 10.w : 26.w,
                                          padding: index == 1 ? 17.w :  12.w,
                                          onTap: () {
                                            setState(() {
                                              _selectedDeliveryType = shippingTypeModel.shippingTypeList[index].name;
                                            });
                                            billProvider.currentShippingType = _selectedDeliveryType!;
                                          },
                                        ),

                                        AnimatedSwitcher(
                                          duration: const Duration(milliseconds: 300),
                                          transitionBuilder: (child, animation) {

                                            return SlideTransition(
                                              position: Tween<Offset>(
                                                begin: const Offset(0.0, 0.1),
                                                end: Offset.zero,
                                              ).animate(animation),
                                              child: FadeTransition(
                                                opacity: animation,
                                                child: child,
                                              ),
                                            );
                                          },
                                          child: _selectedDeliveryType == shippingType.name
                                              ? Padding(
                                            padding:  EdgeInsets.only(top: 10.0.h),
                                            child: _buildShippingDetails(context , shippingType.name.toString()),
                                          )
                                              :  0.ph,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              );
            } ,
          ),
        ),

        bottomNavigationBar:  cartModel.totalPrice < double.parse(ceilingPriceModel.ceiling.price.toString())
            ? ceilingPriceDetails(context)
            : Padding(
          padding:  EdgeInsets.all(10.0.w),
          child:  _selectedDeliveryType == null
              ? CustomButtons (
            height: 45.h,
            text:  allTranslations.text("continuePurchasing"),
            buttonColor:  Colors.grey[400]!,
            textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: "cairo",
              fontSize: 12.sp,
            ),
          )
              : _selectedDeliveryType == allTranslations.text("aramex")
              ? 0.ph
              : CustomButtons (
                height: 45.h,
                text:  allTranslations.text("continuePurchasing"),
                buttonColor:  Theme.of(context).secondaryHeaderColor,
                textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: "cairo",
                  fontSize: 12.sp,
                ),

                onTap:  () {
                  chosenLocationId == null
                      ? CustomToast.showFlutterToast(
                      context: context,
                      message: allTranslations.text("selectLocationFirst")
                  )
                      : pushScreen(context , BillScreen(
                        shippingType: billProvider.shippingType.toString(),
                        shipmentData: ShipmentData(),
                  ));

                },
          ),
        )
      )
          : emptyWidget(context)
    );
  }

  Widget emptyWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
        child: const CustomAppBar(),
      ),
      body: Center(
        child: CustomMessage(
          message: allTranslations.text("letsFillItIn"),
          appLottieIcon: AppLottie.emptyCart,
        ),
      ),
    );
  }

  Widget _buildShippingDetails(BuildContext context , String shippingTypeName) {
    if (shippingTypeName == allTranslations.text("normalDelivery")) {
      return freeShippingMessage(context);
    }
    // else if (shippingTypeName == allTranslations.text("externalRequest")) {
    //   return dateAndTimePicker(context);
    // }
    else if (shippingTypeName == allTranslations.text("aramex")) {
      return aramexForm(context);
    } else {
      return 0.ph;
    }
  }

  Widget ceilingPriceDetails(BuildContext context) {
    var ceilingPriceModel = Provider.of<CeilingPriceModel>(context);
    var cartModel = Provider.of<CartModel>(context);
    if(ceilingPriceModel.items.isEmpty && ceilingPriceModel.loadingFailed){
      return 0.ph;
    }else {
      return Padding(
        padding:  EdgeInsets.all(10.0.w),
        child: Container(
          height: 45.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
              color:  Colors.grey
          ),
          child: Center(
            child: Text(
              "${allTranslations.text("minimumPrice")} "
                  "${double.parse(ceilingPriceModel.ceiling.price.toString()).round()} ${cartModel.items[0].currency}",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: "cairo",
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget freeShippingMessage(BuildContext context){
    var newDeliveryPriceModel = Provider.of<NewDeliveryPriceModel>(context);
    var userModel = Provider.of<UserModel>(context);
    if(userModel.isLoading || userModel.loadingFailed){
      return const CircularLoading();
    }else if (userModel.items.isEmpty){
      return 0.ph;
    }else {
      return Padding(
        padding:  EdgeInsets.only(top: 10.0.h),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10.0.h),
          decoration: BoxDecoration(
              borderRadius:  BorderRadius.circular(AppConstants.defaultBorderRadius.w),
              color: Theme.of(context).primaryColor.withOpacity(0.5)
          ),
          child: Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: allTranslations.text("freeShippingMessage"),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: "cairo",
                    ),
                  ),
                  TextSpan(
                    text: "${newDeliveryPriceModel.minimum} ",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: "cairo",
                    ),
                  ),
                  TextSpan(
                    text: userModel.user.currencyName,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: "cairo",
                        fontSize: 10.sp
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ) ,
        ),
      );
    }

  }

  // Widget freeDeliver(BuildContext context) {
  //   var billProvider = Provider.of<BillProvider>(context);
  //   billProvider.getDeliveryTypeList(context);
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.all(10.w),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               allTranslations.text("shippingDate"),
  //               style: Theme.of(context).textTheme.bodyLarge,
  //             ),
  //             10.ph,
  //             CustomDropDown(
  //                 height: 45.h,
  //                 listItem: billProvider.deliveryTypeItems,
  //                 value: billProvider.shippingType,
  //                 fillColor: Theme.of(context).primaryColor,
  //                 hintText: "",
  //                 onChanged: (newValue){
  //                   billProvider.shippingType = newValue.toString();
  //                   billProvider.currentIndex = billProvider.deliveryType.indexWhere((item) => item['name'] == newValue.toString());
  //                 }
  //             ),
  //
  //             if(billProvider.currentIndex == 0 && _selectedDeliveryType == allTranslations.text("internalRequest"))
  //               freeShippingMessage(context)
  //
  //           ],
  //         ),
  //       ),
  //       10.ph,
  //     ],
  //   );
  // }



  Widget aramexForm (BuildContext context){
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.ph,
          Text(
            allTranslations.text("recipientDetails"),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold
            ),
          ),
          5.ph,
          Text(
            allTranslations.text("shipmentPlace"),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold
            ),
          ),

          15.ph,
          AramexDetails(selectedAramex: _selectedDeliveryType == allTranslations.text("aramex"),)

        ],
      ),
    );
  }

  Widget _buildDeliveryTypeCard({
    required String title,
    required String icon,
    required String value,
    required VoidCallback onTap,
    required double size,
    required double padding,
  }) {
    return Material(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
        side: BorderSide(
          color: _selectedDeliveryType == value
              ? Theme.of(context).colorScheme.primary
              : Colors.grey.shade300,
          width: _selectedDeliveryType == value ? 2.w : 1.w,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
        child: Padding(
          padding:  EdgeInsets.all(padding),
          child: Row(
            children: <Widget>[
              SVGPictureAssets(
                image: icon,
                width: size,
                height: size,
              ),
              10.pw,
              Expanded(
                child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              if (_selectedDeliveryType == value)
                Icon(Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}