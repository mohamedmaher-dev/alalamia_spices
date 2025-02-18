
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:alalamia_spices/app/module/user/last_orders/widget/last_orders_shimmer.dart';
import 'package:alalamia_spices/app/module/user/special_orders/create_special_order.dart';
import 'package:alalamia_spices/app/module/user/special_orders/special_order_details.dart';
import 'package:alalamia_spices/app/module/user/special_orders/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import '../../../services/screen_navigation_service.dart';
import 'package:alalamia_spices/app/exports/widget.dart';

class MySpecialOrdersScreen extends StatelessWidget {
  const MySpecialOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SpecialOrderModel(context),)
      ],
      child:  const SubSpecialOrdersScreen(),
    );
  }
}


class SubSpecialOrdersScreen extends StatefulWidget {
  const SubSpecialOrdersScreen({Key? key}) : super(key: key);

  @override
  State<SubSpecialOrdersScreen> createState() => _SubSpecialOrdersScreenState();
}

class _SubSpecialOrdersScreenState extends State<SubSpecialOrdersScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =  GlobalKey<RefreshIndicatorState>();

  Future<void> _handleRefresh () async {
    _refreshIndicatorKey.currentState?.show();
    return await Future.delayed(const Duration(seconds: 2), () {
      Provider.of<SpecialOrderModel>(context , listen: false).loadData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SpecialOrderModel>(
      create: (context) => SpecialOrderModel(context),
      child: Consumer<SpecialOrderModel>(
        builder: (context , model , child){
          return SafeArea(
            child: Scaffold(
                key: _scaffoldKey,
                backgroundColor: Theme.of(context).colorScheme.surface,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                  child:  const CustomAppBar(),
                ),
                body: LiquidPullToRefresh(
                  key: _refreshIndicatorKey,
                  onRefresh: _handleRefresh,
                  height: 100.h,
                  animSpeedFactor: 2,
                  showChildOpacityTransition: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.w , vertical: 10.h),
                        child: Text(
                          allTranslations.text("mySpecialOrders"),
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.sp
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          pushScreenReplacement(context, const CreateSpecialOrder());
                        },
                        child: Padding(
                          padding:  EdgeInsets.only( left: 10.0.w , right: 10.0.w ,bottom: 5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                allTranslations.text("createSpecialOrder"),
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
                              )
                            ],
                          ),
                        ),
                      ),

                      model.isLoading || model.loadingFailed
                          ? const Flexible(child:  LastOrdersShimmer())
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
                            return InkWell(
                                onTap: () async{
                                  model.items[index].price == null
                                  ? CustomDialog.showCustomDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      title:  allTranslations.text("orderStatus"),
                                      description: Text(
                                        allTranslations.text("externalOrderMessage"),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      withActions: true,
                                      withYesButton: true,
                                      onPressed: () {
                                        CustomDialog.hideCustomDialog(context);
                                      }
                                  )

                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SpecialOrderDetails(
                                                specialOrder: model.items[index],
                                              )
                                      )
                                  );
                                },
                                child:  MySpecialOrdersCard(
                                  specialOrder: model.items[index],
                                ));
                          },
                        ),
                      )





                    ],
                  ),
                )
            ),
          );
        },
      ),
    );
  }
}
