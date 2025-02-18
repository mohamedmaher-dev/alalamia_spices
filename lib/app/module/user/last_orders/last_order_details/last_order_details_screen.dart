import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/user/last_orders/last_order_details/widget/order_content.dart';
import 'package:alalamia_spices/app/module/user/last_orders/last_order_details/widget/order_tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/values/app_lottie.dart';
import '../../../../data/model/request.dart';


String status = "";
int rated = 0;
int? carrierId;


class LastOrdersDetailsScreen extends StatelessWidget {
  final Request request;
  const LastOrdersDetailsScreen({
    Key? key,
    required this.request
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListenToRequestStatusModel(context, request.requestId.toString()),
      child: SubLastOrdersDetailsScreen(
        request: request,
      ),
    );
  }
}


class SubLastOrdersDetailsScreen extends StatefulWidget {
  final Request request;
  const SubLastOrdersDetailsScreen({
    Key? key,
    required this.request
  }) : super(key: key);

  @override
  State<SubLastOrdersDetailsScreen> createState() => _SubLastOrdersDetailsScreenState();
}

class _SubLastOrdersDetailsScreenState extends State<SubLastOrdersDetailsScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    // var networkStatus = Provider.of<NetworkStatus>(context);
    return Consumer<ConnectivityNotifier>(
      builder: (context , connection , child) {
        return SafeArea(
          child: connection.hasConnection
              ? Scaffold(
            key: _scaffoldKey,
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
              child: const CustomAppBar(),
            ),
            body: ListView(
              children: [


                OrderContent(
                  request: widget.request,
                ),


                20.ph,


                OrderTracking(
                  request:  widget.request,
                ),


              ],
            ),
          )

              :  Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
              child: const CustomAppBar(),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: CustomMessage(
                      appLottieIcon: AppLottie.noConnection,
                      message: allTranslations.text("networkConnection"),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
