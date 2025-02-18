import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/module/auth/phone/phone_screen.dart';
import 'package:alalamia_spices/app/module/auth/sign_in/sign_in_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/utils/constants.dart';
import '../../core/values/app_images.dart';
import 'package:alalamia_spices/app/exports/provider.dart';

class AuthTabsScreen extends StatefulWidget {
  const AuthTabsScreen({Key? key}) : super(key: key);

  @override
  State<AuthTabsScreen> createState() => _AuthTabsScreenState();
}

class _AuthTabsScreenState extends State<AuthTabsScreen> {

  @override
  Widget build(BuildContext context) {
    var countriesModel = Provider.of<CountriesModel>(context);
    countriesModel.getCountryCode();
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
            body: GestureDetector(
              onTap: (){
                return FocusScope.of(context).unfocus();
              },
              child: ListView(
             children: [
              Container(
                height: 300.h,
                width: MediaQuery.of(context).size.width,
                decoration:  BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage(AppImages.login), fit: BoxFit.fill),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50.w),
                    bottomLeft: Radius.circular(50.w),
                  ),
                ),
              ),
              20.ph,
              Padding(
                padding:  EdgeInsets.only(bottom: 5.0.h),
                child: Container(
                  height: 50.h,
                  decoration:  BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:  BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TabBar(
//                    isScrollable: false,
//                    physics: NeverScrollableScrollPhysics(),
                    labelColor: Theme.of(context).secondaryHeaderColor,

                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                    indicatorColor: Theme.of(context).colorScheme.secondary,
                    unselectedLabelColor: Colors.grey,
                    unselectedLabelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14.sp
                    ),
                    indicatorSize: TabBarIndicatorSize.label,

                    tabs: [
                      Tab(
                        text: allTranslations.text("login"),
                      ),
                      Tab(
                        text: allTranslations.text("createAccount"),
                      ),
                    ],
                  ),
                ),
              ),


              /// tab view
              SizedBox(
                // color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 400.h,
                child: const TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    /// SignInPageMobile
                    SignInTab(),

                    /// NewAccountPageMobile
                    PhoneScreen(
                        isFromForgotPasswordScreen : false
                    ),
                  ],
                ),
              )
          ],
        ),
            )));
  }
}
