import 'dart:io';
import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
//import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../alalamiah_app.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:alalamia_spices/app/module/user/user_screen/widget/index.dart';
import 'package:alalamia_spices/app/exports/provider.dart';

class UserBody extends StatefulWidget {
  const UserBody({super.key});

  @override
  State<UserBody> createState() => _UserBodyState();
}

class _UserBodyState extends State<UserBody> {
  int selectedCountry = -1;

  @override
  Widget build(BuildContext context) {
    var cartModel = Provider.of<CartModel>(context);
    var themeChange = Provider.of<ThemeModel>(context);
    var countriesModel = Provider.of<CountriesModel>(context);
    countriesModel.getCountryDetails();
    var userModel = Provider.of<UserModel>(context);
    var languageModel = Provider.of<GlobalTranslations>(context, listen: false);
    return Padding(
      padding: EdgeInsets.all(10.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appModel.token == "visitor"
              ? 0.ph
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// personal info
                    CustomCardIconText(
                      icon: Icons.person,
                      iconColor: Colors.grey,
                      itemsName: allTranslations.text("personalInfo"),
                      secondIcon: Icons.arrow_forward_ios,
                      secondIconColor: Colors.grey,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PersonalInfoScreen()));
                      },
                    ),
                    15.ph,

                    /// my last orders
                    CustomCardIconText(
                      icon: Icons.shopping_bag,
                      iconColor: Colors.grey,
                      itemsName: allTranslations.text("myLastOrders"),
                      secondIcon: Icons.arrow_forward_ios,
                      secondIconColor: Colors.grey,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LastOrdersScreen()));
                      },
                    ),

                    15.ph,

                    /// notifications
                    CustomCardIconText(
                      icon: Icons.notifications_active,
                      iconColor: Colors.grey,
                      itemsName: allTranslations.text("notifications"),
                      secondIcon: Icons.arrow_forward_ios,
                      secondIconColor: Colors.grey,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const NotificationsScreen()));
                      },
                    ),

                    15.ph,

                    /// my favorites
                    CustomCardIconText(
                      icon: Icons.favorite,
                      iconColor: Colors.grey,
                      itemsName: allTranslations.text("favorites"),
                      secondIcon: Icons.arrow_forward_ios,
                      secondIconColor: Colors.grey,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FavoritesScreen()));
                      },
                    ),

                    15.ph,

                    /// my locations
                    CustomCardIconText(
                      icon: Icons.pin_drop,
                      iconColor: Colors.grey,
                      itemsName: allTranslations.text("myLocations"),
                      secondIcon: Icons.arrow_forward_ios,
                      secondIconColor: Colors.grey,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MyLocationsScreen()));
                      },
                    ),

                    15.ph,

                    /// my special orders
                    CustomCardIconText(
                      icon: Icons.shop,
                      iconColor: Colors.grey,
                      itemsName: allTranslations.text("mySpecialOrders"),
                      secondIcon: Icons.arrow_forward_ios,
                      secondIconColor: Colors.grey,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MySpecialOrdersScreen()));
                      },
                    ),
                    15.ph,

                    /// suggestions and complaints
                    CustomCardIconText(
                      icon: Icons.settings_suggest,
                      iconColor: Colors.grey,
                      itemsName:
                          allTranslations.text("suggestionsAndComplaints"),
                      secondIcon: Icons.arrow_forward_ios,
                      secondIconColor: Colors.grey,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SuggestionsComplaintsScreen()));
                      },
                    ),
                  ],
                ),

          15.ph,

          /// help & contact us
          CustomCardIconText(
            icon: Icons.call,
            iconColor: Colors.grey,
            itemsName: allTranslations.text("helpAndContactUs"),
            secondIcon: Icons.arrow_forward_ios,
            secondIconColor: Colors.grey,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContactUsScreen()));
            },
          ),

          15.ph,

          /// about app
          CustomCardIconText(
            icon: Icons.info,
            iconColor: Colors.grey,
            itemsName: allTranslations.text("aboutApp"),
            secondIcon: Icons.arrow_forward_ios,
            secondIconColor: Colors.grey,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AboutAppScreen()));
            },
          ),

          15.ph,

          /// share app
          CustomCardIconText(
            icon: Icons.share,
            iconColor: Colors.grey,
            itemsName: allTranslations.text("shareApp"),
            secondIcon: Icons.arrow_forward_ios,
            secondIconColor: Colors.grey,
            onTap: () {
              Platform.isIOS
                  ? Share.share(AppConstants.iosLink)
                  : Share.share(AppConstants.androidLink);
            },
          ),

          15.ph,

          /// language
          CustomCardIconText(
            icon: Icons.language,
            iconColor: Colors.grey,
            itemsName: allTranslations.text("language"),
            secondIcon: Icons.arrow_forward_ios,
            secondIconColor: Colors.grey,
            subItemsName: languageModel.currentLanguage == "ar"
                ? allTranslations.text("arabic")
                : allTranslations.text("arabic"),
            onTap: () async {
              await LanguageBottomSheet()
                  .showLanguageBottomSheet(context: context);
            },
          ),

          15.ph,

          /// country
          // StatefulBuilder(
          //   builder: (context , mySetState){
          //     return CustomCardIconText(
          //         color: Theme.of(context).primaryColor,
          //         icon: Icons.language,
          //         iconColor: Colors.grey,
          //         height: 40.h,
          //         width: 45.w,
          //         itemsName: allTranslations.text("country"),
          //         // subItemsName: countriesModel.selectedCountryName,
          //         secondIcon: Icons.arrow_forward_ios,
          //         secondIconColor: Colors.grey,
          //         onTap: () async {
          //           await showModalBottomSheet(
          //               context: context,
          //               elevation: 0.3,
          //               isScrollControlled: true,
          //               enableDrag: true,
          //               shape:  RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.vertical(
          //                     top: Radius.circular(AppConstants.defaultBorderRadius.w)
          //                 ),
          //               ),
          //               builder: (context) {
          //                 return appModel.token == 'visitor'
          //                      ? StatefulBuilder(
          //                   builder: (context , mySetState) {
          //                     return Padding(
          //                       padding: EdgeInsets.all(10.0.w),
          //                       child: ListView(
          //                         shrinkWrap: true,
          //                         primary: false,
          //                         children: [
          //                           BottomSheetHeader(
          //                               title: allTranslations.text("country"),
          //                               subTitle: allTranslations.text("countrySubTitle")
          //                           ),

          //                           countriesModel.isLoading || countriesModel.loadingFailed
          //                               ? const CircularLoading()
          //                               : GridView.builder(
          //                             shrinkWrap: true,
          //                             scrollDirection: Axis.vertical,
          //                             physics: const NeverScrollableScrollPhysics(),
          //                             gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
          //                               maxCrossAxisExtent: 180.w,
          //                               mainAxisExtent: 160.h,
          //                               // childAspectRatio: 3 / 6,
          //                               // crossAxisSpacing: 3, // the space between them horizontally
          //                               // mainAxisSpacing: 3
          //                             ),
          //                             itemCount: countriesModel.items.length,
          //                             itemBuilder: (context , index){
          //                               return InkWell(
          //                                 onTap: (){
          //                                   mySetState((){
          //                                     selectedCountry = index;
          //                                     countryName = countriesModel.items[selectedCountry].name.toString();
          //                                     countryId = countriesModel.items[selectedCountry].id.toString();
          //                                     countryImage = countriesModel.items[selectedCountry].imagePath.toString();                                      });
          //                                   setState(() {

          //                                   });

          //                                 },
          //                                 child: CountryBody(countries: countriesModel.items[index] , selectedCountry: selectedCountry == index,),
          //                               );
          //                             },
          //                           ),

          //                           20.ph,

          //                           Padding(
          //                             padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
          //                             child: CustomButtons(
          //                                 height: 40.h,
          //                                 text: allTranslations.text("save"),
          //                                 buttonColor:{userModel.userCountryId}.isNotEmpty
          //                                     ? Theme.of(context).secondaryHeaderColor
          //                                     : Colors.grey,
          //                                 onTap: () async{

          //                                     countriesModel.saveCountryDetails(
          //                                         id: countryId.toString(),
          //                                         name: countryName.toString(),
          //                                         image: countryImage.toString()
          //                                     );
          //                                     countriesModel.saveCountryCode(
          //                                         initialCountry: countriesModel.items[selectedCountry].adminName.toString(),
          //                                         dialCode: countriesModel.items[selectedCountry].phone.toString(),
          //                                         countryId: countriesModel.items[selectedCountry].id.toString()
          //                                     );

          //                                   SharedPrefsService.putBool("hasShownDialog", false);
          //                                   await Provider.of<UserWalletModel>(context , listen: false).loadData(context);
          //                                   await Provider.of<CeilingPriceModel>(context , listen: false).loadData(context);
          //                                   await cartModel.deleteAll();
          //                                   await cartModel.loadData(context);
          //                                   await MaterialAppWithTheme.restartApp(context);
          //                                 }
          //                             ),
          //                           )
          //                         ],
          //                       ),
          //                     );
          //                   },
          //                 )
          //                      : StatefulBuilder(
          //                   builder: (context , mySetState) {
          //                     return Padding(
          //                       padding: EdgeInsets.all(10.0.w),
          //                       child: ListView(
          //                         shrinkWrap: true,
          //                         primary: false,
          //                         children: [

          //                           BottomSheetHeader(
          //                               title: allTranslations.text("country"),
          //                               subTitle: allTranslations.text("countrySubTitle")
          //                           ),

          //                           countriesModel.isLoading || countriesModel.loadingFailed
          //                               ? const CircularLoading()
          //                               : GridView.builder(
          //                             shrinkWrap: true,
          //                             scrollDirection: Axis.vertical,
          //                             physics: const NeverScrollableScrollPhysics(),
          //                             gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
          //                               maxCrossAxisExtent: 180.w,
          //                               mainAxisExtent: 160.h,
          //                               // childAspectRatio: 3 / 6,
          //                               // crossAxisSpacing: 3, // the space between them horizontally
          //                               // mainAxisSpacing: 3
          //                             ),
          //                             itemCount: countriesModel.items.length,
          //                             itemBuilder: (context , index){
          //                               return InkWell(
          //                                 onTap: (){
          //                                   mySetState((){
          //                                     selectedCountry = index;
          //                                     userModel.newUserCountryId = countriesModel.items[selectedCountry].id.toString();
          //                                   });
          //                                   setState(() {

          //                                   });

          //                                 },
          //                                 child: CountryBody(
          //                                   countries: countriesModel.items[index] ,
          //                                   selectedCountry: selectedCountry == index,
          //                                 ),
          //                               );
          //                             },
          //                           ),

          //                           20.ph,

          //                           Padding(
          //                             padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
          //                             child: CustomButtons(
          //                               height: 40.h,
          //                               text: allTranslations.text("save"),
          //                               isLoading : countriesModel.isSaving,
          //                               buttonColor:{userModel.userCountryId}.isNotEmpty
          //                                   ? Theme.of(context).secondaryHeaderColor
          //                                   : Colors.grey,
          //                               onTap: {userModel.userCountryId}.isNotEmpty
          //                                   ? () async{
          //                                 if(kDebugMode){
          //                                   print("Selected userCountryId = ${userModel.userCountryId}");
          //                                 }

          //                                 countriesModel.isSaving = true;

          //                                 try{
          //                                   await countriesModel.changeCountry(userModel.userCountryId.toString());
          //                                   countriesModel.saveCountryCode(
          //                                       initialCountry: countriesModel.items[selectedCountry].adminName.toString(),
          //                                       dialCode: countriesModel.items[selectedCountry].phone.toString(),
          //                                       countryId: countriesModel.items[selectedCountry].id.toString()
          //                                   );

          //                                   if(countriesModel.isLoaded){
          //                                     countriesModel.isSaving = false;
          //                                     Navigator.pop(context);
          //                                   }

          //                                   // if(kDebugMode){
          //                                   //   print("error changing country = ${userModel.userCountryId}");
          //                                   //   print("dial code = ${countriesModel.dialCode}");
          //                                   //   print("initialCountry = ${countriesModel.initialCountry}");
          //                                   // }
          //                                 }catch (error){
          //                                   if(kDebugMode){
          //                                     print("error changing country = $error");
          //                                   }
          //                                 }

          //                                 SharedPrefsService.putBool("hasShownDialog", false);
          //                                 await Provider.of<UserWalletModel>(context , listen: false).loadData(context);
          //                                 await Provider.of<CeilingPriceModel>(context , listen: false).loadData(context);
          //                                 await cartModel.deleteAll();
          //                                 await cartModel.loadData(context);
          //                                 await MaterialAppWithTheme.restartApp(context);
          //                               }
          //                                   : () {
          //                                 CustomToast.showFlutterToast(
          //                                     context: context,
          //                                     message: allTranslations.text("chooseCountryHintTxt")
          //                                 );
          //                               },
          //                             ),
          //                           )
          //                         ],
          //                       ),
          //                     );
          //                   },
          //                 );
          //               });

          //         }
          //     );
          //   } ,
          // ),

          // 15.ph,

          /// theme
          StatefulBuilder(
            builder: (context, mySetState) {
              return CustomCardIconText(
                icon: Icons.theater_comedy,
                iconColor: Colors.grey,
                itemsName: allTranslations.text("themeMode"),
                secondWidget: FlutterSwitch(
                    width: 60.0.w,
                    height: 30.0.h,
                    toggleSize: 35.0,
                    value: themeChange.darkTheme,
                    borderRadius: 30.0,
                    padding: 2.0,
                    inactiveIcon: const Icon(CupertinoIcons.sun_max),
                    activeIcon: const Icon(CupertinoIcons.moon),
                    toggleColor:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.5),

                    // switchBorder: Border.all(
                    //   color: const Color.fromRGBO(2, 107, 206, 1),
                    //   width: 6.0,
                    // ),
                    // toggleBorder: Border.all(
                    //   color: const Color.fromRGBO(2, 107, 206, 1),
                    //   width: 5.0,
                    // ),
                    activeColor: Theme.of(context).colorScheme.secondary,
                    inactiveColor: Theme.of(context).colorScheme.surface,
                    onToggle: (val) async {
                      mySetState(() {
                        themeChange.darkTheme = val;
                      });
                      await MaterialAppWithTheme.restartApp(context);
                      if (kDebugMode) {
                        print(val);
                      }
                    }),
                // onTap: () async{
                //   await LanguageBottomSheetService().showLanguageBottomSheet(context: context);
                // },
              );
            },
          ),

          15.ph,

          /// settings
          appModel.token == "visitor"
              ? 0.ph
              : CustomCardIconText(
                  icon: Icons.settings,
                  iconColor: Colors.grey,
                  itemsName: allTranslations.text("settings"),
                  secondIcon: Icons.arrow_forward_ios,
                  secondIconColor: Colors.grey,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsScreen()));
                  },
                ),

          15.ph,

          /// sign out
          appModel.token == "visitor"
              ? CustomCardIconText(
                  icon: Icons.login,
                  iconColor: Colors.grey,
                  itemsName: allTranslations.text("login"),
                  onTap: () async {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const AuthTabsScreen(),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                )
              : CustomCardIconText(
                  icon: Icons.logout,
                  iconColor: Colors.grey,
                  itemsName: allTranslations.text("signOut"),
                  onTap: () async {
                    await userModel.logout();
                    if (kDebugMode) {
                      print("toooken ${appModel.token}");
                    }
                    await cartModel.loadData();
                    await cartModel.deleteAll();
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const AuthTabsScreen(),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                ),

          // 15.ph,
          // // this widget for test
          // CustomCardIconText(
          //   icon: appModel.token == "visitor"
          //       ? Icons.login
          //       : Icons.logout,
          //   iconColor: Colors.grey,
          //   itemsName: "test",
          //   onTap: () async{
          //     pushScreen(context, const TestScreen());
          //   },
          // ),
        ],
      ),
    );
  }
}
