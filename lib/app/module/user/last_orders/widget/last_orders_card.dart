

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_colors.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/model/request.dart';


class LastOrdersCard extends StatefulWidget {
  final Request request;
  const LastOrdersCard({
    required this.request,
    Key? key
  }) : super(key: key);

  @override
  State<LastOrdersCard> createState() => _LastOrdersCardState();
}

class _LastOrdersCardState extends State<LastOrdersCard> {
  @override
  Widget build(BuildContext context) {
    var requestModel = Provider.of<RequestModel>(context , listen:  false);
    var userModel = Provider.of<UserModel>(context);
    userModel.getUserInfo();
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.0.w  , vertical: 10.h),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 120.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
          color: Theme.of(context).primaryColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
              //   child: CachedNetworkImage(
              //     imageUrl: widget.request.branch!.imagePath.toString(),
              //     fit: BoxFit.fill,
              //     height: 80.h,
              //     width: 80.w,
              //     placeholder: (context, url) =>
              //         Image.asset(AppImages.logo),
              //     errorWidget: (context, url, error) =>
              //         Image.asset(AppImages.logo),
              //   ),
              // ),

              10.pw,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   widget.request.branch!.name.toString(),
                    //   style: Theme.of(context).textTheme.bodyMedium!!.copyWith(
                    //       fontWeight: FontWeight.bold
                    //   ),
                    // ),

                     CustomTowText(
                      title: allTranslations.text("orderNumber"),
                      subTitle: widget.request.requestNumber,
                       subTitleStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                           fontFamily: "cairo"
                       ),
                    ),
                    3.ph,
                    CustomTowText(
                      title: allTranslations.text("orderDate"),
                      subTitle: DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.request.createdAt.toString())),
                      subTitleStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontFamily: "cairo"
                      ),
                    ),
                    3.ph,

                     Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTowText(
                          title: allTranslations.text("orderTotal"),
                          subTitle: "${widget.request.requestItems!.priceSum}",
                          subTitleStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontFamily: "cairo"
                          ),
                        ),
                        5.pw,
                         Text(
                           "${userModel.userCurrency}",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontFamily: "cairo",
                            fontSize: 10.sp
                          ),

                        )
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Container(
                    height: 30.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: widget.request.status == "requested" // delivered to the customer
                        ? Theme.of(context).colorScheme.surface
                        : widget.request.status == "repair" // on the way
                        ? AppColors.red
                        : widget.request.status == "deliver" // being processed
                        ? AppColors.orange
                        : widget.request.status == "delivered"
                        ? AppColors.green
                        : widget.request.status == "canceled"
                        ? AppColors.red
                        : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                    ),
                    child: Center(
                      child: requestModel.isLoading || requestModel.loadingFailed
                      ? const CircularLoading()
                      : Text(
                        widget.request.status == "requested"
                          ? allTranslations.text("underReview")
                          : widget.request.status == "received"
                          ? allTranslations.text("requestApproved")
                          : widget.request.status == "repair"
                          ? allTranslations.text("beingProcessed")
                          : widget.request.status == "deliver"
                          ? allTranslations.text("onTheWay")
                          : widget.request.status == "delivered"
                          ? allTranslations.text("delivered")
                          : widget.request.status == "canceled"
                          ? allTranslations.text("canceled")
                          : allTranslations.text("underReview"),
                        textAlign: TextAlign.center,

                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: widget.request.status == "delivered" || widget.request.status == "canceled" ||
                                widget.request.status == "repair"
                                ? Colors.white
                                : Theme.of(context).textTheme.bodySmall!.color
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 30.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                    ),
                    child: Center(
                      child: Text(
                        widget.request.receivingType == "external"
                        ? allTranslations.text("externalRequest")
                        : widget.request.receivingType == "internal"
                        ? allTranslations.text("internalRequest")
                        : widget.request.receivingType == "urgent"
                        ? allTranslations.text("urgent")
                        : widget.request.receivingType == "afterExternal"
                        ? allTranslations.text("externalRequest")
                        : widget.request.receivingType == "afterInternal"
                        ? allTranslations.text("internalRequest")
                        : widget.request.receivingType == "afterUrgent"
                        ? allTranslations.text("urgent")
                        : widget.request.receivingType.toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 30.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                    ),
                    child: Center(
                      child: Text(
                        allTranslations.text("detail"),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),



                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
