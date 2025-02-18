

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/bill/external_order_bill.dart';
import 'package:alalamia_spices/app/module/user/last_orders/last_order_details/last_order_details_screen.dart';
import 'package:alalamia_spices/app/module/user/last_orders/widget/last_orders_card.dart';
import 'package:alalamia_spices/app/module/user/last_orders/widget/last_orders_shimmer.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';


class LastOrdersScreen extends StatelessWidget {
  final bool isFromBill;
  const LastOrdersScreen({
    Key? key,
    this.isFromBill = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RequestModel(context))
      ],
      child:  SubLastOrdersScreen(isFromBill: isFromBill),
    );
  }
}


class SubLastOrdersScreen extends StatefulWidget {
  final bool isFromBill;
  const SubLastOrdersScreen({
    Key? key, this.isFromBill = false,
  }) : super(key: key);

  @override
  State<SubLastOrdersScreen> createState() => _SubLastOrdersScreenState();
}

class _SubLastOrdersScreenState extends State<SubLastOrdersScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =  GlobalKey<RefreshIndicatorState>();

  Future<void> _handleRefresh () async{
    _refreshIndicatorKey.currentState?.show();
    _scaffoldKey.currentState!.context;
    return await Future.delayed(const Duration(seconds: 2), () {
      Provider.of<RequestModel>(context , listen: false).loadData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<RequestModel>(context);
    var cartModel = Provider.of<CartModel>(context);

    if(cartModel.items.length > 0 && widget.isFromBill == true){
      setState(() {
        cartModel.deleteAll();
        cartModel.loadData();
      });
    }


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
          child: Padding(
            padding:   EdgeInsets.all(5.0.w),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: Text(
                    allTranslations.text("myLastOrders"),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.sp
                    ),
                  ),
                ),
                3.ph,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: Text(
                    allTranslations.text("myLastOrdersSubTitle"),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                10.ph,
                model.isLoading || model.loadingFailed
                    ?  const Flexible(child: LastOrdersShimmer())
                    : Flexible(
                  child: model.items.isEmpty
                      ? Center(
                    child: CustomMessage(
                      message: allTranslations.text("noData"),
                      appLottieIcon: AppLottie.noData,
                    ),
                  )
                      : ListView.builder(
                    itemCount: model.items.length,
                    itemBuilder: (context , index){
                      // if (kDebugMode) {
                      //   print("order status ${model.items[0].status}");
                      //   print("order delivery price ${model.items[0].deliveryPricing}");
                      //   print("order receivingType ${model.items[0].receivingType}");
                      // }
                      return  InkWell(
                          onTap: () async{
                            if((model.items[index].receivingType == "external"
                                && model.items[index].deliveryPricing == "0.00"
                                && (model.items[index].status == "requested"))
                                || (model.items[index].receivingType == "urgent"
                                    && model.items[index].deliveryPricing == "0.00"
                                    && (model.items[index].status == "requested"))
                               ){

                             CustomDialog.showCustomDialog(
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
                             );


                            } else if ((model.items[index].receivingType == "external"
                                 && model.items[index].deliveryPricing != "0.00"
                                && (model.items[index].status == "requested"))
                                || (model.items[index].receivingType == "urgent"
                                    && model.items[index].deliveryPricing != "0.00"
                                    && (model.items[index].status == "requested"))
                                    ){
                              Navigator.push(
                                  context,
                                MaterialPageRoute(
                                    builder: (context) =>  ExternalOrderBill(
                                  // isFromLastOrderScreen: true,
                                  request: model.items[index],


                                ))
                              );
                            } else if ( (model.items[index].receivingType == "external"
                                && model.items[index].deliveryPricing == "0.00"
                                && (model.items[index].status == "canceled"))
                                || (model.items[index].receivingType == "urgent"
                                    && model.items[index].deliveryPricing == "0.00"
                                    && (model.items[index].status == "canceled"))

                            ){
                              CustomDialog.showCustomDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  title: "${allTranslations.text("requestNotApproved")}  😕",
                                  icon: Lottie.asset(
                                    AppLottie.error,
                                    width: 100.w,
                                    height: 100.h,
                                    repeat: false,
                                  ),
                                  withActions: true,
                                  withYesButton: true,
                                  onPressed: () {
                                    CustomDialog.hideCustomDialog(context);
                                  }
                              );
                            }
                            else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  LastOrdersDetailsScreen(
                                        request:  model.items[index],
                                      )
                                  )
                              );
                            }

                          },
                          child:  LastOrdersCard(
                            request:  model.items[index],
                          ));
                    },
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
