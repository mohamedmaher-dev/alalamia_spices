import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import '../../../global_widgets/circular_loading.dart';
import '../../../global_widgets/custom_app_bar.dart';
import 'package:alalamia_spices/app/exports/provider.dart';


class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContentModel>(
      create: (context) => ContentModel(context),
      child: Consumer<ContentModel>(
        builder: (context , model , child){
          return SafeArea(
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                child: const CustomAppBar(),
              ),
              body: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.0.h),
                    child: Text(
                      allTranslations.text("aboutApp"),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp
                      ),
                    ),
                  ),

                  model.isLoading || model.loadingFailed
                      ? const CircularLoading()
                      : Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 5.w),
                        child: Container(
                          padding:  EdgeInsets.all(10.0.w),
                          decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:  BorderRadius.only(
                              topRight: Radius.circular(AppConstants.defaultBorderRadius.w),
                              topLeft: Radius.circular(AppConstants.defaultBorderRadius.w)
                          )
                    ),
                    child: HtmlWidget(
                      model.content.theShop.toString()
                    )
                  ),
                      ),
                ],
              ),

            ),
          );
        },
      ),
    );
  }
}
