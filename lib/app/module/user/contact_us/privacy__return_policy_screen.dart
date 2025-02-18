import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';


class PrivacyReturnPolicyScreen extends StatelessWidget {
  final bool isPrivacyPolicy ;
  const PrivacyReturnPolicyScreen({
    Key? key,
    required this.isPrivacyPolicy
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context);
    return ChangeNotifierProvider(
      create: (context) => ContentModel(context),
      child: Consumer<ContentModel>(
        builder: (context , model , child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor:  Theme.of(context).colorScheme.background,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                child: const CustomAppBar(),
              ),
              body: ListView(
                children: [

                  Padding(
                    padding: EdgeInsets.all(15.0.h),
                    child: Text(
                        isPrivacyPolicy == true
                        ? allTranslations.text("privacyPolicy")
                        : allTranslations.text("returnPolicy"),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp
                      ),
                    ),
                  ),

                  20.ph,

                  model.isLoading || model.loadingFailed
                  ? const CircularLoading()
                  : Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.w),
                    child: Container(
                      padding:  EdgeInsets.all(10.0.w),
                      decoration: BoxDecoration(
                        borderRadius:  BorderRadius.only(
                          topLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
                          topRight: Radius.circular(AppConstants.defaultBorderRadius.w)
                        ),
                        color:  Theme.of(context).primaryColor,
                      ),
                      child:  HtmlWidget(
                         isPrivacyPolicy == true
                            ? model.content.privacyPolicy.toString()
                            : model.content.returnPolicy.toString(),
                        renderMode: RenderMode.column,
                        textStyle:  Theme.of(context).textTheme.bodyLarge,
                        customStylesBuilder: (element) {
                          if (element != null && themeModel.darkTheme == true){
                            return {'color': 'white'};
                          }

                        },

                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
