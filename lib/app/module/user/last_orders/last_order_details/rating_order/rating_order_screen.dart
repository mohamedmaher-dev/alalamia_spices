import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:alalamia_spices/app/module/user/last_orders/last_order_details/rating_order/widget/rating_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/values/app_lottie.dart';

class RatingOrderScreen extends StatefulWidget {
  final String carrierId;
  final String requestId;
  final String branchId;
  const RatingOrderScreen(
      {super.key,
      required this.carrierId,
      required this.requestId,
      required this.branchId});

  @override
  State<RatingOrderScreen> createState() => _RatingOrderScreenState();
}

class _RatingOrderScreenState extends State<RatingOrderScreen> {
  late final TextEditingController noteController;
  bool isLoading = false;
  Rate? rateItem1, rateItem3, rateItem2;
  double _ratingBranch = 0.0;
  double _ratingServes = 0.0;
  List<Rate> rates = [];
  // static final facebookAppEvents = FacebookAppEvents();

  @override
  void initState() {
    super.initState();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
          child: const CustomAppBar(),
        ),
        body: ChangeNotifierProvider<RatingOrderModel>(
          create: (context) => RatingOrderModel(context),
          child: Consumer<RatingOrderModel>(
            builder: (context, model, child) {
              List<Rate> rate = [];
              try {
                for (int i = 0; i < model.getItemCount; i++) {
                  rate.add(model.getItem(i));
                }
              } catch (error) {
                debugPrint("****** rating order error $error");
              }

              return Padding(
                padding: EdgeInsets.all(15.0.h),
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    model.isLoading || model.loadingFailed
                        ? const CircularLoading()
                        : ListView.separated(
                            itemCount: model.getItemCount,
                            shrinkWrap: true,
                            primary: false,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, _) => 20.ph,
                            itemBuilder: (context, index) {
                              var rating = 0.0;
                              return RatingCard(
                                  ratingType:
                                      model.items[index].name.toString(),
                                  initialRating: 0.0,
                                  onRatingUpdate: (value) {
                                    setState(() {
                                      rating = value;
                                      if (rate[index].id == "2") {
                                        rateItem1 = Rate(
                                            id: rate[index].id,
                                            name: rate[index].name,
                                            rate: rating.toString());
                                        _ratingBranch = rating;
                                      } else if (rate[index].id == "3") {
                                        rateItem3 = Rate(
                                            id: rate[index].id,
                                            name: rate[index].name,
                                            rate: rating.toString());
                                        _ratingServes = rating;
                                      }
                                    });

                                    debugPrint("rating value -> $value");

                                    // print("rating value dd -> ${value.truncate()}");
                                  });
                            },
                          ),

                    20.ph,

                    /// description text filed

                    Container(
                      height: 250.h,
                      padding: EdgeInsets.all(10.0.w),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(
                            AppConstants.defaultBorderRadius.w),
                      ),
                      child: TextFormFieldWithName(
                        maxLines: 5,
                        controller: noteController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        hintTextFormField:
                            allTranslations.text("suggestHintText"),
                        fieldName: allTranslations.text("suggestSubTitle"),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 10.w),
                        // validator: (value) {
                        //   if (value.length == 0) {
                        //     return allTranslations.text("fieldRequired");
                        //   }
                        //   return null;
                        // },
                        onFieldSubmitted: () {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),

                    20.ph,

                    StatefulBuilder(
                      builder: (context, mySetState) {
                        return CustomButtons(
                            height: 45.h,
                            text: allTranslations.text("send"),
                            textWidget: isLoading == false
                                ? null
                                : const CircularLoading(),
                            buttonColor: isLoading == false
                                ? Theme.of(context).secondaryHeaderColor
                                : Theme.of(context).primaryColor,
                            onTap: () async {
                              mySetState(() {
                                isLoading = true;
                              });

                              try {
                                debugPrint("id ${widget.requestId}");
                                if (_ratingBranch != 0.0 ||
                                    _ratingServes != 0.0) {
                                  model.items.clear();
                                  rateItem1 != null
                                      ? rates.add(rateItem1!)
                                      : rateItem1 = null;
                                  rateItem2 != null
                                      ? rates.add(rateItem2!)
                                      : rateItem2 = null;
                                  rateItem3 != null
                                      ? rates.add(rateItem3!)
                                      : rateItem3 = null;

                                  debugPrint(
                                      " Rating has been done $_ratingBranch + $_ratingServes");

                                  RatingOrderData ratingOrder = RatingOrderData(
                                      carrierId: widget.carrierId,
                                      requestId: widget.requestId,
                                      comment: noteController.text,
                                      branch_id: widget.branchId,
                                      details: rates);
                                  await model.sendRate(ratingOrder);
                                  if (model.isLoaded) {
                                    debugPrint("rated");

                                    setState(() {
                                      rateItem1 = null;
                                      rateItem2 = null;
                                      rateItem3 = null;
                                    });

                                    mySetState(() {
                                      isLoading = true;
                                    });

                                    CustomDialog.showCustomDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        title: allTranslations
                                            .text("ratingSuccessfully"),
                                        icon: Lottie.asset(
                                          AppLottie.checkMark,
                                          width: 100.w,
                                          height: 100.h,
                                          repeat: false,
                                        ),
                                        withActions: true,
                                        withYesButton: true,
                                        onPressed: () {
                                          Navigator.pop(context);
                                          CustomDialog.hideCustomDialog(
                                              context);
                                        });

                                    // facebookAppEvents.logRated(
                                    //     valueToSum: _ratingBranch+_ratingServes
                                    // );
                                  }
                                } else {
                                  mySetState(() {
                                    isLoading = false;
                                  });
                                  CustomToast.showFlutterToast(
                                      context: context,
                                      message: allTranslations.text("noRate"));
                                }
                              } catch (e) {
                                debugPrint("rate errrrrror $e");
                              }
                            });
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
