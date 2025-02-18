
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/categories/widget/category_shimmer.dart';
import 'package:alalamia_spices/app/module/categories/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/utils/constants.dart';



class CategoryTab extends StatelessWidget {
   const CategoryTab({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    MainCategoriesModel mainCategoriesModel = Provider.of<MainCategoriesModel>(context);
    // var  networkStatus = Provider.of<NetworkStatus>(context);
    return  Consumer<ConnectivityNotifier> (
      builder: (context , connection , child) {
        return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
              child: const CustomAppBar(
                  isHome : true
              ),
            ),
            body:  ListView(
              children: [

                const CategoryCarouselSliders(),
                5.ph,



                mainCategoriesModel.isLoading || mainCategoriesModel.loadingFailed
                    ? const CategoryShimmer()
                    : const CategoryBody(),
              ],
            ),
            bottomNavigationBar: connection.hasConnection
                ? 0.ph
                : const NoInternetMessage()
        );
      },
    );
  }
}
