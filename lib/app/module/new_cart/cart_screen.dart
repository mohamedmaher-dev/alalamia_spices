// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:alalamia_spices/app/global_widgets/circular_loading.dart';
// import 'package:alalamia_spices/app/global_widgets/custom_app_bar.dart';
// import 'package:alalamia_spices/app/module/new_cart/widget/inc_dec_buttons.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import 'package:provider/provider.dart';
// import '../../core/utils/constants.dart';
// import '../../core/values/app_images.dart';
// import '../../core/values/app_lottie.dart';
// import '../../data/model/connectivity_model.dart';
// import '../../global_widgets/continue_purchasing_button.dart';
// import '../../global_widgets/custom_message.dart';
// import '../../global_widgets/custom_rotated_box.dart';
// import '../../global_widgets/custom_two_text.dart';
// import '../../global_widgets/no_internet_message.dart';
// import '../../services/screen_navigation_service.dart';
// import '../auth/auth_tabs_screen.dart';
// import '../check_out/check_out_screen.dart';
// import '../home/widget/home_app_bar.dart';
// import '../product_details/product_details_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class CartScreen extends StatefulWidget {
//     // String cartId;
//     final bool isFromProductDetails;
//     CartScreen({
//     // required this.cartId,
//     required this.isFromProductDetails,
//     Key? key}) : super(key: key);
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   String? cartQuantity;
//   Future getCartId(BuildContext context) async {
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      cartID =  prefs.getString('cart_id') ?? "";
//      setState(() {
//
//      });
//   }
//
//   @override
//   void initState() {
//      super.initState();
//     getCartId(context);
//     Future.delayed(const Duration(seconds: 1) , () async{
//       await Provider.of<NewCartModel>(context , listen: false).loadData();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//      return ChangeNotifierProvider<NewCartModel>(
//        create: (context) => NewCartModel(context),
//        child: Consumer<NewCartModel> (
//          builder: (context , newCartModel , child) {
//
//            // if (kDebugMode) {
//            //   print(" cart screen id   ${widget.cartId}");
//            // }
//            return SafeArea(
//              child: Scaffold(
//                  backgroundColor: Theme.of(context).backgroundColor,
//                  appBar: PreferredSize(
//                    preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
//                    child:  widget.isFromProductDetails == true
//                        ? const CustomAppBar()
//                        : const HomeAppBar(),
//                  ),
//                body: Column(
//                  mainAxisAlignment: newCartModel.items.length > 0
//                      ? MainAxisAlignment.start
//                      : MainAxisAlignment.center,
//                  children: [
//
//                    newCartModel.isLoading || newCartModel.loadingFailed
//                        ? const CircularLoading()
//                        : newCartModel.items.isEmpty
//                        ? Center(
//                      child: CustomMessage(
//                        message: allTranslations.text("letsFillItIn"),
//                        appLottieIcon: AppLottie.emptyCart,
//                      ),
//                    )
//                        : Expanded(
//                      child: ListView.builder(
//                        itemCount: newCartModel.items.length,
//                        itemBuilder: (context , index){
//
//                          return Row(
//                            children: [
//                              /// type of product
//                              Container(
//                                color: Theme.of(context).primaryColor,
//                                height: 110.h,
//                                padding: const EdgeInsets.all(5.w),
//                                child:  CustomRotatedBox(
//                                  text: newCartModel.items[index].type == "product"
//                                      ? allTranslations.text("productType")
//                                      : newCartModel.items[index].type == "offer"
//                                      ? allTranslations.text("offerType")
//                                      : newCartModel.items[index].type == "special_product"
//                                      ? allTranslations.text("specialProduct")
//                                      : newCartModel.items[index].type == "special"
//                                      ? allTranslations.text("specialProduct")
//                                      : allTranslations.text("productType"),
//                                  textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                      fontWeight: FontWeight.bold
//                                  ),
//                                ),
//                              ),
//
//                              Expanded(
//                                flex : 5,
//                                child: Padding(
//                                  padding:  EdgeInsets.symmetric(vertical: 10.0.h , horizontal: 3.w),
//                                  child: Container(
//                                    height: 110.h,
//                                    width: MediaQuery.of(context).size.width,
//                                    padding: const EdgeInsets.all(5.w),
//                                    decoration: BoxDecoration(
//                                        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                                        color: Theme.of(context).primaryColor // white color
//                                    ),
//                                    child: Row(
//                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                      crossAxisAlignment: CrossAxisAlignment.center,
//                                      children: [
//                                        Expanded(
//                                          flex: 3,
//                                          child: Column(
//                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                            crossAxisAlignment: CrossAxisAlignment.start,
//                                            children: [
//
//                                              /// product name
//
//                                              CustomTowText(
//                                                title: allTranslations.text("productName"),
//                                                titleStyle: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                                                  fontWeight: FontWeight.bold,
//
//                                                ),
//                                                subTitle: "${newCartModel.items[index].name}",
//                                                textOverflow: TextOverflow.ellipsis,
//                                                maxLines: 1,
//                                                subTitleStyle: Theme.of(context).textTheme.caption!.copyWith(
//                                                    fontWeight: FontWeight.bold,
//                                                    fontFamily: "cairo"
//                                                ),
//
//                                              ),
//
//                                              /// adds
//                                              freeAdd == null && freeAdd == ""
//                                                  ? 0.ph
//                                                  : CustomTowText(
//                                                title: allTranslations.text("add"),
//                                                titleStyle: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                                                  fontWeight: FontWeight.bold,
//
//                                                ),
//                                                subTitle: "${newCartModel.items[index].addAr}",
//                                                textOverflow: TextOverflow.ellipsis,
//                                                maxLines: 1,
//                                                subTitleStyle: Theme.of(context).textTheme.caption!.copyWith(
//                                                    fontWeight: FontWeight.bold,
//                                                    fontFamily: "cairo"
//                                                ),
//
//                                              ),
//
//
//
//                                              /// product price
//
//                                              CustomTowText(
//                                                title: allTranslations.text("productPrice")  ,
//                                                titleStyle: Theme.of(context).textTheme.bodyMedium!!.copyWith(
//                                                  fontWeight: FontWeight.bold,
//
//                                                ),
//                                                subTitle: "${newCartModel.items[index].price}  ${newCartModel.items[index].currency}"
//                                                ,
//                                                subTitleStyle: Theme.of(context).textTheme.caption!.copyWith(
//                                                    fontWeight: FontWeight.bold,
//                                                    fontFamily: "cairo"
//                                                ),
//
//                                              ),
//
//
//                                              /// increment & decrement & delete icon
//                                              IncDecButtons(
//                                                onTapInc: ()  async{
//                                                  // setState(() async{
//                                                    cartQuantity = double.parse(newCartModel.items[index].quantity).round().toString();
//                                                    int quantity = int.parse(cartQuantity!);
//                                                    quantity++;
//                                                    cartQuantity = quantity.toString();
//                                                    await newCartModel.increaseQuantity(newCartModel.items[index], newCartModel.items[index].type, cartQuantity.toString() , newCartModel.items[index].cartDetailsId);
//                                                    newCartModel.loadData();
//                                                  // });
//                                                },
//                                                quantity: double.parse(newCartModel.items[index].quantity.toString()).round().toString(),
//                                                onTapDec: () async{
//                                                  // setState(() async{
//                                                    cartQuantity = double.parse(newCartModel.items[index].quantity).round().toString();
//                                                    int quantity = int.parse(cartQuantity!);
//                                                    if (quantity > 1) {
//                                                      quantity--;
//                                                      cartQuantity = quantity.toString();
//                                                      await newCartModel.increaseQuantity(newCartModel.items[index], newCartModel.items[index].type, cartQuantity.toString() , newCartModel.items[index].cartDetailsId );
//                                                      newCartModel.loadData();
//                                                    }
//                                                  // });
//                                                },
//                                                onTapDelete: () async{
//                                                  await newCartModel.deleteSingleProduct(newCartModel.items[index], newCartModel.items[index].cartDetailsId);
//                                                  await newCartModel.loadData();
//                                                },
//                                              )
//                                            ],
//                                          ),
//                                        ),
//
//                                        Expanded(
//                                          child: ClipRRect(
//                                            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                                            child: SizedBox(
//                                              height: 90.h,
//                                              width: 90.w,
//                                              child: CachedNetworkImage(
//                                                fit: BoxFit.fill,
//                                                imageUrl: newCartModel.items[index].image.toString(),
//                                                placeholder: (context, url) => SizedBox(
//                                                  width: 70,
//                                                  height: 70,
//                                                  child: Padding(
//                                                      padding: EdgeInsets.all(10.0.w),
//                                                      child: Image.asset(
//                                                        AppImages.logo,
//                                                      )),
//                                                ),
//                                                errorWidget: (context, url, error) => SizedBox(
//                                                  width: 70,
//                                                  height: 70,
//                                                  child: Padding(
//                                                      padding: EdgeInsets.all(10.0.w),
//                                                      child: Image.asset(
//                                                        AppImages.logo,
//                                                      )),
//                                                ),
//                                              ),
//
//                                            ),
//
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                              ),
//
//
//
//
//                            ],
//                          );
//                        },
//                      ),
//                    )
//
//
//
//                  ],
//                ),
//
//                bottomNavigationBar: Consumer<ConnectivityNotifier>(
//                  builder: (context , connection , child) {
//                    return newCartModel.items.length > 0
//                        ? connection.hasConnection
//                        ? ContinuePurchasingButton(
//                      childPurchasing:  Padding(
//                        padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: [
//
//                            CustomTowText(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              title: allTranslations.text("billTotal"),
//                              titleStyle: Theme.of(context).textTheme.headline1!.copyWith(
//                                fontWeight: FontWeight.bold,
//
//                              ),
//                              subTitle: "${newCartModel.totalPrice} "   " ${newCartModel.items[0].currency}",
//                              subTitleStyle: Theme.of(context).textTheme.headline2!.copyWith(
//                                  fontWeight: FontWeight.bold,
//                                  fontSize: 12.sp,
//                                  color: Theme.of(context).colorScheme.secondary,
//                                  fontFamily: "cairo"
//                              ),
//
//                            ),
//
//                            CustomTowText(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              title: allTranslations.text("itemsCount"),
//                              titleStyle: Theme.of(context).textTheme.headline1!.copyWith(
//                                fontWeight: FontWeight.bold,
//
//
//                              ),
//                              subTitle: newCartModel.items.length.toString(),
//                              subTitleStyle: Theme.of(context).textTheme.headline2!.copyWith(
//                                  fontWeight: FontWeight.bold,
//                                  color: Theme.of(context).colorScheme.secondary,
//                                  fontFamily: "cairo"
//                              ),
//
//                            ),
//
//
//
//
//
//
//
//                          ],
//                        ),
//                      ),
//                      childShopping: Center(
//                        child: Text(
//                            allTranslations.text("completeOrder"),
//                            textAlign: TextAlign.center,
//                            style: Theme.of(context).textTheme.headline1!.copyWith(
//                              fontWeight: FontWeight.bold,
//                            )
//                        ),
//                      ),
//                      // complete order
//                      onTapShopping: (){
//                        appModel.token == "visitor"
//                            ? PersistentNavBarNavigator.pushNewScreen(
//                          context,
//                          screen: const AuthTabsScreen(),
//                          withNavBar: false, // OPTIONAL VALUE. True by default.
//                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
//                        )
//
//                            : pushScreen(context , const CheckOutScreen());
//                      },
//                    )
//                        : const NoInternetMessage()
//                        :  0.ph ;
//                  },
//                )
//
//
//
//              ),
//            );
//          },
//        ),
//      );
//   }
// }
