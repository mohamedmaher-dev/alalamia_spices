// import 'package:alalamia_spices/app/data/providers/product/favorite_model.dart';
// import 'package:alalamia_spices/app/data/providers/product/most_selling_model.dart';
// import 'package:alalamia_spices/app/data/providers/product/new_arrival_model.dart';
// import 'package:alalamia_spices/app/data/providers/translations.dart';
// import 'package:facebook_app_events/facebook_app_events.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../../core/utils/constants.dart';
// import '../../../core/values/app_lottie.dart';
// import '../../../data/providers/product/product_status_model.dart';
// import '../../../global_widgets/custom_app_bar.dart';
// import '../../../global_widgets/custom_message.dart';
// import '../../../global_widgets/custom_product_card.dart';
// import '../../../services/screen_navigation_service.dart';
// import '../../product_details/product_details_screen.dart';
//
//
// class ShowAllProducts extends StatefulWidget {
//   final bool newArrivalProduct;
//   final bool mostSellingProduct;
//   final bool relatedProduct;
//   const ShowAllProducts({
//     super.key,
//      this.newArrivalProduct = false,
//      this.mostSellingProduct = false,
//      this.relatedProduct  = false
//   });
//
//   @override
//   State<ShowAllProducts> createState() => _ShowAllProductsState();
// }
//
// class _ShowAllProductsState extends State<ShowAllProducts> {
//   static final facebookAppEvents = FacebookAppEvents();
//   @override
//   Widget build(BuildContext context) {
//     final newArrivalModel = Provider.of<NewArrivalModel>(context);
//     final mostSellingModel = Provider.of<MostSellingModel>(context);
//     final favoriteModel = Provider.of<FavoriteModel>(context , listen: false);
//     final productStatusModel = Provider.of<ProductStatusModel>(context);
//     final bool itemsEmpty = widget.newArrivalProduct == true ? newArrivalModel.items.isEmpty : mostSellingModel.items.isEmpty;
//     final int itemsCount = widget.newArrivalProduct == true
//         ? newArrivalModel.items.length
//         : mostSellingModel.items.length;
//
//
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Theme.of(context).backgroundColor,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
//           child: const CustomAppBar(),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             Padding(
//               padding:  EdgeInsets.all(10.0.w),
//               child: Text(
//                   widget.newArrivalProduct == true ? allTranslations.text("ourNew") : allTranslations.text("mostSelling"),
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                   fontWeight: FontWeight.bold
//                 ),
//               ),
//             ),
//
//             Flexible(
//               child: itemsEmpty
//                   ? Center(
//                 child: CustomMessage(
//                     message: allTranslations.text("noData"),
//                     appLottieIcon: AppLottie.noData
//                 ),
//               )
//
//                   : GridView.builder(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.vertical,
//                 gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
//                   maxCrossAxisExtent: 300.w,
//                   mainAxisExtent: AppConstants.mainAxisExtentProduct.h,
//                 ),
//                 itemCount: itemsCount,
//                 itemBuilder: (context , index){
//                   final int itemsLength = widget.newArrivalProduct == true
//                       ? newArrivalModel.items.length : mostSellingModel.items.length;
//                   if (index == itemsLength) {
//                     // Show a loading indicator at the end of the list
//                     return const Center(
//                       child: Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: CircularProgressIndicator(),
//                       ),
//                     );
//                   }
//                   final String productId = widget.newArrivalProduct == true
//                       ? newArrivalModel.items[index].id : mostSellingModel.items[index].id;
//                   productStatusModel.getProductStatus(productId: productId);
//                   final product = widget.newArrivalProduct == true ? newArrivalModel.items[index] : mostSellingModel.items[index];
//                   return CustomProductCard(
//                       onTap: () {
//                         pushScreen(context, ProductDetailsScreen(
//                           product: product,
//                         ),);
//
//                         facebookAppEvents.logAddToWishlist(
//                             id: product.id.toString(),
//                             type: 'from category ${product.id.toString()}',
//                             currency: "RY",
//                             price: double.parse(product.firstPrice.toString())
//                         );
//                       },
//                       name: product.name,
//                       firstPrice: product.firstPrice.toString(),
//                       image: product.image640.toString(),
//                       currency: product.prices.length > 0
//                           ? product.prices[0].currency.toString()
//                           : "",
//                       oldPrice: product.prices.length > 0
//                           && product.prices[0].oldPrice != ""
//                           ? product.prices[0].oldPrice.toString()
//                           : "",
//                       discount: product.prices.length > 0 &&
//                           product.prices[0].oldPrice != ""
//                           ? product.discount.toString()
//                           : '',
//                       numberResidents: product.numberResidents.toString(),
//                       overallAssessment: product.overallAssessment.toString(),
//                       isNewProduct: product.isNewProduct,
//                       isMostSellingProduct: product.mostSell,
//                       status: productStatusModel.status,
//                       onTapFavorite: (bool isLiked) {
//                         setState(() {
//                           if (product.favorite) {
//                             product.favorite = false;
//
//                             favoriteModel.deleteFromFavorite(product.id);
//                           } else {
//                             product.favorite = true;
//
//                             favoriteModel.addToFavorite(product.id);
//                           }
//                         });
//
//                         return Future.value(!isLiked);
//                       },
//                       favoriteIcon: product.favorite == true
//                           ? Icons.favorite
//                           : Icons.favorite_border,
//                       favoriteIconColor: product.favorite == true
//                           ? Colors.redAccent[400]!
//                           : Colors.grey
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
