import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
//import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../../data/model/new_arrival.dart';
import '../../../services/screen_navigation_service.dart';
import '../product_details_screen.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';

class SimilarProduct extends StatelessWidget {
  final String productId;
  const SimilarProduct({super.key, required this.productId});
  // static final facebookAppEvents = FacebookAppEvents();
  @override
  Widget build(BuildContext context) {
    var favorite = Provider.of<FavoriteModel>(context, listen: false);
    var productStatusModel = Provider.of<ProductStatusModel>(context);
    return ChangeNotifierProvider(
      create: (context) => RelatedProductModel(context, productId),
      child: Consumer<RelatedProductModel>(
        builder: (context, model, child) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 405.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                  child: Text(
                    allTranslations.text("similarProducts"),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),

                // Flexible(
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     primary: false,
                //     scrollDirection: Axis.horizontal,
                //     itemCount: model.items.length,
                //     itemBuilder: (context , index){
                //       return StatefulBuilder(
                //         builder: (context , mySetState){
                //           productStatusModel.getProductStatus(productId: productId);
                //           return CustomProductCard(
                //               onTap: () {
                //                 pushScreen(context, ProductDetailsScreen(
                //                   product: model.items[index],
                //                 ),);
                //
                //                 facebookAppEvents.logAddToWishlist(
                //                     id: model.items[index].id.toString(),
                //                     type: 'similar product',
                //                     currency: "RY",
                //                     price: double.parse(model.items[index].firstPrice.toString())
                //                 );
                //               },
                //               name: model.items[index].name,
                //               firstPrice: model.items[index].firstPrice.toString(),
                //               image: model.items[index].image640.toString(),
                //               currency: model.items[index].prices.length > 0
                //                   ? model.items[index].prices[0].currency.toString()
                //                   : "",
                //               oldPrice: model.items[index].prices.length > 0
                //                   && model.items[index].prices[0].oldPrice != ""
                //                   ? model.items[index].prices[0].oldPrice.toString()
                //                   : "",
                //               discount: model.items[index].prices.length > 0 &&
                //                   model.items[index].prices[0].oldPrice != ""
                //                   ? model.items[index].discount.toString()
                //                   : '',
                //               numberResidents: model.items[index].numberResidents.toString(),
                //               overallAssessment: model.items[index].overallAssessment.toString(),
                //               isNewProduct: model.items[index].isNewProduct,
                //               isMostSellingProduct: model.items[index].mostSell,
                //               status: productStatusModel.status,
                //               onTapFavorite: (bool isLiked) {
                //                 mySetState(() {
                //                   if (model.items[index].favorite) {
                //                     model
                //                         .items[index].favorite = false;
                //
                //                     favorite.deleteFromFavorite(
                //                         model
                //                             .items[index].id);
                //                   } else {
                //                     model
                //                         .items[index].favorite = true;
                //
                //                     favorite.addToFavorite(
                //                         model
                //                             .items[index].id);
                //                   }
                //                 });
                //
                //                 return Future.value(!isLiked);
                //               },
                //               favoriteIcon: model.items[index].favorite == true
                //                   ? Icons.favorite
                //                   : Icons.favorite_border,
                //               favoriteIconColor: model.items[index].favorite == true
                //                   ? Colors.redAccent[400]!
                //                   : Colors.grey
                //           );
                //         },
                //       );
                //     },
                //   ),
                // ),

                Flexible(
                    child: PagedListView(
                  scrollDirection: Axis.horizontal,
                  pagingController: model.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Product>(
                    itemBuilder: (context, product, index) {
                      productStatusModel.getProductStatus(
                          productId: productId.toString());
                      return StatefulBuilder(
                        builder: (context, mySetState) {
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
                                //     type: 'similar product',
                                //     currency: "RY",
                                //     price: double.parse(
                                //         product.firstPrice.toString()));
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
                              numberResidents:
                                  product.numberResidents.toString(),
                              overallAssessment:
                                  product.overallAssessment.toString(),
                              isNewProduct: product.isNewProduct as bool,
                              isMostSellingProduct: product.mostSell as bool,
                              status: productStatusModel.status,
                              onTapFavorite: (bool isLiked) {
                                mySetState(() {
                                  if (product.favorite == true) {
                                    product.favorite = false;

                                    favorite.deleteFromFavorite(
                                        product.id.toString());
                                  } else {
                                    product.favorite = true;

                                    favorite
                                        .addToFavorite(product.id.toString());
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
                    },
                    firstPageProgressIndicatorBuilder: (context) =>
                        const ProductShimmer(),
                    firstPageErrorIndicatorBuilder: (context) => Center(
                        child: Text(allTranslations.text("networkConnection"))),
                    newPageProgressIndicatorBuilder: (context) =>
                        const Center(child: CircularLoading()),
                    noMoreItemsIndicatorBuilder: (context) => const Text(""),
                    noItemsFoundIndicatorBuilder: (context) => 0.ph,
                  ),
                )),
              ],
            ),
          );
        },
      ),
    );
  }
}
