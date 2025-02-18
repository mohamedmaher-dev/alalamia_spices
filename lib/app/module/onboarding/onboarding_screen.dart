
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/utils/route.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/auth/auth_tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../alalamiah_app.dart';
import '../../core/values/app_images.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  PageController? _controller;

  var myarr = [
    {
      "title": allTranslations.text("product_reviews"),
      "info": allTranslations.text("Select_the_type_of_product"),
      "image": AppImages.onboarding1,
    },
    {
      "title": allTranslations.text("various_branches"),
      "info": allTranslations.text("You_can_choose_your_preferred_product_from_any_branch_near"),
      "image": AppImages.onboarding2,
    },
    {
      "title": allTranslations.text("Multi_language_app"),
      "info": allTranslations.text("Supports_both_Arabic_and_English_languages"),
      "image": AppImages.onboarding3,
    },
    {
      "title": allTranslations.text("Multiple_payment_methods"),
      "info": allTranslations.text("The_ability_to_pay_via_smart_cards"),
      "image": AppImages.onboarding4,
    },
  ];

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: ChangeNotifierProvider<UserModel>(
          create: (context) => UserModel(context),
          child: Consumer<UserModel>(
            builder: (context , model , child){
              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: myarr.length,
                      onPageChanged: (int index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      itemBuilder: (_, i) {
                        return Column(
                          children: [
                            Image.asset(
                              myarr[i]['image']!,
                              fit: BoxFit.fill,
                              height: 450.h,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Text(
                                myarr[i]['title']!,
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.sp
                                )
                            ),
                            20.ph,
                            SizedBox(
                              width : 250.w,
                              child: Text(
                                  myarr[i]['info']!,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 14.sp
                                  )
                              ),
                            )
                          ],
                        );
                      },

                    ),

                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      myarr.length,
                          (index) => buildDot(index, context),
                    ),
                  ),


                ],
              );
            },
          ),
        ),



        bottomNavigationBar:  Padding(
          padding:  EdgeInsets.all(20.0.w),
          child: Row(
            mainAxisAlignment: currentIndex == myarr.length - 1  ? MainAxisAlignment.center :  MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              currentIndex == myarr.length - 1
              ? const SizedBox.shrink()
              : CustomButtons(
                height: 30.h,
                width: 90.w,
                text:  allTranslations.text('skip'),
                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                buttonColor: Colors.transparent,
                onTap: () async{
                  userModel.visit();

                  ///function restartApp for restart app to save user data info for load app data second to this user
                  await MaterialAppWithTheme.restartApp(context);
                  // Navigator.of(context).pushAndRemoveUntil(
                  //     MaterialPageRoute(builder: (context) =>
                  //     Start()), (Route<dynamic> route) => false);

                },
              ),

              InkWell(
                onTap: (){
                  if (currentIndex == myarr.length - 1) {
                    // Navigator.of(context).pushAndRemoveUntil(
                    //     MaterialPageRoute(
                    //         builder: (context) => const AuthTabsScreen()
                    //     ),
                    //         (Route<dynamic> route) => true);

                    pushNamedRemoveUntil(
                        context,
                        Routes.authTapsScreen
                    );

                  }


                  _controller!.nextPage(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.bounceIn, );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomButtons(
                      height:currentIndex == myarr.length - 1  ? 50.h : 30.h,
                      width: currentIndex == myarr.length - 1  ? 300.w : 90.w,
                      text: currentIndex == myarr.length - 1 ?
                      allTranslations.text('startNow') : allTranslations.text('continue'),
                      textStyle: currentIndex == myarr.length - 1
                          ? Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                      )
                          : Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          // fontSize: 16.sp
                      ),
                      buttonColor: currentIndex == myarr.length - 1
                      ? Theme.of(context).secondaryHeaderColor
                      : Colors.transparent,
                      onTap: (){
                        if (currentIndex == myarr.length - 1) {
                          pushNamedRemoveUntil(
                              context,
                              Routes.authTapsScreen
                          );
                        }


                        _controller!.nextPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.bounceIn, );
                      },
                    ),
                    currentIndex == myarr.length - 1
                    ? 0.ph
                    : Icon(
                      allTranslations.currentLanguage == "en"
                          ? Icons.keyboard_double_arrow_right
                          : Icons.keyboard_double_arrow_left,
                      size: 25,
                    )
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  CustomDots buildDot(int index, BuildContext context) {
    return CustomDots(
        dotHeight: 10.h,
        dotWidth: currentIndex == index ? 25.w : 10.w,
        dotColor:  currentIndex == index
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).secondaryHeaderColor.withOpacity(0.8)
    );


  }
}


