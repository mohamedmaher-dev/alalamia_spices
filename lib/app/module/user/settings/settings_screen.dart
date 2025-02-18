import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/user/settings/widget/transfer_to_merchant.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import '../../../alalamiah_app.dart';
import '../../../core/utils/constants.dart';
import '../../../global_widgets/country_body.dart';
import '../../app_config/app_config_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitched = false;
  int selectedLanguage = 1;
  Locale? currentLang;
  bool value1 = false;
  int selectedCountry = 0;
  String? newUserCountry;

  setSelectedRadioTile(int val) {
    setState(() {
      selectedLanguage = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeChange = Provider.of<ThemeModel>(context);
    var countriesModel = Provider.of<CountriesModel>(context);
    countriesModel.getCountriesList();
    countriesModel.getCountryDetails();
    var userModel = Provider.of<UserModel>(context);
    var cartModel = Provider.of<CartModel>(context);
    // var networkStatus = Provider.of<NetworkStatus>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
          child: const CustomAppBar(),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                allTranslations.text("settings"),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),

              20.ph,

              /// country
              // ChangeNotifierProvider(
              //   create: (context) => CountriesModel(context),
              //   child:  Consumer<CountriesModel> (
              //     builder: (context , countriesModel , child){

              //       return  CustomCardIconText(
              //           color: Theme.of(context).primaryColor,
              //           icon: Icons.language,
              //           iconColor: Colors.grey,
              //           height: 40.h,
              //           width: 45.w,
              //           itemsName: allTranslations.text("country"),
              //           // subItemsName: countryName ?? " ",
              //           itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
              //           secondIcon: Icons.arrow_forward_ios,
              //           secondIconColor: Colors.grey,
              //           onTap: () async {
              //             await showModalBottomSheet(
              //                 context: context,
              //                 elevation: 0.3,
              //                 isScrollControlled: true,
              //                 enableDrag: true,
              //                 shape:  RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.vertical(
              //                       top: Radius.circular(AppConstants.defaultBorderRadius.w)
              //                   ),
              //                 ),
              //                 builder: (context) {
              //                   return StatefulBuilder(
              //                     builder: (context , mySetState) {
              //                       return Padding(
              //                         padding: EdgeInsets.all(10.0.w),
              //                         child: ListView(
              //                           shrinkWrap: true,
              //                           primary: false,
              //                           children: [

              //                             BottomSheetHeader(
              //                                 title: allTranslations.text("country"),
              //                                 subTitle: allTranslations.text("countrySubTitle")
              //                             ),

              //                             countriesModel.isLoading || countriesModel.loadingFailed
              //                                 ? const CircularLoading()
              //                                 : GridView.builder(
              //                               shrinkWrap: true,
              //                               scrollDirection: Axis.vertical,
              //                               physics: const NeverScrollableScrollPhysics(),
              //                               gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
              //                                 maxCrossAxisExtent: 180.w,
              //                                 mainAxisExtent: 160.h,
              //                                 // childAspectRatio: 3 / 6,
              //                                 // crossAxisSpacing: 3, // the space between them horizontally
              //                                 // mainAxisSpacing: 3
              //                               ),
              //                               itemCount: countriesModel.items.length,
              //                               itemBuilder: (context , index){
              //                                 return InkWell(
              //                                   onTap: (){
              //                                     mySetState((){
              //                                       selectedCountry = index;
              //                                       userModel.newUserCountryId = countriesModel.items[selectedCountry].id.toString();
              //                                     });
              //                                     setState(() {

              //                                     });

              //                                   },
              //                                   child: CountryBody(
              //                                     countries: countriesModel.items[index] ,
              //                                     selectedCountry: selectedCountry == index,
              //                                   ),
              //                                 );
              //                               },
              //                             ),

              //                             20.ph,

              //                             Padding(
              //                               padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
              //                               child: CustomButtons(
              //                                 height: 40.h,
              //                                 text: allTranslations.text("save"),
              //                                 isLoading : countriesModel.isSaving,
              //                                 buttonColor:{userModel.userCountryId}.isNotEmpty
              //                                     ? Theme.of(context).secondaryHeaderColor
              //                                     : Colors.grey,
              //                                 onTap: {userModel.userCountryId}.isNotEmpty
              //                                     ? () async{
              //                                   if(kDebugMode){
              //                                     print("Selected userCountryId = ${userModel.userCountryId}");
              //                                   }

              //                                   countriesModel.isSaving = true;

              //                                   try{
              //                                     await countriesModel.changeCountry(userModel.userCountryId.toString());
              //                                     countriesModel.saveCountryCode(
              //                                         initialCountry: countriesModel.items[selectedCountry].adminName.toString(),
              //                                         dialCode: countriesModel.items[selectedCountry].phone.toString(),
              //                                         countryId: countriesModel.items[selectedCountry].id.toString()
              //                                     );

              //                                     if(countriesModel.isLoaded){
              //                                       countriesModel.isSaving = false;
              //                                       Navigator.pop(context);
              //                                     }

              //                                     // if(kDebugMode){
              //                                     //   print("error changing country = ${userModel.userCountryId}");
              //                                     //   print("dial code = ${countriesModel.dialCode}");
              //                                     //   print("initialCountry = ${countriesModel.initialCountry}");
              //                                     // }
              //                                   }catch (error){
              //                                     if(kDebugMode){
              //                                       print("error changing country = $error");
              //                                     }
              //                                   }

              //                                   SharedPrefsService.putBool("hasShownDialog", false);
              //                                   await Provider.of<UserWalletModel>(context , listen: false).loadData(context);
              //                                   await Provider.of<CeilingPriceModel>(context , listen: false).loadData(context);
              //                                   await cartModel.deleteAll();
              //                                   await cartModel.loadData(context);
              //                                   await MaterialAppWithTheme.restartApp(context);
              //                                 }
              //                                     : () {
              //                                   CustomToast.showFlutterToast(
              //                                       context: context,
              //                                       message: allTranslations.text("chooseCountryHintTxt")
              //                                   );
              //                                 },
              //                               ),
              //                             )
              //                           ],
              //                         ),
              //                       );
              //                     },
              //                   );
              //                 });

              //           }
              //       );
              //     },
              //   ),
              // ),

              // 20.ph,

              /// language
              CustomCardIconText(
                  color: Theme.of(context).primaryColor,
                  icon: Icons.sign_language_rounded,
                  iconColor: Colors.grey,
                  height: 40.h,
                  width: 45.w,
                  itemsName: allTranslations.text("language"),
                  subItemsName: allTranslations.currentLanguage == "ar"
                      ? "العربية"
                      : "English",
                  itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
                  secondIcon: Icons.arrow_forward_ios,
                  secondIconColor: Colors.grey,
                  onTap: () async {
                    await LanguageBottomSheet()
                        .showLanguageBottomSheet(context: context);
                  }),

              20.ph,

              /// theme mode
              CustomCardIconText(
                  color: Theme.of(context).primaryColor,
                  icon: Icons.theater_comedy,
                  iconColor: Colors.grey,
                  height: 40.h,
                  width: 45.w,
                  itemsName: allTranslations.text("themeMode"),
                  itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
                  secondWidget: FlutterSwitch(
                      width: 60.0.w,
                      height: 30.0.h,
                      toggleSize: 35.0,
                      value: themeChange.darkTheme,
                      borderRadius: 30.0,
                      padding: 2.0,
                      inactiveIcon: const Icon(CupertinoIcons.sun_max),
                      activeIcon: const Icon(CupertinoIcons.moon),
                      toggleColor: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.5),

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
                      onToggle: (val) {
                        setState(() {
                          themeChange.darkTheme = val;
                        });
                        MaterialAppWithTheme.restartApp(context);
                        print(val);
                      })),

              20.ph,

              /// transfer request to a merchant
              const TransferToMerchant()
            ],
          ),
        ),
      ),
    );
  }

  /// country old work
  // countriesModel.isLoading || countriesModel.loadingFailed
  // ? const CircularLoading()
  //     : appModel.token == "visitor"
  // ? StatefulBuilder(
  // builder: (context , mySetState){
  // return CustomCardIconText(
  // color: Theme.of(context).primaryColor,
  // icon: Icons.language,
  // iconColor: Colors.grey,
  // height: 40.h,
  // width: 45.w,
  // itemsName: allTranslations.text("country"),
  // subItemsName: chosenCountry  ,
  // itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
  // secondIcon: Icons.arrow_forward_ios,
  // secondIconColor: Colors.grey,
  // onTap: () async{
  // await showModalBottomSheet(
  // context: context,
  // elevation: 0.3,
  // isScrollControlled: true,
  // enableDrag: true,
  // shape: const RoundedRectangleBorder(
  // borderRadius: BorderRadius.vertical(
  // top: Radius.circular(AppConstants.defaultBorderRadius.w)
  // ),
  // ),
  // builder: (context) {
  // return StatefulBuilder(
  // builder: (context , mySetState) {
  // return Padding(
  // padding: EdgeInsets.all(10.0.w),
  // child: Wrap(
  // // spacing: 20.h,
  // crossAxisAlignment: WrapCrossAlignment.start,
  // runSpacing: 10.0.h,
  // runAlignment: WrapAlignment.spaceBetween,
  // children: [
  // Padding(
  // padding: const EdgeInsets.only(top: 10.0.w),
  // child: CustomTowText(
  // title: allTranslations.text("country"),
  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  // titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
  // fontWeight: FontWeight.bold,
  // fontSize: 22.sp
  //
  // ),
  // subWidget: Padding(
  // padding:  EdgeInsets.symmetric(horizontal: 5.0.w),
  // child: InkWell(
  // onTap: (){
  // Navigator.of(context).pop();
  // },
  // child: Icon(
  // Icons.close,
  // size: 30,
  // color: Theme.of(context).secondaryHeaderColor,
  // ),
  // ),
  // ),
  // ),
  // ),
  // 3.ph,
  // Text(
  // allTranslations.text("countrySubTitle"),
  // style: Theme.of(context).textTheme.caption!.copyWith(
  // fontWeight: FontWeight.bold
  // ),
  // ),
  // 20.ph,
  //
  // countriesModel.isLoading || countriesModel.loadingFailed
  // ? const CircularLoading()
  //     : CustomDropDown(
  // listItem: countriesModel.countriesItems,
  // value: currentCountry,
  // hintText: allTranslations.text("chooseCountryHintTxt"),
  // onChanged: (value){
  // mySetState((){
  // chosenCountry = value;
  // currentCountry = value;
  // });
  // setState(() {
  //
  // });
  //
  // for(var i = 0; i < countriesModel.items.length; i++ ){
  // if(chosenCountry == countriesModel.items[i].name){
  // mySetState(() {
  // countryId = countriesModel.items[i].id.toString();
  // });
  // setState(() {
  //
  // });
  //
  // }
  // }
  //
  // if (kDebugMode) {
  // print("chosen country $chosenCountry = $countryId");
  // }
  // }
  // ),
  //
  // 20.ph,
  //
  // CustomButtons(
  // height: 40.h,
  // text: allTranslations.text("save"),
  // buttonColor: chosenCountry!.isNotEmpty
  // ? Theme.of(context).secondaryHeaderColor
  //     : Colors.grey,
  // onTap: chosenCountry!.isNotEmpty
  // ? () async{
  // if(kDebugMode){
  // print("Selected Country id = $countryId");
  // }
  // await AlalmiaApp.restartApp(context);
  //
  //
  // }
  //     : () {
  // CustomToast.showFlutterToast(
  // context: context,
  // message: allTranslations.text("chooseCountryHintTxt")
  // );
  // },
  // )
  // ],
  // ),
  // );
  // },
  // );
  // });
  //
  // }
  // );
  // } ,
  // )
  //     : StatefulBuilder(
  // builder: (context , mySetState){
  // return CustomCardIconText(
  // color: Theme.of(context).primaryColor,
  // icon: Icons.language,
  // iconColor: Colors.grey,
  // height: 40.h,
  // width: 45.w,
  // itemsName: allTranslations.text("country"),
  // subItemsName: currentCountry  ,
  // itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
  // secondIcon: Icons.arrow_forward_ios,
  // secondIconColor: Colors.grey,
  // onTap: () async{
  // await showModalBottomSheet(
  // context: context,
  // elevation: 0.3,
  // isScrollControlled: true,
  // enableDrag: true,
  // shape: const RoundedRectangleBorder(
  // borderRadius: BorderRadius.vertical(
  // top: Radius.circular(AppConstants.defaultBorderRadius.w)
  // ),
  // ),
  // builder: (context) {
  // return StatefulBuilder(
  // builder: (context , mySetState) {
  // return Padding(
  // padding: EdgeInsets.all(10.0.w),
  // child: Wrap(
  // // spacing: 20.h,
  // crossAxisAlignment: WrapCrossAlignment.start,
  // runSpacing: 10.0.h,
  // runAlignment: WrapAlignment.spaceBetween,
  // children: [
  // Padding(
  // padding: const EdgeInsets.only(top: 10.0.w),
  // child: CustomTowText(
  // title: allTranslations.text("country"),
  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  // titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
  // fontWeight: FontWeight.bold,
  // fontSize: 22.sp
  //
  // ),
  // subWidget: Padding(
  // padding:  EdgeInsets.symmetric(horizontal: 5.0.w),
  // child: InkWell(
  // onTap: (){
  // Navigator.of(context).pop();
  // },
  // child: Icon(
  // Icons.close,
  // size: 30,
  // color: Theme.of(context).secondaryHeaderColor,
  // ),
  // ),
  // ),
  // ),
  // ),
  // 3.ph,
  // Text(
  // allTranslations.text("countrySubTitle"),
  // style: Theme.of(context).textTheme.caption!.copyWith(
  // fontWeight: FontWeight.bold
  // ),
  // ),
  // 20.ph,
  //
  // countriesModel.isLoading || countriesModel.loadingFailed
  // ? const CircularLoading()
  //     : CustomDropDown(
  // listItem: countriesModel.countriesItems,
  // value: currentCountry,
  // hintText: allTranslations.text("chooseCountryHintTxt"),
  // onChanged: (value){
  // mySetState((){
  // // chosenCountry = value;
  // currentCountry = value;
  // });
  // setState(() {
  //
  // });
  //
  // for(var i = 0; i < countriesModel.items.length; i++ ){
  // if(currentCountry == countriesModel.items[i].name){
  // mySetState(() {
  // userCountryId = countriesModel.items[i].id.toString();
  // });
  // setState(() {
  //
  // });
  //
  // }
  // }
  //
  // if (kDebugMode) {
  // print("chosen country $currentCountry = $userCountryId");
  // }
  // }
  // ),
  //
  // 20.ph,
  //
  // CustomButtons(
  // height: 40.h,
  // text: allTranslations.text("save"),
  // buttonColor: currentCountry.isNotEmpty
  // ? Theme.of(context).secondaryHeaderColor
  //     : Colors.grey,
  // onTap: currentCountry.isNotEmpty
  // ? () async{
  // if(kDebugMode){
  // print("Selected userCountryId = $userCountryId");
  // }
  //
  // try{
  // await countriesModel.changeCountry("12");
  // }catch (error){
  // if(kDebugMode){
  // print("error changing country = $error");
  // }
  // }
  //
  // await AlalmiaApp.restartApp(context);
  //
  //
  // }
  //     : () {
  // CustomToast.showFlutterToast(
  // context: context,
  // message: allTranslations.text("chooseCountryHintTxt")
  // );
  // },
  // )
  // ],
  // ),
  // );
  // },
  // );
  // });
  //
  // }
  // );
  // } ,
  // ),
}
