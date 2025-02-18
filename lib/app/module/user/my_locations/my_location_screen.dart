import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/user/my_locations/widget/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import '../last_orders/widget/last_orders_shimmer.dart';
import 'package:alalamia_spices/app/exports/provider.dart';


class MyLocationsScreen extends StatefulWidget {
  const MyLocationsScreen({Key? key}) : super(key: key);

  @override
  State<MyLocationsScreen> createState() => _MyLocationsScreenState();
}

class _MyLocationsScreenState extends State<MyLocationsScreen> {
  bool checkedValue = false;
  int optionalValue = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocationModel(context),
      child: Consumer<LocationModel>(
        builder: (context , model , child) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.surface,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                  child:  const CustomAppBar(),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.w , vertical: 10.h),
                      child: Text(
                        allTranslations.text("myLocations"),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp
                        ),
                      ),
                    ),

                    /// add new location
                    Padding(
                      padding:  EdgeInsets.only(left: 10.0.w , right: 10.0.w ,bottom: 5.h),
                      child: InkWell(
                        onTap: (){
                          // determinePosition();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) =>  const AddNewLocationScreen(
                                isFromCheckOut: false,
                              ))
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              allTranslations.text("addNewLocation"),
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp
                              ),
                            ),

                            15.pw,
                            Container(
                              height: 25.h,
                              width: 25.w,
                              padding:  EdgeInsets.all(5.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Container(
                                height: 10.h,
                                width: 10.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Theme.of(context).primaryColor,
                                  size: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    model.isLoading || model.loadingFailed
                        ? const Flexible(child: LastOrdersShimmer())
                        : Flexible(
                      child: model.items.isEmpty
                          ? Center(
                        child: CustomMessage(
                          message: allTranslations.text("noData"),
                          appLottieIcon: AppLottie.noData,
                          repeat: false,
                        ),
                      )
                          : ListView.builder(
                        itemCount: model.items.length,
                        itemBuilder: (context , index){
                          return  Stack(
                            children: [
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 10.w , vertical: 10.h),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 100.h,
                                  padding:  EdgeInsets.all(10.0.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                    color: model.items[index].location == 1
                                        ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                                        : Theme.of(context).primaryColor,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [


                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                          "${allTranslations.text("locationTitle")}: ",
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.bold
                                          ),
                                          ),
                                          SizedBox(
                                            width: 230.w,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Column(
                                                children: [
                                                  Text(
                                                      model.items[index].name.toString(),
                                                      maxLines: 1,
                                                      textAlign: TextAlign.right,
                                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                          fontFamily: "cairo"
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      10.ph,

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${allTranslations.text("detail")}: ",
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          SizedBox(
                                            width: 230.w,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Column(
                                                children: [
                                                  Text(
                                                      "${model.items[index].desc}",
                                                      maxLines: 1,
                                                      textAlign: TextAlign.right,
                                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                          fontFamily: "cairo"
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),



                                      StatefulBuilder(
                                        builder: (context , mySetState){
                                          return Builder(
                                              builder: (context) {
                                                return Expanded(
                                                  flex: 2,
                                                  child: CheckboxListTile(
                                                    dense: true,
                                                    contentPadding: EdgeInsets.all(0.h),
                                                    title: Text(
                                                      allTranslations.text("default"),
                                                      style: Theme.of(context).textTheme.bodySmall,
                                                    ),
                                                    value: model.items[index].location == 1
                                                        ? true
                                                        : false,
                                                    checkboxShape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                                    ),
                                                    onChanged: (newValue) async{
                                                      CustomDialog.showCustomDialog(
                                                          context: context,
                                                          barrierDismissible: false,
                                                        title: allTranslations.text("changeDefaultLocation"),
                                                        withActions: true,
                                                        withYesButton: true,
                                                        withNoButton: true,
                                                        onPressed: () {


                                                          model.changeDefaultLocation(locationId: model.items[index].id);
                                                          model.loadData();
                                                          CustomDialog.hideCustomDialog(context);

                                                            debugPrint("optional =  $optionalValue");

                                                          // if(mounted) return;

                                                        },
                                                      );
                                                    },
                                                    controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                                  ),
                                                );
                                              }
                                          );
                                        },
                                      ),


                                    ],
                                  ),
                                ),
                              ),



                              /// edite location
                              Positioned(
                                top: 10.h,
                                left: allTranslations.currentLanguage == "ar" ? 3 : null,
                                right: allTranslations.currentLanguage == "en" ? 3 : null,
                                child: InkWell(
                                  onTap: () {
                                    pushScreen(context,  EditeLocationScreen(
                                      locations: model.items[index],
                                    )
                                    );
                                  },
                                  child: Card(
                                    elevation: 0.5,
                                    child: Container(
                                      height: 30.h,
                                      width: 30.w,
                                      padding:  EdgeInsets.all(5.w),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Container(
                                        height: 10.h,
                                        width: 10.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                        child: Icon(
                                          Icons.edit,
                                          color: Theme.of(context).primaryColor,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),


                              /// delete location
                              Positioned(
                                top: 70.h,
                                left: allTranslations.currentLanguage == "ar" ? 3 : null,
                                right: allTranslations.currentLanguage == "en" ? 3 : null,
                                child: InkWell(
                                  onTap: () {
                                    CustomDialog.showCustomDialog(
                                        context: context,
                                        barrierDismissible: false,
                                      title: allTranslations.text("confirmDeletion"),
                                      withYesButton: true,
                                      withNoButton: true,
                                      withActions: true,
                                      onPressed: () async{
                                        model.errors.clear();
                                        await model.delete(
                                          model.items[index],
                                          model.items[index].id.toString(),

                                        );
                                        model.loadData();
                                        CustomDialog.hideCustomDialog(context);

                                      },
                                    );
                                  },
                                  child: Card(
                                    elevation: 0.5,
                                    child: Container(
                                      height: 30.h,
                                      width: 30.w,
                                      padding:  EdgeInsets.all(5.w),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Container(
                                        height: 10.h,
                                        width: 10.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                        child: Icon(
                                          Icons.delete,
                                          color: Theme.of(context).primaryColor,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );

                        },
                      ),
                    ),
                  ],
                )
            ),
          );
        },
      ),
    );
  }
}
