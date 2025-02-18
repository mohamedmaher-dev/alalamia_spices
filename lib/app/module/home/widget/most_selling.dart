import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/global_widgets/custom_product_card.dart';
import 'package:alalamia_spices/app/global_widgets/custom_rotated_box.dart';
import 'package:alalamia_spices/app/global_widgets/product_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import '../../../core/values/app_lottie.dart';
import '../../../data/model/new_arrival.dart';
import '../../../global_widgets/circular_loading.dart';
import '../../../global_widgets/custom_message.dart';
import '../../../services/screen_navigation_service.dart';
import '../../product_details/product_details_screen.dart';

class MostSelling extends StatefulWidget {
  const MostSelling({super.key});

  @override
  State<MostSelling> createState() => _MostSellingState();
}

class _MostSellingState extends State<MostSelling> {
  // static final facebookAppEvents = FacebookAppEvents();
  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<FavoriteModel>(context, listen: false);
    final mostSellingModel = Provider.of<MostSellingModel>(context);
    final productStatusModel = Provider.of<ProductStatusModel>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 370.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 365.h,
              width: 30.w,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(AppConstants.defaultBorderRadius.w),
                      bottomLeft:
                          Radius.circular(AppConstants.defaultBorderRadius.w))),
              child: CustomRotatedBox(
                text: allTranslations.text("mostSelling"),
              )),

          // Expanded(
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     primary: false,
          //     scrollDirection: Axis.horizontal,
          //     itemCount: mostSellingModel.items.length,
          //     itemBuilder: (context , index){
          //       productStatusModel.getProductStatus(productId: product.id.toString());
          //       return CustomProductCard(
          //         onTap: () {
          //           pushScreen(context, ProductDetailsScreen(
          //             product: product,
          //           ),);
          //
          //           facebookAppEvents.logAddToWishlist(
          //               id: product.id.toString(),
          //               type: 'product most selling',
          //               currency: "RY",
          //               price: double.parse(product.firstPrice.toString())
          //           );
          //         },
          //         image: product.image640,
          //         name: product.name,
          //         firstPrice: product.firstPrice.toString(),
          //         currency: product.prices.length > 0
          //             ? product.prices[0].currency.toString()
          //             : "",
          //         oldPrice: product.prices.length > 0
          //             && product.prices[0].oldPrice != ""
          //             ? product.prices[0].oldPrice.toString()
          //             : "",
          //         discount: product.prices.length > 0 &&
          //             product.prices[0].oldPrice != ""
          //             ? product.discount.toString()
          //             : '',
          //         numberResidents: product.numberResidents.toString(),
          //         overallAssessment: product.overallAssessment.toString(),
          //         isNewProduct: false,
          //         isMostSellingProduct: true,
          //         status: productStatusModel.status,
          //           onTapFavorite: (bool isLiked) {
          //             setState(() {
          //               if (product.favorite) {
          //                 mostSellingModel
          //                     .items[index].favorite = false;
          //
          //                 favorite.deleteFromFavorite(
          //                     mostSellingModel
          //                         .items[index].id);
          //               } else {
          //                 mostSellingModel
          //                     .items[index].favorite = true;
          //
          //                 favorite.addToFavorite(
          //                     mostSellingModel
          //                         .items[index].id);
          //               }
          //             });
          //
          //             return Future.value(!isLiked);
          //           },
          //           favoriteIcon: product.favorite == true
          //               ? Icons.favorite
          //               : Icons.favorite_border,
          //           favoriteIconColor: product.favorite == true
          //               ? Colors.redAccent[400]!
          //               : Colors.grey
          //       );
          //     },
          //   ),
          // ),

          Expanded(
              child: PagedListView(
            scrollDirection: Axis.horizontal,
            pagingController: mostSellingModel.pagingController,
            builderDelegate: PagedChildBuilderDelegate<Product>(
              itemBuilder: (context, product, index) {
                productStatusModel.getProductStatus(
                    productId: product.id.toString());
                return CustomProductCard(
                    index: index,
                    product: product,
                    onTap: () {
                      pushScreen(
                        context,
                        ProductDetailsScreen(
                          product: product,
                        ),
                      );

                      // facebookAppEvents.logAddToWishlist(
                      //     id: product.id.toString(),
                      //     type: 'product most selling',
                      //     currency: "RY",
                      //     price: double.parse(product.firstPrice.toString()));
                    },
                    image: product.image640.toString(),
                    name: product.name.toString(),
                    firstPrice: product.firstPrice.toString(),
                    currency: product.prices!.isNotEmpty
                        ? product.prices![0].currency.toString()
                        : "",
                    oldPrice: product.prices!.isNotEmpty &&
                            product.prices![0].oldPrice != ""
                        ? product.prices![0].oldPrice.toString()
                        : "",
                    discount: product.prices!.isNotEmpty &&
                            product.prices![0].oldPrice != ""
                        ? product.discount.toString()
                        : '',
                    numberResidents: product.numberResidents.toString(),
                    overallAssessment: product.overallAssessment.toString(),
                    isNewProduct: false,
                    isMostSellingProduct: true,
                    status: productStatusModel.status,
                    onTapFavorite: (bool isLiked) {
                      setState(() {
                        if (product.favorite == true) {
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
              firstPageProgressIndicatorBuilder: (context) =>
                  const ProductShimmer(),
              firstPageErrorIndicatorBuilder: (context) => Center(
                  child: Text(allTranslations.text("networkConnection"))),
              newPageProgressIndicatorBuilder: (context) =>
                  const Center(child: CircularLoading()),
              noMoreItemsIndicatorBuilder: (context) => const Text(""),
              noItemsFoundIndicatorBuilder: (context) => Center(
                  child: CustomMessage(
                      message: allTranslations.text("noData"),
                      appLottieIcon: AppLottie.noData)),
            ),
          )),
        ],
      ),
    );
  }
}
