import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/module/categories/sub_category_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import 'package:shimmer/shimmer.dart';
import '../../../services/screen_navigation_service.dart';
import '../../categories/sub_category_screen.dart';
import 'package:alalamia_spices/app/exports/widget.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  //  static final facebookAppEvents = FacebookAppEvents();

  @override
  Widget build(BuildContext context) {
    var mainCategoryModel = Provider.of<MainCategoriesModel>(context);
    return mainCategoryModel.isLoading || mainCategoryModel.loadingFailed
        ? _loadingShimmer()
        : SizedBox(
            height: 266.h,
            child: Row(
              children: [
                Container(
                  height: 260.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              AppConstants.defaultBorderRadius.w),
                          bottomLeft: Radius.circular(
                              AppConstants.defaultBorderRadius.w))),
                  child: CustomRotatedBox(
                    text: allTranslations.text("categories"),
                  ),
                ),
                Flexible(
                    child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: mainCategoryModel.items.length,
                  itemBuilder: (context, index) {
                    return CustomCategoryCard(
                      onTap: () {
                        mainCategoryModel.items[index].level >= 100
                            ? pushScreen(
                                context,
                                SubCategoryProducts(
                                  id: mainCategoryModel.items[index].id,
                                  mainCateId: mainCategoryModel.items[index].id,
                                  isFromSubMainScreen: false,
                                ))
                            : pushScreen(
                                context,
                                SubCategoryScreen(
                                  mainCateId: mainCategoryModel.items[index].id,
                                  mainCategoryImage:
                                      mainCategoryModel.items[index].imagePath2,
                                ));

                        // facebookAppEvents.logAddToWishlist(
                        //     id: mainCategoryModel.items[index].id.toString(),
                        //     type: 'category =  ${mainCategoryModel.items[index].name}',
                        //     currency: "RY",
                        //     price: double.parse("0.0")
                        // );
                      },
                      image:
                          mainCategoryModel.items[index].imagePath.toString(),
                      name: mainCategoryModel.items[index].name.toString(),
                    );
                  },
                )),
              ],
            ),
          );
  }

  Widget _loadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.25),
      highlightColor: Colors.white.withOpacity(0.6),
      child: SizedBox(
        height: 250.h,
        child: Row(
          children: [
            SizedBox(
              height: 240.h,
              width: 30.w,
              child: CustomRotatedBox(
                text: allTranslations.text("categories"),
              ),
            ),
            Flexible(
                child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: Container(
                    height: 200.h,
                    width: 150.w,
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          AppConstants.defaultBorderRadius.w),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(
                                AppConstants.defaultBorderRadius.w),
                            child: CustomCachedNetworkImage(
                              imageUrl: "",
                              fit: BoxFit.fill,
                              height: 200.h,
                              width: 180.w,
                            )),
                        5.ph,
                        const Center(
                          child: Skeleton(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
