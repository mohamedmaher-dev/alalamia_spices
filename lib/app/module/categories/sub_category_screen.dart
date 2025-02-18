

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/categories/sub_category_products.dart';
import 'package:alalamia_spices/app/module/categories/widget/category_shimmer.dart';
import 'package:alalamia_spices/app/module/categories/widget/index.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/utils/constants.dart';
import '../../core/values/app_lottie.dart';



class SubCategoryScreen extends StatelessWidget {
  final String mainCateId;
  final String mainCategoryImage;
   const SubCategoryScreen({
     Key? key,
     required this.mainCateId,
     required this.mainCategoryImage
   }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
          child:  const CustomAppBar(),
        ),
        body: ChangeNotifierProvider<SubMainCategoryModel>(
          create: (context) => SubMainCategoryModel(context, id : mainCateId),
          child: Consumer<SubMainCategoryModel>(
            builder: (context , model , child) {
              return model.isLoading || model.loadingFailed
                ? const CategoryShimmer()
                : ListView(
                children: [


                 SubCategoryCarouselSliders(
                   sliderImage: mainCategoryImage,
                 ),

                  5.ph,

                  model.items.isEmpty
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: CustomMessage(
                            appLottieIcon: AppLottie.noData,
                            message: allTranslations.text("noData"),
                          ))
                    ],
                  )

                      : GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.vertical,
                    gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300.w,
                      mainAxisExtent: 267.h, // when it is in vertical this control the space vertically
                    ),
                    itemCount: model.items.length,
                    itemBuilder: (context , index){
                      return CustomCategoryCard(
                          onTap: () {
                            pushScreen(context, SubCategoryProducts(
                              id: model.items[index].id,
                              mainCateId: mainCateId,
                              isFromSubMainScreen: true,
                            ));
                          },
                          image: model.items[index].imageUrl,
                          name: model.items[index].name,
                        categoryTap: true,
                        containerNameColor: Theme.of(context).secondaryHeaderColor,
                        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontFamily: 'cairo',
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor
                        ),
                      );

                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>  SubCategoryProducts(
                        //               id: model.items[index].id,
                        //               mainCateId: mainCateId,
                        //               isFromSubMainScreen: true,
                        //             )
                        //         )
                        //     );
                        //   },
                        //   child: Padding(
                        //     padding:  EdgeInsets.symmetric(horizontal: 10.w , vertical: 3.h),
                        //     child: Column(
                        //       children: [
                        //         Container(
                        //           decoration: BoxDecoration(
                        //               color: Theme.of(context).secondaryHeaderColor,
                        //               borderRadius: const BorderRadius.only(
                        //                 topRight: Radius.circular(AppConstants.defaultBorderRadius.w),
                        //                 topLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
                        //               ),
                        //               boxShadow: [
                        //                 BoxShadow(
                        //                     color: Theme.of(context).focusColor.withOpacity(0.05),
                        //                     offset: const Offset(0, 5),
                        //                     blurRadius: 5
                        //                 )
                        //               ]),
                        //           height: 40.h,
                        //           width: MediaQuery.of(context).size.width,
                        //           child: Center(
                        //             child: Text(
                        //               model.items[index].name,
                        //               style: Theme.of(context).textTheme.headline1,
                        //             ),
                        //           ),
                        //         ),
                        //
                        //         SizedBox(
                        //           height: 200.h,
                        //           width: 220.w,
                        //           child: ClipRRect(
                        //             borderRadius: const BorderRadius.only(
                        //               bottomLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
                        //               bottomRight: Radius.circular(AppConstants.defaultBorderRadius.w),
                        //             ),
                        //             child: CachedNetworkImage(
                        //               fit: BoxFit.fill,
                        //               imageUrl: model.items[index].imageUrl,
                        //               placeholder: (context, url) => SizedBox(
                        //                 width: 70,
                        //                 height: 70,
                        //                 child: Padding(
                        //                     padding: EdgeInsets.all(10.0.w),
                        //                     child: Image.asset(
                        //                       AppImages.logo,
                        //                     )),
                        //               ),
                        //               errorWidget: (context, url, error) => SizedBox(
                        //                 width: 70,
                        //                 height: 70,
                        //                 child: Padding(
                        //                     padding: EdgeInsets.all(10.0.w),
                        //                     child: Image.asset(
                        //                       AppImages.logo,
                        //                     )),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //
                        //       ],
                        //     ),
                        //   ));
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

}
