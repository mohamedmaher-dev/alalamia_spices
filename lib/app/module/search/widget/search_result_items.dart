import 'package:flutter/material.dart';
//import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../../data/model/new_arrival.dart';
import '../../../global_widgets/custom_product_card.dart';
import '../../../services/screen_navigation_service.dart';
import '../../product_details/product_details_screen.dart';
import 'package:alalamia_spices/app/exports/provider.dart';

class SearchResultItems extends StatelessWidget {
  final Product product;

  SearchResultItems({super.key, required this.product, required this.index});

  // static final facebookAppEvents = FacebookAppEvents();
  bool productStatus = true;
  final int index;

  @override
  Widget build(BuildContext context) {
    var favorite = Provider.of<FavoriteModel>(context, listen: false);
    var productStatusModel = Provider.of<ProductStatusModel>(context);
    if (productStatusModel.items.isNotEmpty) {
      for (int i = 0; i < productStatusModel.items.length; i++) {
        if (product.id == productStatusModel.items[i].productId) {
          productStatus =
              productStatusModel.items[i].status == 1 ? true : false;
        }
      }
    }
    return StatefulBuilder(
      builder: (context, mySetState) {
        return CustomProductCard(
            product: product,
            index: index,
            onTap: () {
              pushScreen(
                context,
                ProductDetailsScreen(
                  product: product,
                ),
              );

              // facebookAppEvents.logAddToWishlist(
              //     id: product.id.toString(),
              //     type: 'searched product',
              //     currency: "RY",
              //     price: double.parse(product.firstPrice.toString()));
            },
            name: product.name.toString(),
            firstPrice: product.firstPrice.toString(),
            image: product.image640.toString(),
            currency: product.prices!.isNotEmpty
                ? product.prices![0].currency.toString()
                : "",
            oldPrice:
                product.prices!.isNotEmpty && product.prices![0].oldPrice != ""
                    ? product.prices![0].oldPrice.toString()
                    : "",
            discount:
                product.prices!.isNotEmpty && product.prices![0].oldPrice != ""
                    ? product.discount.toString()
                    : '',
            numberResidents: product.numberResidents.toString(),
            overallAssessment: product.overallAssessment.toString(),
            isNewProduct: product.isNewProduct!,
            isMostSellingProduct: product.mostSell!,
            status: productStatus,
            onTapFavorite: (bool isLiked) {
              mySetState(() {
                if (product.favorite!) {
                  product.favorite = false;

                  favorite.deleteFromFavorite(product.id.toString());
                } else {
                  product.favorite = true;

                  favorite.addToFavorite(product.id.toString());
                }
              });

              return Future.value(!isLiked);
            },
            favoriteIcon: product.favorite == true
                ? Icons.favorite
                : Icons.favorite_border,
            favoriteIconColor: product.favorite == true
                ? Colors.redAccent[400]!
                : Colors.grey);
      },
    );

    //   InkWell(
    //   onTap: (){
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) =>
    //                 ProductDetailsScreen(
    //                  product: product,
    //                 )));
    //   },
    //   child: Padding(
    //     padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
    //     child: Container(
    //       height: 365.h,
    //       width: 150.w,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
    //         color: Theme.of(context).primaryColor, // white color
    //       ),
    //       child: Stack(
    //         children: [
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Padding(
    //                 padding:  EdgeInsets.only(top: 25.h , bottom: 5.h , left : 10.w , right: 10.w),
    //                 child: ClipRRect(
    //                   borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
    //                   child: SizedBox(
    //                     height: 200.h,
    //                     width: 150.w,
    //                     child: CustomCachedNetworkImage(
    //                       fit: BoxFit.fill,
    //                       imageUrl: product.image360.toString(),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 width: 150.w,
    //                 height: 90.h,
    //                 padding: const EdgeInsets.only(left: 5 , right: 5),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                         product.name.toString(),
    //                         maxLines: 3,
    //                         overflow: TextOverflow.ellipsis,
    //                         softWrap: false,
    //                         style: Theme.of(context).textTheme.bodyMedium!
    //                     ),
    //
    //                     10.ph,
    //                     Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                             "${product.firstPrice} " ,
    //                             style: Theme.of(context).textTheme.titleSmall!.copyWith(
    //                                 fontWeight: FontWeight.bold,
    //                                 fontFamily: "cairo"
    //                             )
    //                         ),
    //                         5.pw,
    //                         Text(
    //                             product.prices!.length > 0
    //                                 ? product.prices![0].currency.toString()
    //                                 : "",
    //                             style: Theme.of(context).textTheme.titleSmall!.copyWith(
    //                                 fontWeight: FontWeight.bold,
    //                                 fontFamily: "cairo"
    //                             )
    //                         ),
    //                       ],
    //                     ),
    //                     10.ph,
    //
    //                     product.prices!.length > 0
    //                         ? product.prices![0].oldPrice != ""
    //                         ? Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       children:  [
    //                         Text(
    //                             "${product.prices![0].oldPrice} ${product.prices![0].currency}",
    //                             style: Theme.of(context).textTheme.overline!.copyWith(
    //                                 fontWeight: FontWeight.bold,
    //                                 fontFamily: "cairo"
    //                             )
    //                         ),
    //                         5.pw,
    //                         Text(
    //                             "${allTranslations.text("discountPercentage")}  ${product.discount}",
    //                             style: Theme.of(context).textTheme.caption!.copyWith(
    //                                 color: Colors.green,
    //                                 fontFamily: "cairo"
    //                             )
    //                         ),
    //                       ],
    //                     )
    //                         : const SizedBox.shrink()
    //                         : const SizedBox.shrink(),
    //                     5.ph,
    //
    //
    //                   ],
    //                 ),
    //               ),
    //               /// Availability
    //               Padding(
    //                 padding: const EdgeInsets.only(left: 5 , right: 5 , top: 10 , bottom: 5),
    //                 child: Row(
    //                   mainAxisAlignment: product.status == true
    //                       ? MainAxisAlignment.center
    //                       : MainAxisAlignment.spaceBetween,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     product.status == true
    //                         ? const SizedBox.shrink()
    //                         : Container(
    //                       height: 20.h,
    //                       width: 80.w,
    //                       // padding: const EdgeInsets.all(3.0),
    //                       decoration:  BoxDecoration(
    //                         borderRadius: const BorderRadius.only(
    //                             topRight: Radius.circular(25),
    //                             bottomRight: Radius.circular(25),
    //                             bottomLeft: Radius.circular(32)
    //                         ),
    //                         color: Theme.of(context).secondaryHeaderColor , // black color
    //                       ),
    //                       child:  Center(
    //                         child: Text(
    //                             allTranslations.text("productNotAvailable"),
    //                             maxLines: 1,
    //                             overflow: TextOverflow.ellipsis,
    //                             style: Theme.of(context).textTheme.bodyMedium!!.copyWith(
    //                                 color: Theme.of(context).primaryColor,
    //                                 fontSize: 10.sp
    //                             )
    //                         ),
    //                       ),
    //                     ),
    //
    //
    //
    //
    //                     Padding(
    //                       padding: const EdgeInsets.symmetric(horizontal: 7),
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: [
    //                           Icon(
    //                             Icons.star ,
    //                             color: Theme.of(context).colorScheme.secondary,
    //                             size: 12,
    //                           ),
    //                           3.pw,
    //                           Text(
    //                             double.parse(product.overallAssessment.toString()).round().toString(),
    //                             style: Theme.of(context).textTheme.overline!.copyWith(
    //                                 color: Theme.of(context).secondaryHeaderColor,
    //                                 decoration: TextDecoration.none,
    //                                 fontFamily: "cairo"
    //                             ),
    //                           ),
    //                           2.pw,
    //                           Container(
    //                             height: 10.h,
    //                             width: 2.w,
    //                             color: Theme.of(context).primaryColorLight,
    //                           ),
    //                           2.pw,
    //                           Text(
    //                             double.parse(product.numberResidents.toString()).round().toString(),
    //                             style: Theme.of(context).textTheme.overline!.copyWith(
    //                                 color: Theme.of(context).secondaryHeaderColor,
    //                                 decoration: TextDecoration.none,
    //                                 fontFamily: "cairo"
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     )
    //
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //
    //
    //
    //
    //           appModel.token == "visitor"
    //           ? 0.ph
    //           : Positioned(
    //             top: 3,
    //             left: 5,
    //             right: 5,
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 const SizedBox.shrink(),
    //
    //                 StatefulBuilder(
    //                   builder: (context , mySetState){
    //                     return  LikeButton(
    //                       size: 20,
    //                       circleColor: CircleColor(
    //                           start: Colors.redAccent[400]!,
    //                           end: Colors.redAccent[400]!),
    //                       bubblesColor: BubblesColor(
    //                         dotPrimaryColor: Colors.redAccent[400]!,
    //                         dotSecondaryColor: Colors.redAccent[400]!,
    //                       ),
    //                       likeBuilder: (bool isLiked) {
    //                         return const Padding(
    //                           padding:  EdgeInsets.only(left: 2 , right: 2 , top: 1 , bottom: 1),
    //                           child: Icon(
    //                             Icons.favorite_border,
    //                             color: Colors.grey,
    //                             size: 20,
    //                           ),
    //                         );
    //                       },
    //                       onTap: (bool isLiked) {
    //                         // mySetState(() {
    //                         //   if (mostPopularProductModel
    //                         //       .items[index].favorite) {
    //                         //     mostPopularProductModel
    //                         //         .items[index].favorite = false;
    //                         //
    //                         //     favorite.deleteFromFavorite(
    //                         //         mostPopularProductModel
    //                         //             .items[index].id);
    //                         //   } else {
    //                         //     mostPopularProductModel
    //                         //         .items[index].favorite = true;
    //                         //
    //                         //     favorite.addToFavorite(
    //                         //         mostPopularProductModel
    //                         //             .items[index].id);
    //                         //   }
    //                         // });
    //
    //                         return Future.value(!isLiked);
    //                       },
    //                     );
    //                   },
    //                 ),
    //               ],
    //             ),
    //           ),
    //
    //
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
