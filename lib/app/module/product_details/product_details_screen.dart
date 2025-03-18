//
// import 'package:facebook_app_events/facebook_app_events.dart';
// import 'package:alalamia_spices/app/core/utils/constants.dart';
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';new_arrival.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:alalamia_spices/app/global_widgets/custom_app_bar.dart';
// import 'package:alalamia_spices/app/global_widgets/custom_two_text.dart';
//  import 'package:alalamia_spices/app/module/product_details/providers/product_details_provider.dart';
// import 'package:alalamia_spices/app/module/product_details/widget/index.dart';
// import 'package:alalamia_spices/app/exports/services.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';
// import '../../global_widgets/continue_purchasing_button.dart';
// import '../../services/screen_navigation_service.dart';
// import '../cart/cart_tab.dart';
//
// // String?  freeAdd;
// List<String> freeAdd = [];
// String  cartID = "";
// class ProductDetailsScreen extends StatefulWidget {
//   final Product product;
//   const ProductDetailsScreen({
//     Key? key,
//     required this.product,
//   }) : super(key: key);
//
//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }
//
// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//
//  int selectedPrice = 0;
//  int quantity = 1;
//  bool showingCounter = false;
//   String? cartQuantity;
//  static final facebookAppEvents = FacebookAppEvents();
//  // Future getCartId(BuildContext context) async {
//  //    SharedPreferences prefs = await SharedPreferences.getInstance();
//  //    cartID = prefs.getString('cart_id') ?? "";
//  //    setState(() {
//  //
//  //    });
//  // }
//
//  // @override
//  // void initState() {
//  //   super.initState();
//  //   getCartId(context);
//  // }
//   @override
//   Widget build(BuildContext context) {
//     ProductDetailsProvider productDetailsProvider = ProductDetailsProvider();
//     var cartModel = Provider.of<CartModel>(context);
//     return DefaultTabController(
//       length: 2,
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: Theme.of(context).backgroundColor,
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
//             child: const CustomAppBar(),
//           ),
//           body: ListView(
//             children: [
//
//
//               /// header with image swiper
//               ProductDetailsHeader(
//                 product: widget.product,
//               ),
//
//               3.ph,
//               /// price details
//               widget.product.prices!.isNotEmpty
//               ? Container(
//                 height: 100.h,
//                 padding : EdgeInsets.all(5.w),
//                 color: Theme.of(context).primaryColor,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     /// units
//                     Flexible(
//                       child: StatefulBuilder(
//                         builder: (context , mySetState){
//                           return ListView.builder(
//                             shrinkWrap: true,
//                             primary: false,
//                             scrollDirection: Axis.horizontal,
//                             physics: const BouncingScrollPhysics(),
//                             itemCount: widget.product.prices!.length,
//                             itemBuilder: (context , index){
//                               return  InkWell(
//                                 onTap: (){
//                                   setState(() {
//                                     selectedPrice = index;
//                                     quantity = widget.product.prices![selectedPrice].productQuantity!;
//                                   });
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     height: 70.h,
//                                     padding: EdgeInsets.all(5.0.w),
//                                     decoration: BoxDecoration(
//                                       color: widget.product.prices![index].paidAdds == "true"
//                                           ? Theme.of(context).colorScheme.secondary.withOpacity(0.3)
//                                           : Colors.transparent,
//                                         borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                                         border: selectedPrice == index
//                                             ? widget.product.prices![index].paidAdds == "true"
//                                             ? Border.all(color: Theme.of(context).colorScheme.secondary , width: 2.w)
//                                             : Border.all(color: Theme.of(context).colorScheme.secondary , width: 2.w)
//                                             : Border.all(color: Theme.of(context).selectedRowColor)
//
//                                     ),
//                                     child: Text(
//                                         widget.product.prices![index].unitName.toString() ,
//                                         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                             fontWeight: FontWeight.bold,
//                                             fontFamily: "cairo"
//                                         )
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),
//
//                     /// pricing
//                     Padding(
//                       padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
//                       child: CustomTowText(
//                         title: "${allTranslations.text("price")}: ",
//                         titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                             fontWeight: FontWeight.bold,
//                         ),
//                         subWidget: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                                 "${widget.product.prices![selectedPrice].price}",
//                               style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: "cairo"
//                               ),
//                             ),
//                             5.pw,
//                             Center(
//                               child: Text(
//                                 "${widget.product.prices![selectedPrice].currency}",
//                                 style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: "cairo",
//                                     fontSize: 10.sp
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//
//                       ),
//                     ),
//
//
//
//
//                   ],
//                 ),
//               )
//               : 0.ph,
//
//
//
//               3.ph,
//
//
//               /// free adds
//
//                ProductDetailsFreeAdds(product: widget.product),
//
//
//
//
//
//               3.ph,
//
//              /// tabs
//               widget.product.overview == "" &&  widget.product.specification == ""
//                 ? 0.ph
//                 : ProductDetailsTab(
//                productOverview: widget.product.overview.toString(),
//                productSpecification: widget.product.specification.toString(),
//              ),
//
//               5.ph,
//
//               /// user rating
//                ProductDetailsRating(
//                 overAllAssessment: double.parse(widget.product.overallAssessment.toString()).round().toString(),
//                 numberResident: double.parse(widget.product.numberResidents.toString()).round().toString(),
//                 productId: widget.product.id.toString(),
//               )
//               ,
//
//               /// end of users ratings
//
//               5.ph,
//
//               /// similarProducts
//               SimilarProduct(
//                 productId: widget.product.id.toString(),
//               ),
//
//             ],
//           ),
//           bottomNavigationBar: ContinuePurchasingButton(
//             childPurchasing:  Padding(
//               padding:  EdgeInsets.only(top:  10.0.h , bottom:  10.0.h , left: 20.w , right: 20.w),
//               child: Row(
//                 mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                       allTranslations.text("addToCart"),
//                       style: Theme.of(context).textTheme.headline1!.copyWith(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16
//                       )
//                   ),
//
//
//                   widget.product.prices!.isNotEmpty
//                       ? Container(
//                      width: 30.w,
//                      height: 30.h,
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                      ),
//                      child: Center(
//                        child: Text(
//                          "${widget.product.prices![selectedPrice].productQuantity}",
//                          textAlign: TextAlign.center,
//                          style: Theme.of(context).textTheme.headline1!.copyWith(
//                              fontWeight: FontWeight.bold,
//                              fontFamily: "cairo"
//                          ),
//                        ),
//                      ),
//                    )
//                       : 0.ph
//
//
//                   // :
//                   // showingCounter == true && cartModel.items.length > 0
//                   // ? Text(
//                   //   cartModel.items[selectedPrice].quantity.toString(),
//                   //   style: Theme.of(context).textTheme.headline1!.copyWith(
//                   //       fontWeight: FontWeight.bold,
//                   //       color: Theme.of(context).colorScheme.secondary,
//                   //       fontFamily: "cairo"
//                   //   ),
//                   // )
//                   // : const Badges(),
//
//                 ],
//               ),
//             ),
//             childShopping: Center(
//               child: Text(
//                   allTranslations.text("continuePurchasing"),
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).textTheme.headline1!.copyWith(
//                       fontWeight: FontWeight.bold,
//                   )
//               ),
//             ),
//
//
//
//             /// add to cart button
//             onTapPurchasing: () async{
//               if(kDebugMode){
//                 print("***** product id ${widget.product.id}");
//               }
//               if(widget.product.status == false) {
//                 CustomToast.showFlutterToast(
//                   context: context,
//                   message: allTranslations.text("notAvailable"),
//                   toastLength: Toast.LENGTH_LONG,
//                   toastGravity: ToastGravity.SNACKBAR,
//                 );
//               } else {
//                 try{
//
//                   await productDetailsProvider.addToCart(
//                       context,
//                       widget.product.prices![selectedPrice],
//                       widget.product,
//                       freeAdd.toString(),
//                       // widget.product.id.toString()
//                   );
//
//                   setState(() {
//                     widget.product.prices?[selectedPrice].productQuantity = quantity;
//                     quantity += 1;
//                   });
//
//                   facebookAppEvents.logAddToCart(
//                     id: widget.product.id.toString(),
//                     type: 'product',
//                     price: double.parse(widget.product.prices![selectedPrice].price.toString()),
//                     currency: "TRY",
//                   );
//
//
//                   /// add new cart
//                   // if(cartID == "" && newCartModel.items.isEmpty){
//                   //   await newCartModel.addNewCart();
//                   //   cartID = newCartModel.cartId;
//                   //
//                   //    await newCartModel.addToCart(
//                   //       priceId: widget.product.prices![selectedPrice].id.toString(),
//                   //       quantity: "1",
//                   //       type: "product",
//                   //       cartId: cartID.toString(),
//                   //       name: "${widget.product.prices![selectedPrice].productName!}  "
//                   //           "${widget.product.prices![selectedPrice].unitName!} "
//                   //           "${widget.product.prices![selectedPrice].note!}",
//                   //       branchId: widget.product.branch!.id.toString(),
//                   //       image: widget.product.image.toString(),
//                   //       addAr:  freeAdd == "" ? allTranslations.text("noAdds") : freeAdd.toString(),
//                   //   );
//                   //
//                   // }
//                   //
//                   //
//                   // else {
//                   //   if (kDebugMode) {
//                   //     print("you already have a cart");
//                   //     print("add ar $freeAdd");
//                   //   }
//                   //   await newCartModel.addToCart(
//                   //     priceId: widget.product.prices![selectedPrice].id.toString(),
//                   //     quantity: "1",
//                   //     type: "product",
//                   //     cartId: cartID.toString(),
//                   //     name: "${widget.product.prices![selectedPrice].productName!}  "
//                   //         "${widget.product.prices![selectedPrice].unitName!} "
//                   //         "${widget.product.prices![selectedPrice].note!}",
//                   //     branchId: widget.product.branch!.id.toString(),
//                   //     image: widget.product.image.toString(),
//                   //     addAr: freeAdd == "" ? allTranslations.text("noAdds") : freeAdd.toString(),
//                   //   );
//                   //   cartID = newCartModel.cartId;
//                   //
//                   //   setState(() {
//                   //     widget.product.prices?[selectedPrice].productQuantity = quantity;
//                   //     quantity += 1;
//                   //   });
//                   //
//                   //   facebookAppEvents.logAddToCart(
//                   //     id: widget.product.id.toString(),
//                   //     type: 'product',
//                   //     price: double.parse(widget.product.prices![selectedPrice].price.toString()),
//                   //     currency: "TRY",
//                   //   );
//                   //   // if(newCartModel.items.length > 0){
//                   //   //   for(int i = 0 ; i < newCartModel.items.length; i++){
//                   //   //     if(newCartModel.items[i].priceId == widget.product.prices![selectedPrice].id.toString()) {
//                   //   //       cartQuantity = double.parse(newCartModel.items[i].quantity).round().toString();
//                   //   //       int quantity = int.parse(cartQuantity!);
//                   //   //       quantity++;
//                   //   //       cartQuantity = quantity.toString();
//                   //   //       await newCartModel.increaseQuantity(newCartModel.items[i], newCartModel.items[i].type, cartQuantity.toString() , newCartModel.items[i].cartDetailsId);
//                   //   //
//                   //   //     }else {
//                   //   //       await newCartModel.addToCart(
//                   //   //         priceId: widget.product.prices![selectedPrice].id.toString(),
//                   //   //         quantity: "1",
//                   //   //         type: "product",
//                   //   //         cartId: cartID.toString(),
//                   //   //         name: "${widget.product.prices![selectedPrice].productName!}  "
//                   //   //             "${widget.product.prices![selectedPrice].unitName!} "
//                   //   //             "${widget.product.prices![selectedPrice].note!}",
//                   //   //         branchId: widget.product.branch!.id.toString(),
//                   //   //         image: widget.product.image.toString(),
//                   //   //         addAr: freeAdd == "" ? allTranslations.text("noAdds") : freeAdd.toString(),
//                   //   //       );
//                   //   //       cartID = newCartModel.cartId;
//                   //   //
//                   //   //       facebookAppEvents.logAddToCart(
//                   //   //         id: widget.product.id.toString(),
//                   //   //         type: 'product',
//                   //   //         price: double.parse(widget.product.prices![selectedPrice].price.toString()),
//                   //   //         currency: "TRY",
//                   //   //       );
//                   //   //     }
//                   //   //   }
//                   //   // }
//                   //
//                   //
//                   //
//                   // }
//
//                   /// end of new cart ///////////////////////////////////////////////////////
//
//                   if (kDebugMode) {
//                     print("adding to cart successfully");
//                   }
//
//                 }catch (error){
//                   if (kDebugMode) {
//                     print("error adding to cart $error");
//                   }
//                 }
//               }
//
//
//
//
//             },
//
//
//
//             /// continue shopping button
//             onTapShopping: (){
//               cartModel.nCount == 0
//               ? CustomToast.showFlutterToast(
//                 context: context,
//                 message: allTranslations.text("selectOneProduct"),
//                 toastLength: Toast.LENGTH_LONG,
//                 toastGravity: ToastGravity.SNACKBAR,
//               )
//                : pushScreen(context , const CartTab(isFromProductDetails: true));
//
//               // Navigator.push(
//               //     context,
//               //     MaterialPageRoute(builder: (context) =>   CartScreen(
//               //       // cartId: cartID.toString(),
//               //       isFromProductDetails: true,
//               //     ))
//               // );
//             },
//           )
//         ),
//       ),
//     );
//   }
// }
//
//
//
//

import 'package:alalamia_spices/app/core/values/app_colors.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/product_details/providers/product_details_provider.dart';
import 'package:alalamia_spices/app/module/product_details/widget/index.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../data/model/new_arrival.dart';
import '../cart/cart_tab.dart';

// String?  freeAdd;
// List<String> freeAdd = [];
String cartID = "";

class ProductDetailsScreen extends StatefulWidget {
  final bool isFull;
  final Product product;
  const ProductDetailsScreen({
    super.key,
    required this.product,
    this.isFull = true,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String productQuantity = "0";
  // static final facebookAppEvents = FacebookAppEvents();
  List<String> selectedAdds = [];
  List<String> selectedPaidAdds = [];
  List<String> addSizeList = [];
  List<String> addPaidList = [];
  // bool isPaid = false;
  String? extractedString;
  int _selectedIndex = 0;

  getFreeAdds() {
    addSizeList = [];

    if (widget.product.addSize != null) {
      for (int i = 0; i < widget.product.addSize!.length; i++) {
        addSizeList.add(allTranslations.currentLanguage == "ar"
            ? "${widget.product.addSize![i].typeAr} / ${widget.product.addSize![i].addAr}"
            : "${widget.product.addSize![i].typeEn} / ${widget.product.addSize![i].addEn}");
      }
    }

    // if(widget.product.prices != null){
    //   for(int i =0; i < widget.product.prices!.length; i ++){
    //     if(widget.product.prices![i].paidAdds == "true"){
    //       addPaidList.add("${widget.product.prices![i].unitName} ${widget.product.prices![i].price}");
    //     }
    //   }
    // }
  }

  @override
  void initState() {
    super.initState();
    getFreeAdds();
  }

  @override
  Widget build(BuildContext context) {
    ProductDetailsProvider productDetailsProvider = ProductDetailsProvider();
    var productStatusModel = Provider.of<ProductStatusModel>(context);
    var pricesList = widget.product.prices!
        .where((element) =>
            element.paidAdds == "false" || element.paidAdds == null)
        .toList();
    var paidAddsList = widget.product.prices!
        .where((element) => element.paidAdds == "true")
        .toList();

    productStatusModel.getProductStatus(
        productId: widget.product.id.toString());

    return DefaultTabController(
        length: 2,
        child: Consumer<CartModel>(
          builder: (context, cartModel, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              cartModel.showPaidAdds = false;
              cartModel.showFreeAdds = true;
              if (cartModel.items.isNotEmpty) {
                productQuantity = "0";
                for (int i = 0; i < cartModel.items.length; i++) {
                  if (widget.product.prices![_selectedIndex].id ==
                      cartModel.items[i].id) {
                    productQuantity = cartModel.items[i].quantity.toString();
                    cartModel.showPaidAdds = true;
                    cartModel.showFreeAdds = false;
                  }
                }
              } else {
                productQuantity = "0";
                cartModel.showPaidAdds = false;
                cartModel.showFreeAdds = true;
              }
            });
            return SafeArea(
              child: Scaffold(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  appBar: widget.isFull
                      ? PreferredSize(
                          preferredSize:
                              Size.fromHeight(AppConstants.appBarHeight.h),
                          child: const CustomAppBar(),
                        )
                      : null,
                  body: ListView(
                    children: [
                      /// header with image swiper
                      if (widget.isFull)
                        ProductDetailsHeader(
                          product: widget.product,
                        ),

                      3.ph,

                      /// price details
                      widget.product.prices!.isNotEmpty
                          ? Container(
                              height: 100.h,
                              padding: EdgeInsets.all(5.w),
                              color: Theme.of(context).primaryColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// units
                                  Flexible(
                                      child: ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: pricesList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedIndex = index;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 70.h,
                                            padding: EdgeInsets.all(5.0.w),
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppConstants
                                                            .defaultBorderRadius
                                                            .w),
                                                border: _selectedIndex == index
                                                    ? Border.all(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                        width: 2.w)
                                                    : Border.all(
                                                        color: Theme.of(context)
                                                            .hintColor)),
                                            child: Text(
                                                pricesList[index]
                                                    .unitName
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: "cairo")),
                                          ),
                                        ),
                                      );
                                    },
                                  )),

                                  /// pricing
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0.w),
                                    child: CustomTowText(
                                      title:
                                          "${allTranslations.text("price")}: ",
                                      titleStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      subWidget: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${pricesList[_selectedIndex].price}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "cairo"),
                                          ),
                                          5.pw,
                                          Center(
                                            child: Text(
                                              "${pricesList[_selectedIndex].currency}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "cairo",
                                                      fontSize: 10.sp),
                                            ),
                                          ),
                                          5.pw,
                                          Text(
                                            allTranslations.text("taxIncluded"),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontFamily: "cairo",
                                                    color: AppColors.accent),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : 0.ph,

                      3.ph,

                      /// free
                      addSizeList.isEmpty || cartModel.showFreeAdds == false
                          ? 0.ph
                          : Container(
                              height: 110.h,
                              color: Theme.of(context).primaryColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10.0.w),
                                    child: CustomTowText(
                                      title: allTranslations.text("freeAdds"),
                                      titleStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      subWidget: Icon(
                                        Icons.arrow_drop_down,
                                        size: 20,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                      ),
                                    ),
                                  ),

                                  /// multi selection

                                  ChipsChoice<String>.multiple(
                                    scrollPhysics:
                                        const BouncingScrollPhysics(),
                                    direction: Axis.horizontal,
                                    choiceStyle: C2ChipStyle(
                                        borderRadius: BorderRadius.circular(
                                            AppConstants.defaultBorderRadius.h),
                                        backgroundColor: Colors.grey[400],
                                        borderColor: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    value: selectedAdds,
                                    onChanged: (val) =>
                                        setState(() => selectedAdds = val),
                                    choiceItems:
                                        C2Choice.listFrom<String, String>(
                                      source: addSizeList,
                                      value: (i, value) => value,
                                      label: (i, v) => v,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                      3.ph,

                      /// paid adds
                      if (cartModel.showPaidAdds == true &&
                          (paidAddsList.isNotEmpty || addSizeList.isNotEmpty))
                        paidAddsList.isNotEmpty
                            ? Container(
                                height: 200.h,
                                padding: EdgeInsets.all(5.w),
                                color: Theme.of(context).primaryColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10.0.w),
                                      child: CustomTowText(
                                        title: allTranslations.text("paidAdds"),
                                        titleStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        subWidget: Icon(
                                          Icons.arrow_drop_down,
                                          size: 20,
                                          color: Theme.of(context)
                                              .secondaryHeaderColor,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: paidAddsList.length,
                                        itemBuilder: (context, innerIndex) {
                                          return Padding(
                                            padding: EdgeInsets.all(8.0.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "${paidAddsList[innerIndex].unitName}:  ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily: "cairo",
                                                            fontSize: 14.sp)),
                                                Text(
                                                  "${paidAddsList[innerIndex].price}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: "cairo",
                                                        fontSize: 14.sp,
                                                      ),
                                                ),
                                                Text(
                                                  "${paidAddsList[innerIndex].currency}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: "cairo",
                                                          fontSize: 10.sp),
                                                ),
                                                const Spacer(),
                                                InkWell(
                                                  onTap: () async {
                                                    await productDetailsProvider
                                                        .addToCart(
                                                            context,
                                                            paidAddsList[
                                                                innerIndex],
                                                            widget.product,
                                                            extractedString
                                                                .toString(),
                                                            true);
                                                    CustomToast.showFlutterToast(
                                                        context: context,
                                                        message: allTranslations
                                                            .text("added"),
                                                        toastGravity:
                                                            ToastGravity
                                                                .CENTER);
                                                  },
                                                  child: Container(
                                                    width: 35.w,
                                                    height: 35.h,
                                                    padding:
                                                        EdgeInsets.all(5.w),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary
                                                          .withOpacity(0.5),
                                                      borderRadius: BorderRadius
                                                          .circular(AppConstants
                                                              .defaultBorderRadius
                                                              .w),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary,
                                                            blurRadius: 2,
                                                            // spreadRadius: 2,
                                                            offset:
                                                                const Offset(
                                                                    0, 1),
                                                            blurStyle: BlurStyle
                                                                .normal),
                                                      ],
                                                    ),
                                                    child: const Icon(
                                                      Icons
                                                          .add_shopping_cart_outlined,
                                                      size: 20,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : 0.ph,
                      3.ph,

                      /// tabs
                      if (widget.product.overview != "" &&
                          widget.product.specification != "")
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.all(10.w),
                          child: CustomTabWidget(
                            overviewContent: widget.product.overview.toString(),
                            specificationsContent:
                                widget.product.specification.toString(),
                          ),
                        ),

                      5.ph,

                      /// user rating
                      if (widget.isFull)
                        ProductDetailsRating(
                          overAllAssessment: double.parse(
                                  widget.product.overallAssessment.toString())
                              .round()
                              .toString(),
                          numberResident: double.parse(
                                  widget.product.numberResidents.toString())
                              .round()
                              .toString(),
                          productId: widget.product.id.toString(),
                        ),

                      /// end of users ratings

                      5.ph,

                      /// similarProducts
                      if (widget.isFull)
                        SimilarProduct(
                          productId: widget.product.id.toString(),
                        ),
                    ],
                  ),
                  bottomNavigationBar: ContinuePurchasingButton(
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: "cairo")),
                          widget.product.prices!.isNotEmpty
                              ? Container(
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
                              : 0.ph
                        ],
                      ),
                    ),
                    childShopping: Center(
                      child: Text(allTranslations.text("continuePurchasing"),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              )),
                    ),

                    /// add to cart button
                    onTapPurchasing: () async {
                      if (productStatusModel.status == false) {
                        CustomToast.showFlutterToast(
                          context: context,
                          message: allTranslations.text("notAvailable"),
                          toastLength: Toast.LENGTH_LONG,
                          toastGravity: ToastGravity.SNACKBAR,
                        );
                      } else {
                        try {
                          String myString = selectedAdds.toString();
                          RegExp regex = RegExp(r'\[(.*?)\]');
                          Iterable<RegExpMatch> matches =
                              regex.allMatches(myString);

                          for (RegExpMatch match in matches) {
                            extractedString = match.group(1);
                          }
                          await productDetailsProvider.addToCart(
                              context,
                              pricesList[_selectedIndex],
                              widget.product,
                              extractedString.toString(),
                              false
                              // selectedPaidAdds.toString(),
                              // paidAddsList[cartModel.selectedPaidAdds].price.toString()
                              // widget.product.id.toString()
                              );

                          // facebookAppEvents.logAddToCart(
                          //   id: widget.product.id.toString(),
                          //   type: 'product',
                          //   price: double.parse(
                          //       pricesList[_selectedIndex].price.toString()),
                          //   currency: "TRY",
                          // );

                          /// add new cart
                          // if(cartID == "" && newCartModel.items.isEmpty){
                          //   await newCartModel.addNewCart();
                          //   cartID = newCartModel.cartId;
                          //
                          //    await newCartModel.addToCart(
                          //       priceId: widget.product.prices![selectedPrice].id.toString(),
                          //       quantity: "1",
                          //       type: "product",
                          //       cartId: cartID.toString(),
                          //       name: "${widget.product.prices![selectedPrice].productName!}  "
                          //           "${widget.product.prices![selectedPrice].unitName!} "
                          //           "${widget.product.prices![selectedPrice].note!}",
                          //       branchId: widget.product.branch!.id.toString(),
                          //       image: widget.product.image.toString(),
                          //       addAr:  freeAdd == "" ? allTranslations.text("noAdds") : freeAdd.toString(),
                          //   );
                          //
                          // }
                          //
                          //
                          // else {
                          //   if (kDebugMode) {
                          //     print("you already have a cart");
                          //     print("add ar $freeAdd");
                          //   }
                          //   await newCartModel.addToCart(
                          //     priceId: widget.product.prices![selectedPrice].id.toString(),
                          //     quantity: "1",
                          //     type: "product",
                          //     cartId: cartID.toString(),
                          //     name: "${widget.product.prices![selectedPrice].productName!}  "
                          //         "${widget.product.prices![selectedPrice].unitName!} "
                          //         "${widget.product.prices![selectedPrice].note!}",
                          //     branchId: widget.product.branch!.id.toString(),
                          //     image: widget.product.image.toString(),
                          //     addAr: freeAdd == "" ? allTranslations.text("noAdds") : freeAdd.toString(),
                          //   );
                          //   cartID = newCartModel.cartId;
                          //
                          //   setState(() {
                          //     widget.product.prices?[selectedPrice].productQuantity = quantity;
                          //     quantity += 1;
                          //   });
                          //
                          //   facebookAppEvents.logAddToCart(
                          //     id: widget.product.id.toString(),
                          //     type: 'product',
                          //     price: double.parse(widget.product.prices![selectedPrice].price.toString()),
                          //     currency: "TRY",
                          //   );
                          //   // if(newCartModel.items.length > 0){
                          //   //   for(int i = 0 ; i < newCartModel.items.length; i++){
                          //   //     if(newCartModel.items[i].priceId == widget.product.prices![selectedPrice].id.toString()) {
                          //   //       cartQuantity = double.parse(newCartModel.items[i].quantity).round().toString();
                          //   //       int quantity = int.parse(cartQuantity!);
                          //   //       quantity++;
                          //   //       cartQuantity = quantity.toString();
                          //   //       await newCartModel.increaseQuantity(newCartModel.items[i], newCartModel.items[i].type, cartQuantity.toString() , newCartModel.items[i].cartDetailsId);
                          //   //
                          //   //     }else {
                          //   //       await newCartModel.addToCart(
                          //   //         priceId: widget.product.prices![selectedPrice].id.toString(),
                          //   //         quantity: "1",
                          //   //         type: "product",
                          //   //         cartId: cartID.toString(),
                          //   //         name: "${widget.product.prices![selectedPrice].productName!}  "
                          //   //             "${widget.product.prices![selectedPrice].unitName!} "
                          //   //             "${widget.product.prices![selectedPrice].note!}",
                          //   //         branchId: widget.product.branch!.id.toString(),
                          //   //         image: widget.product.image.toString(),
                          //   //         addAr: freeAdd == "" ? allTranslations.text("noAdds") : freeAdd.toString(),
                          //   //       );
                          //   //       cartID = newCartModel.cartId;
                          //   //
                          //   //       facebookAppEvents.logAddToCart(
                          //   //         id: widget.product.id.toString(),
                          //   //         type: 'product',
                          //   //         price: double.parse(widget.product.prices![selectedPrice].price.toString()),
                          //   //         currency: "TRY",
                          //   //       );
                          //   //     }
                          //   //   }
                          //   // }
                          //
                          //
                          //
                          // }

                          /// end of new cart ///////////////////////////////////////////////////////

                          debugPrint("adding to cart successfully");
                        } catch (error) {
                          debugPrint("error adding to cart $error");
                        }
                      }
                    },

                    /// continue shopping button
                    onTapShopping: () {
                      cartModel.nCount == 0
                          ? CustomToast.showFlutterToast(
                              context: context,
                              message: allTranslations.text("selectOneProduct"),
                              toastLength: Toast.LENGTH_LONG,
                              toastGravity: ToastGravity.SNACKBAR,
                            )
                          : pushScreen(context,
                              const CartTab(isFromProductDetails: true));

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) =>   CartScreen(
                      //       // cartId: cartID.toString(),
                      //       isFromProductDetails: true,
                      //     ))
                      // );
                    },
                  )),
            );
          },
        ));
  }
}

extension on ThemeData {
  get selectedRowColor => null;
}
