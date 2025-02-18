import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import '../../../core/values/app_lottie.dart';
import '../../../services/screen_navigation_service.dart';
import '../../product_details/product_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // static final facebookAppEvents = FacebookAppEvents();
  @override
  Widget build(BuildContext context) {
    final productStatusModel = Provider.of<ProductStatusModel>(context);

    return ChangeNotifierProvider(
      create: (context) => FavoriteModel(context),
      child: Consumer<FavoriteModel>(
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                child: const CustomAppBar(),
              ),
              body: Padding(
                padding: EdgeInsets.all(5.0.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                      child: Text(
                        allTranslations.text("favorites"),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 22.sp),
                      ),
                    ),
                    3.ph,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                      child: Text(
                        allTranslations.text("favoritesSubTitle"),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    10.ph,
                    model.isLoading || model.loadingFailed
                        ? const Flexible(child: ProductShimmer())
                        : Flexible(
                            child: model.items.isEmpty
                                ? Center(
                                    child: CustomMessage(
                                      message: allTranslations.text("noData"),
                                      appLottieIcon: AppLottie.noData,
                                      repeat: false,
                                    ),
                                  )
                                : GridView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    scrollDirection: Axis.vertical,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 300.w,
                                      mainAxisExtent:
                                          AppConstants.mainAxisExtentProduct.h,
                                      // childAspectRatio: 3 / 6,
                                      // crossAxisSpacing: 3, // the space between them horizontally
                                      // mainAxisSpacing: 3
                                    ),
                                    itemCount: model.items.length,
                                    itemBuilder: (context, index) {
                                      productStatusModel.getProductStatus(
                                          productId:
                                              model.items[index].id.toString());
                                      return CustomProductCard(
                                          index: index,
                                          product: model.items[index],
                                          onTap: () {
                                            pushScreen(
                                              context,
                                              ProductDetailsScreen(
                                                product: model.items[index],
                                              ),
                                            );

                                            // facebookAppEvents.logAddToWishlist(
                                            //     id: model.items[index].id
                                            //         .toString(),
                                            //     type: 'product new arrival',
                                            //     currency: "RY",
                                            //     price: double.parse(model
                                            //         .items[index].firstPrice
                                            //         .toString()));
                                          },
                                          name: model.items[index].name,
                                          firstPrice: model.items[index].firstPrice
                                              .toString(),
                                          image: model.items[index].image640
                                              .toString(),
                                          currency: model.items[index].prices.length > 0
                                              ? model.items[index].prices[0]
                                                  .currency
                                                  .toString()
                                              : "",
                                          oldPrice:
                                              model.items[index].prices.length > 0 &&
                                                      model
                                                              .items[index]
                                                              .prices[0]
                                                              .oldPrice !=
                                                          ""
                                                  ? model.items[index].prices[0]
                                                      .oldPrice
                                                      .toString()
                                                  : "",
                                          discount: model.items[index].prices.length > 0 &&
                                                  model.items[index].prices[0].oldPrice != ""
                                              ? model.items[index].discount.toString()
                                              : '',
                                          numberResidents: model.items[index].numberResidents.toString(),
                                          overallAssessment: model.items[index].overallAssessment.toString(),
                                          isNewProduct: model.items[index].isNewProduct,
                                          isMostSellingProduct: model.items[index].mostSell,
                                          status: productStatusModel.status,
                                          onTapFavorite: (bool isLiked) {
                                            setState(() {
                                              if (model.items[index].favorite ==
                                                  true) {
                                                model.items[index].favorite =
                                                    false;

                                                model.deleteFromFavorite(
                                                    model.items[index].id);
                                                model.loadData();
                                                // if(model.isLoaded)
                                                // {
                                                //   model.loadData();
                                                //   Provider.of<NewArrivalModel>(context,listen: false).loadData();
                                                // }
                                              } else {
                                                model.items[index].favorite =
                                                    true;

                                                model.addToFavorite(
                                                    model.items[index].id);
                                                model.loadData();
                                              }
                                            });

                                            return Future.value(!isLiked);
                                          },
                                          favoriteIcon: model.items[index].favorite == true ? Icons.favorite : Icons.favorite_border,
                                          favoriteIconColor: model.items[index].favorite == true ? Colors.redAccent[400]! : Colors.grey);

                                      //   InkWell(
                                      //   onTap: (){
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 ProductDetailsScreen(
                                      //                   product: model.items[index],
                                      //                 )));
                                      //   },
                                      //   child: Padding(
                                      //     padding:  EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
                                      //     child: Container(
                                      //       height: 350.h,
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
                                      //                 padding: const EdgeInsets.only(top: 25 , bottom: 5 , left : 10 , right: 10),
                                      //                 child: ClipRRect(
                                      //                   borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                      //                   child: SizedBox(
                                      //                       height: 200.h,
                                      //                       width: 150.w,
                                      //                       child: CustomCachedNetworkImage(
                                      //                         fit: BoxFit.fill,
                                      //                         imageUrl: model.items[index].image360,
                                      //                       )
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //               Container(
                                      //                 width: 150.w,
                                      //                 height: 70.h,
                                      //                 padding: const EdgeInsets.only(left: 5 , right: 5),
                                      //                 child: Column(
                                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                                      //                   mainAxisAlignment: MainAxisAlignment.start,
                                      //                   children: [
                                      //                     Text(
                                      //                         model.items[index].name.toString(),
                                      //                         maxLines: 3,
                                      //                         overflow: TextOverflow.ellipsis,
                                      //                         softWrap: false,
                                      //                         style: Theme.of(context).textTheme.bodyMedium!
                                      //                     ),
                                      //
                                      //
                                      //                     10.ph,
                                      //
                                      //                     Row(
                                      //                       crossAxisAlignment: CrossAxisAlignment.center,
                                      //                       mainAxisAlignment: MainAxisAlignment.start,
                                      //                       children: [
                                      //                         Text(
                                      //                             model.items[index].firstPrice  + " " ,
                                      //                             style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                      //                                 fontWeight: FontWeight.bold
                                      //                             )
                                      //                         ),
                                      //                         Text(
                                      //                             model.items[index].prices.length > 0
                                      //                                 ? model.items[index].prices[0].currency
                                      //                                 : "",
                                      //                             style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                      //                                 fontWeight: FontWeight.bold
                                      //                             )
                                      //                         ),
                                      //                       ],
                                      //                     ),
                                      //
                                      //                     5.ph,
                                      //
                                      //                     model.items[index].prices.length > 0
                                      //                         ? model.items[index].prices[0].oldPrice != ""
                                      //                         ? Row(
                                      //                       crossAxisAlignment: CrossAxisAlignment.center,
                                      //                       mainAxisAlignment: MainAxisAlignment.start,
                                      //                       children:  [
                                      //                         Text(
                                      //                             "${model.items[index].prices[0].oldPrice
                                      //                                 + " " +
                                      //                                 model.items[index].prices[0].currency
                                      //                             }",
                                      //                             style: Theme.of(context).textTheme.overline!.copyWith(
                                      //                                 fontWeight: FontWeight.bold
                                      //                             )
                                      //                         ),
                                      //                         5.pw,
                                      //                         Text(
                                      //                             "${allTranslations.text("discountPercentage")} "
                                      //                                 + " " + model.items[index].discount,
                                      //                             style: Theme.of(context).textTheme.caption!.copyWith(
                                      //                                 color: Colors.green
                                      //                             )
                                      //                         ),
                                      //                       ],
                                      //                     )
                                      //                         : const SizedBox.shrink()
                                      //                         : const SizedBox.shrink(),
                                      //                     5.ph,
                                      //
                                      //                   ],
                                      //                 ),
                                      //               ),
                                      //
                                      //
                                      //               /// Availability
                                      //               Padding(
                                      //                 padding: const EdgeInsets.only(left: 5 , right: 5 , top: 10 , bottom: 5),
                                      //                 child: Row(
                                      //                   mainAxisAlignment: model.items[index].status == true
                                      //                       ? MainAxisAlignment.center
                                      //                       : MainAxisAlignment.spaceBetween,
                                      //                   crossAxisAlignment: CrossAxisAlignment.center,
                                      //                   children: [
                                      //                     model.items[index].prices.length > 0
                                      //                         ? model.items[index].status == true
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
                                      //                     )
                                      //                         : const SizedBox.shrink(),
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
                                      //                             double.parse(model.items[index].overallAssessment.toString()).round().toString(),
                                      //                             style: Theme.of(context).textTheme.overline!.copyWith(
                                      //                                 color: Theme.of(context).secondaryHeaderColor,
                                      //                                 decoration: TextDecoration.none
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
                                      //                             double.parse(model.items[index].numberResidents.toString()).round().toString(),
                                      //                             style: Theme.of(context).textTheme.overline!.copyWith(
                                      //                                 color: Theme.of(context).secondaryHeaderColor,
                                      //                                 decoration: TextDecoration.none
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
                                      //           /// favorite
                                      //           Positioned(
                                      //             top: 5,
                                      //             left: 8,
                                      //             right: 8,
                                      //             child: Row(
                                      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //               children: [
                                      //                 const SizedBox.shrink(),
                                      //
                                      //                 LikeButton(
                                      //                   size: 20,
                                      //                   circleColor: CircleColor(
                                      //                       start: Colors.redAccent[400]!,
                                      //                       end: Colors.redAccent[400]!),
                                      //                   bubblesColor: BubblesColor(
                                      //                     dotPrimaryColor: Colors.redAccent[400]!,
                                      //                     dotSecondaryColor: Colors.redAccent[400]!,
                                      //                   ),
                                      //                   likeBuilder: (bool isLiked) {
                                      //                     return  Padding(
                                      //                       padding: const EdgeInsets.only(left: 2 , right: 2 , top: 1 , bottom: 1),
                                      //                       child: Icon(
                                      //                         model.items[index].favorite == true
                                      //                             ? Icons.favorite
                                      //                             : Icons.favorite_border,
                                      //                         color: model.items[index].favorite == true
                                      //                             ? Colors.redAccent[400]
                                      //                             : Colors.grey,
                                      //                         size: 20,
                                      //                       ),
                                      //                     );
                                      //                   },
                                      //                   onTap: (bool isLiked) {
                                      //                     setState(() {
                                      //                       if (model.items[index].favorite) {
                                      //                         model.items[index].favorite = false;
                                      //
                                      //                         model.deleteFromFavorite(model.items[index].id);
                                      //
                                      //                         if(model.isLoaded)
                                      //                         {
                                      //                           model.loadData();
                                      //                           Provider.of<NewArrivalModel>(context,listen: false).loadData();
                                      //                         }
                                      //                       } else {
                                      //                         model.items[index].favorite = true;
                                      //
                                      //                         model.addToFavorite(model.items[index].id);
                                      //                       }
                                      //                     });
                                      //
                                      //                     return Future.value(!isLiked);
                                      //                   },
                                      //                 )
                                      //               ],
                                      //             ),
                                      //           ),
                                      //
                                      //
                                      //           ///  share
                                      //
                                      //           // Positioned(
                                      //           //   top: 40,
                                      //           //   left: 8,
                                      //           //   right: 8,
                                      //           //   child: Column(
                                      //           //     mainAxisAlignment: MainAxisAlignment.end,
                                      //           //     crossAxisAlignment: CrossAxisAlignment.end,
                                      //           //     children:  const[
                                      //           //
                                      //           //       Padding(
                                      //           //         padding:  EdgeInsets.only(left: 2 , right: 2 , top: 1 , bottom: 1),
                                      //           //         child: Icon(
                                      //           //           Icons.share,
                                      //           //           color: Colors.grey,
                                      //           //           size: 20,
                                      //           //         ),
                                      //           //       ),
                                      //           //     ],
                                      //           //   ),
                                      //           // ),
                                      //
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                  ),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
