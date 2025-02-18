import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/global_widgets/custom_category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../services/screen_navigation_service.dart';
import '../sub_category_products.dart';
import '../sub_category_screen.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody({super.key});

  //  static final facebookAppEvents = FacebookAppEvents();
  @override
  Widget build(BuildContext context) {
    var mainCategoryModel = Provider.of<MainCategoriesModel>(context);
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300.w,
        mainAxisExtent:
            267.h, // when it is in vertical this control the space vertically
        // childAspectRatio: 3 / 6,
        // crossAxisSpacing: 3, // the space between them horizontally
        // mainAxisSpacing: 3
      ),
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
          },
          image: mainCategoryModel.items[index].imagePath.toString(),
          name: mainCategoryModel.items[index].name.toString(),
          categoryTap: true,
          containerNameColor: Theme.of(context).secondaryHeaderColor,
          textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontFamily: 'cairo',
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        );
      },
    );
  }
}
