import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/global_widgets/build_error_widget.dart';
import 'package:alalamia_spices/app/module/categories/sub_category_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/utils/constants.dart';
import '../../core/values/app_images.dart';
import '../../data/model/new_arrival.dart';
import '../../services/screen_navigation_service.dart';
import '../product_details/product_details_screen.dart';

class SubCategoryProducts extends StatefulWidget {
  final String id;
  final String mainCateId;
  final bool isFromSubMainScreen;

  const SubCategoryProducts({
    super.key,
    required this.id,
    required this.isFromSubMainScreen,
    required this.mainCateId,
  });

  @override
  State<SubCategoryProducts> createState() => _SubCategoryProductsState();
}

class _SubCategoryProductsState extends State<SubCategoryProducts> {
  String? chosenValue;
  // static final facebookAppEvents = FacebookAppEvents();

  @override
  Widget build(BuildContext context) {
    var mainCategoryModel = Provider.of<MainCategoriesModel>(context);
    var productStatusModel = Provider.of<ProductStatusModel>(context);
    var favorite = Provider.of<FavoriteModel>(context);
    final connectionProvider = Provider.of<ConnectivityNotifier>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
          child: const CustomAppBar(),
        ),
        body: ChangeNotifierProvider<SubCategoryProductModel>(
          create: (context) => SubCategoryProductModel(context,
              mainId: widget.mainCateId.toString(),
              subMainId: widget.isFromSubMainScreen == false ? "0" : widget.id),
          child: Consumer<SubCategoryProductModel>(
            builder: (context, model, child) {
              debugPrint(
                  "SubCategoryProductsScreen ${widget.isFromSubMainScreen} = ${widget.mainCateId} + ${widget.id}");
              return Column(
                children: [
                  5.ph,

                  /// main category
                  mainCategoryModel.isLoading || mainCategoryModel.loadingFailed
                      ? const CircularLoading()
                      : Container(
                          height: 70.h,
                          color: Theme.of(context).primaryColor,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: mainCategoryModel.items.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  mainCategoryModel.items[index].level >= 100
                                      ? pushScreen(
                                          context,
                                          SubCategoryProducts(
                                            id: mainCategoryModel
                                                .items[index].id,
                                            mainCateId: widget.mainCateId,
                                            isFromSubMainScreen: false,
                                          ))
                                      : pushScreen(
                                          context,
                                          SubCategoryScreen(
                                            mainCateId: mainCategoryModel
                                                .items[index].id,
                                            mainCategoryImage: mainCategoryModel
                                                .items[index].imagePath2,
                                          ));
                                },
                                child: CategoryCard(
                                  categoryName:
                                      mainCategoryModel.items[index].name,
                                  categoryId: mainCategoryModel.items[index].id
                                      .toString(),
                                ),
                              );
                            },
                          ),
                        ),

                  5.ph,

                  /// category product
                  Flexible(
                    child: PagedGridView<int, Product>(
                      scrollDirection: Axis.vertical,
                      pagingController: model.pagingController,
                      showNoMoreItemsIndicatorAsGridChild: false,
                      showNewPageProgressIndicatorAsGridChild: false,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300.w,
                        mainAxisExtent: AppConstants.mainAxisExtentProduct.h,
                      ),
                      builderDelegate: PagedChildBuilderDelegate<Product>(
                        itemBuilder: (context, product, index) {
                          final subCateDataModel = product;
                          productStatusModel.getProductStatus(
                              productId: subCateDataModel.id.toString());
                          return CustomProductCard(
                              index: index,
                              product: product,
                              onTap: () {
                                pushScreen(
                                  context,
                                  ProductDetailsScreen(
                                    product: subCateDataModel,
                                  ),
                                );

                                // facebookAppEvents.logAddToWishlist(
                                //     id: subCateDataModel.id.toString(),
                                //     type:
                                //         'from category ${subCateDataModel.id.toString()}',
                                //     currency: "RY",
                                //     price: double.parse(subCateDataModel
                                //         .firstPrice
                                //         .toString()));
                              },
                              name: subCateDataModel.name.toString(),
                              firstPrice:
                                  subCateDataModel.firstPrice.toString(),
                              image: subCateDataModel.image640.toString(),
                              currency: subCateDataModel.prices!.isNotEmpty
                                  ? subCateDataModel.prices![0].currency
                                      .toString()
                                  : "",
                              oldPrice: subCateDataModel.prices!.isNotEmpty &&
                                      subCateDataModel.prices![0].oldPrice != ""
                                  ? subCateDataModel.prices![0].oldPrice
                                      .toString()
                                  : "",
                              discount: subCateDataModel.prices!.isNotEmpty &&
                                      subCateDataModel.prices![0].oldPrice != ""
                                  ? subCateDataModel.discount.toString()
                                  : '',
                              numberResidents:
                                  subCateDataModel.numberResidents.toString(),
                              overallAssessment:
                                  subCateDataModel.overallAssessment.toString(),
                              isNewProduct:
                                  subCateDataModel.isNewProduct as bool,
                              isMostSellingProduct:
                                  subCateDataModel.mostSell as bool,
                              status: productStatusModel.status,
                              onTapFavorite: (bool isLiked) {
                                setState(() {
                                  if (subCateDataModel.favorite == true) {
                                    subCateDataModel.favorite = false;

                                    favorite.deleteFromFavorite(
                                        subCateDataModel.id.toString());
                                  } else {
                                    subCateDataModel.favorite = true;

                                    favorite.addToFavorite(
                                        subCateDataModel.id.toString());
                                  }
                                });

                                return Future.value(!isLiked);
                              },
                              favoriteIcon: subCateDataModel.favorite == true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              favoriteIconColor:
                                  subCateDataModel.favorite == true
                                      ? Colors.redAccent[400]!
                                      : Colors.grey);
                        },
                        firstPageProgressIndicatorBuilder: (context) =>
                            _shimmer(),
                        firstPageErrorIndicatorBuilder: (context) {
                          if (!connectionProvider.hasConnection) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomMessage(
                                  appLottieIcon: AppLottie.noConnection,
                                  message:
                                      allTranslations.text("networkConnection"),
                                )
                              ],
                            );
                          } else {
                            return const BuildErrorWidget();
                          }
                        },
                        newPageProgressIndicatorBuilder: (context) =>
                            const Center(child: CircularLoading()),
                        noMoreItemsIndicatorBuilder: (context) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0.h),
                          child: Center(
                            child: Text(
                              allTranslations.text("noMoreData"),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        noItemsFoundIndicatorBuilder: (context) => Center(
                            child: CustomMessage(
                                message: allTranslations.text("noData"),
                                appLottieIcon: AppLottie.noData)),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.25),
      highlightColor: Colors.white.withOpacity(0.6),
      child: SizedBox(
        height: 300.h,
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300.w,
            mainAxisExtent: 320.h,
          ),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Container(
                height: 300.h,
                width: 150.w,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25, bottom: 5, left: 10, right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            AppConstants.defaultBorderRadius.w),
                        child: SizedBox(
                          height: 155.h,
                          width: 150.w,
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: "",
                            placeholder: (context, url) => SizedBox(
                              width: 70,
                              height: 70,
                              child: Padding(
                                  padding: EdgeInsets.all(10.0.w),
                                  child: Image.asset(
                                    AppImages.logo,
                                  )),
                            ),
                            errorWidget: (context, url, error) => SizedBox(
                              width: 70,
                              height: 70,
                              child: Padding(
                                  padding: EdgeInsets.all(10.0.w),
                                  child: Image.asset(
                                    AppImages.logo,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 150.w,
                      height: 80.h,
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Skeleton(),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Skeleton(
                                width: 40.w,
                              ),
                              10.pw,
                              Skeleton(
                                width: 40.w,
                              ),
                            ],
                          ),
                          5.ph,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Skeleton(
                                width: 40.w,
                              ),
                              10.pw,
                              Skeleton(
                                width: 40.w,
                              ),
                            ],
                          ),
                          5.ph,
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, top: 10, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Skeleton(
                            height: 20.h,
                            width: 80.w,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 12,
                                ),
                                3.pw,
                                Skeleton(),
                                2.pw,
                                Skeleton(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
