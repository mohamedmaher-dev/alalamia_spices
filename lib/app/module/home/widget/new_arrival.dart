import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/product_details/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import '../../../core/values/app_lottie.dart';
import '../../../data/model/new_arrival.dart';
import '../../../services/screen_navigation_service.dart';

class NewArrival extends StatefulWidget {
  const NewArrival({super.key});

  @override
  State<NewArrival> createState() => _NewArrivalState();
}

class _NewArrivalState extends State<NewArrival> {
  // static final facebookAppEvents = FacebookAppEvents();

  // final ScrollController _scrollController = ScrollController();
  // bool _showButton = false;
  // @override
  // void initState() {
  //   super.initState();
  //
  //   // Listen to scroll events
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
  //       // User has reached the end of the list
  //       setState(() {
  //         _showButton = true; // Show the button
  //       });
  //     }
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<FavoriteModel>(context, listen: false);
    final newArrivalModel = Provider.of<NewArrivalModel>(context);
    final productStatusModel = Provider.of<ProductStatusModel>(context);
    return SizedBox(
      height: 370.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// RotatedBox
          Container(
              height: 370.h,
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              width: 30.w,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(AppConstants.defaultBorderRadius.w),
                      bottomLeft:
                          Radius.circular(AppConstants.defaultBorderRadius.w))),
              child: CustomRotatedBox(
                text: allTranslations.text("ourNew"),
              )),

          // Expanded(
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     primary: false,
          //     scrollDirection: Axis.horizontal,
          //     itemCount: newArrivalModel.items.length,
          //     itemBuilder: (context , index){
          //       productStatusModel.getProductStatus(productId: product.id.toString());
          //       return CustomProductCard(
          //           onTap: () {
          //
          //             pushScreen(context, ProductDetailsScreen(
          //               product: product,
          //             ),);
          //
          //
          //             facebookAppEvents.logAddToWishlist(
          //                 id: product.id.toString(),
          //                 type: 'product new arrival',
          //                 currency: "RY",
          //                 price: double.parse(product.firstPrice.toString())
          //             );
          //           },
          //           name: product.name,
          //           firstPrice: product.firstPrice.toString(),
          //           image: product.image640.toString(),
          //           currency: product.prices.length > 0
          //               ? product.prices[0].currency.toString()
          //               : "",
          //           oldPrice: product.prices.length > 0
          //               && product.prices[0].oldPrice != ""
          //               ? product.prices[0].oldPrice.toString()
          //               : "",
          //           discount: product.prices.length > 0 &&
          //               product.prices[0].oldPrice != ""
          //               ? product.discount.toString()
          //               : '',
          //           numberResidents: product.numberResidents.toString(),
          //           overallAssessment: product.overallAssessment.toString(),
          //           isNewProduct: true,
          //           isMostSellingProduct: false,
          //           status: productStatusModel.status,
          //           onTapFavorite: (bool isLiked) {
          //             setState(() {
          //               if (product.favorite) {
          //                 product.favorite = false;
          //
          //                 favorite.deleteFromFavorite(
          //                     newArrivalModel
          //                         .items[index].id);
          //               } else {
          //                 newArrivalModel
          //                     .items[index].favorite = true;
          //
          //                 favorite.addToFavorite(
          //                     newArrivalModel
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
            // scrollController: _scrollController,
            scrollDirection: Axis.horizontal,
            pagingController: newArrivalModel.pagingController,
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
                      //     type: 'product new arrival',
                      //     currency: "RY",
                      //     price: double.parse(product.firstPrice.toString()));
                    },
                    name: product.name.toString(),
                    firstPrice: product.firstPrice.toString(),
                    image: product.image640.toString(),
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
                    isNewProduct: true,
                    isMostSellingProduct: false,
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
