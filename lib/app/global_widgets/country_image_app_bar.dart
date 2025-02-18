import 'package:alalamia_spices/app/module/app_config/app_config_screen.dart';
import 'package:flutter/material.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../alalamiah_app.dart';
import '../core/utils/constants.dart';
import 'package:alalamia_spices/app/exports/services.dart';

class CountryImageAppBar extends StatefulWidget {
  const CountryImageAppBar({super.key});

  @override
  State<CountryImageAppBar> createState() => _CountryImageAppBarState();
}

class _CountryImageAppBarState extends State<CountryImageAppBar> {
  int selectedCountry = -1;

  String? newUserCountry;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    var countriesModel = Provider.of<CountriesModel>(context);
    countriesModel.getCountryCode();
    countriesModel.getCountryDetails();
    var cartModel = Provider.of<CartModel>(context);
    return ChangeNotifierProvider<ConnectivityNotifier>(
      create: (context) => ConnectivityNotifier(),
      child: Consumer<ConnectivityNotifier>(
        builder: (context, connection, model) {
          userModel.getUserInfo();
          return countriesModel.isLoading || countriesModel.loadingFailed
              ? const CircularLoading()
              : appModel.token == 'visitor'
                  ? InkWell(
                      onTap: () async {
                        // await showModalBottomSheet(
                        //     context: context,
                        //     elevation: 0.3,
                        //     isScrollControlled: true,
                        //     enableDrag: true,
                        //     shape:  RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.vertical(
                        //           top: Radius.circular(AppConstants.defaultBorderRadius.w)
                        //       ),
                        //     ),
                        //     builder: (context) {
                        //       return StatefulBuilder(
                        //         builder: (context , mySetState) {
                        //           return Padding(
                        //             padding: EdgeInsets.all(10.0.w),
                        //             child: ListView(
                        //               shrinkWrap: true,
                        //               primary: false,
                        //               children: [
                        //                 BottomSheetHeader(
                        //                     title: allTranslations.text("country"),
                        //                     subTitle: allTranslations.text("countrySubTitle")
                        //                 ),

                        //                 countriesModel.isLoading || countriesModel.loadingFailed
                        //                     ? const CircularLoading()
                        //                     : GridView.builder(
                        //                   shrinkWrap: true,
                        //                   scrollDirection: Axis.vertical,
                        //                   physics: const NeverScrollableScrollPhysics(),
                        //                   gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                        //                     maxCrossAxisExtent: 180.w,
                        //                     mainAxisExtent: 160.h,
                        //                     // childAspectRatio: 3 / 6,
                        //                     // crossAxisSpacing: 3, // the space between them horizontally
                        //                     // mainAxisSpacing: 3
                        //                   ),
                        //                   itemCount: countriesModel.items.length,
                        //                   itemBuilder: (context , index){
                        //                     return InkWell(
                        //                       onTap: (){
                        //                         mySetState((){
                        //                           selectedCountry = index;
                        //                           countryName = countriesModel.items[selectedCountry].name.toString();
                        //                           countryId = countriesModel.items[selectedCountry].id.toString();
                        //                           countryImage = countriesModel.items[selectedCountry].imagePath.toString();                                      });
                        //                         setState(() {

                        //                         });

                        //                       },
                        //                       child: CountryBody(countries: countriesModel.items[index] , selectedCountry: selectedCountry == index,),
                        //                     );
                        //                   },
                        //                 ),

                        //                 20.ph,

                        //                 Padding(
                        //                   padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
                        //                   child: CustomButtons(
                        //                     height: 40.h,
                        //                     text: allTranslations.text("save"),
                        //                     buttonColor:{userModel.userCountryId}.isNotEmpty
                        //                         ? Theme.of(context).secondaryHeaderColor
                        //                         : Colors.grey,
                        //                     onTap: () async{
                        //                       setState(()  {

                        //                         countriesModel.saveCountryDetails(
                        //                             id: countryId.toString(),
                        //                             name: countryName.toString(),
                        //                             image: countryImage.toString()
                        //                         );
                        //                         countriesModel.saveCountryCode(
                        //                             initialCountry: countriesModel.items[selectedCountry].adminName.toString(),
                        //                             dialCode: countriesModel.items[selectedCountry].phone.toString(),
                        //                             countryId: countriesModel.items[selectedCountry].id.toString()
                        //                         );
                        //                       });
                        //                       SharedPrefsService.putBool("hasShownDialog", false);
                        //                       await Provider.of<UserWalletModel>(context , listen: false).loadData(context);
                        //                       await Provider.of<CeilingPriceModel>(context , listen: false).loadData(context);
                        //                       await cartModel.deleteAll();
                        //                       await cartModel.loadData(context);
                        //                       await MaterialAppWithTheme.restartApp(context);
                        //                     }
                        //                   ),
                        //                 )
                        //               ],
                        //             ),
                        //           );
                        //         },
                        //       );
                        //     });
                      },
                      child: SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(500.h),
                          child: CustomCachedNetworkImage(
                            imageUrl: countryImage.toString() ?? "",
                            width: 20.w,
                            height: 20.h,
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () async {
                        if (connection.hasConnection) {
                          // await showModalBottomSheet(
                          //     context: context,
                          //     elevation: 0.3,
                          //     isScrollControlled: true,
                          //     enableDrag: true,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.vertical(
                          //           top: Radius.circular(
                          //               AppConstants.defaultBorderRadius.w)),
                          //     ),
                          //     builder: (context) {
                          //       return StatefulBuilder(
                          //         builder: (context, mySetState) {
                          //           return Padding(
                          //             padding: EdgeInsets.all(10.0.w),
                          //             child: ListView(
                          //               shrinkWrap: true,
                          //               primary: false,
                          //               children: [
                          //                 BottomSheetHeader(
                          //                     title: allTranslations
                          //                         .text("country"),
                          //                     subTitle: allTranslations
                          //                         .text("countrySubTitle")),
                          //                 countriesModel.isLoading ||
                          //                         countriesModel.loadingFailed
                          //                     ? const CircularLoading()
                          //                     : GridView.builder(
                          //                         shrinkWrap: true,
                          //                         scrollDirection:
                          //                             Axis.vertical,
                          //                         physics:
                          //                             const NeverScrollableScrollPhysics(),
                          //                         gridDelegate:
                          //                             SliverGridDelegateWithMaxCrossAxisExtent(
                          //                           maxCrossAxisExtent: 180.w,
                          //                           mainAxisExtent: 160.h,
                          //                           // childAspectRatio: 3 / 6,
                          //                           // crossAxisSpacing: 3, // the space between them horizontally
                          //                           // mainAxisSpacing: 3
                          //                         ),
                          //                         itemCount: countriesModel
                          //                             .items.length,
                          //                         itemBuilder:
                          //                             (context, index) {
                          //                           return InkWell(
                          //                             onTap: () {
                          //                               mySetState(() {
                          //                                 selectedCountry =
                          //                                     index;
                          //                                 userModel
                          //                                         .newUserCountryId =
                          //                                     countriesModel
                          //                                         .items[
                          //                                             selectedCountry]
                          //                                         .id
                          //                                         .toString();
                          //                               });
                          //                               setState(() {});
                          //                             },
                          //                             child: CountryBody(
                          //                               countries:
                          //                                   countriesModel
                          //                                       .items[index],
                          //                               selectedCountry:
                          //                                   selectedCountry ==
                          //                                       index,
                          //                             ),
                          //                           );
                          //                         },
                          //                       ),
                          //                 20.ph,
                          //                 Padding(
                          //                   padding: EdgeInsets.symmetric(
                          //                       horizontal: 10.0.w),
                          //                   child: CustomButtons(
                          //                     height: 40.h,
                          //                     text:
                          //                         allTranslations.text("save"),
                          //                     isLoading:
                          //                         countriesModel.isSaving,
                          //                     buttonColor: {
                          //                       userModel.userCountryId
                          //                     }.isNotEmpty
                          //                         ? Theme.of(context)
                          //                             .secondaryHeaderColor
                          //                         : Colors.grey,
                          //                     onTap: {userModel.userCountryId}
                          //                             .isNotEmpty
                          //                         ? () async {
                          //                             if (kDebugMode) {
                          //                               print(
                          //                                   "Selected userCountryId = ${userModel.userCountryId}");
                          //                             }

                          //                             countriesModel.isSaving =
                          //                                 true;

                          //                             try {
                          //                               await countriesModel
                          //                                   .changeCountry(
                          //                                       userModel
                          //                                           .userCountryId
                          //                                           .toString());
                          //                               countriesModel.saveCountryCode(
                          //                                   initialCountry:
                          //                                       countriesModel
                          //                                           .items[
                          //                                               selectedCountry]
                          //                                           .adminName
                          //                                           .toString(),
                          //                                   dialCode: countriesModel
                          //                                       .items[
                          //                                           selectedCountry]
                          //                                       .phone
                          //                                       .toString(),
                          //                                   countryId: countriesModel
                          //                                       .items[
                          //                                           selectedCountry]
                          //                                       .id
                          //                                       .toString());

                          //                               if (countriesModel
                          //                                   .isLoaded) {
                          //                                 countriesModel
                          //                                     .isSaving = false;
                          //                                 Navigator.pop(
                          //                                     context);
                          //                               }

                          //                               // if(kDebugMode){
                          //                               //   print("error changing country = ${userModel.userCountryId}");
                          //                               //   print("dial code = ${countriesModel.dialCode}");
                          //                               //   print("initialCountry = ${countriesModel.initialCountry}");
                          //                               // }
                          //                             } catch (error) {
                          //                               if (kDebugMode) {
                          //                                 print(
                          //                                     "error changing country = $error");
                          //                               }
                          //                             }

                          //                             SharedPrefsService
                          //                                 .putBool(
                          //                                     "hasShownDialog",
                          //                                     false);
                          //                             await Provider.of<
                          //                                         UserWalletModel>(
                          //                                     context,
                          //                                     listen: false)
                          //                                 .loadData(context);
                          //                             await Provider.of<
                          //                                         CeilingPriceModel>(
                          //                                     context,
                          //                                     listen: false)
                          //                                 .loadData(context);
                          //                             await cartModel
                          //                                 .deleteAll();
                          //                             await cartModel
                          //                                 .loadData(context);
                          //                             await MaterialAppWithTheme
                          //                                 .restartApp(context);
                          //                           }
                          //                         : () {
                          //                             CustomToast.showFlutterToast(
                          //                                 context: context,
                          //                                 message: allTranslations
                          //                                     .text(
                          //                                         "chooseCountryHintTxt"));
                          //                           },
                          //                   ),
                          //                 )
                          //               ],
                          //             ),
                          //           );
                          //         },
                          //       );
                          //     });
                        } else {
                          CustomToast.showFlutterToast(
                            context: context,
                            message: allTranslations.text("networkConnection"),
                            toastLength: Toast.LENGTH_LONG,
                          );
                        }
                      },
                      child: SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(500.h),
                          child: CustomCachedNetworkImage(
                            imageUrl: userModel.countryImage.toString(),
                            width: 20.w,
                            height: 20.h,
                          ),
                        ),
                      ),
                    );
        },
      ),
    );
  }
}
