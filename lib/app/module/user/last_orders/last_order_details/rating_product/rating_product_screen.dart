import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/values/app_lottie.dart';
import '../rating_order/widget/rating_card.dart';

class RatingProductScreen extends StatefulWidget {
  final String priceId;
  const RatingProductScreen({super.key, required this.priceId});

  @override
  State<RatingProductScreen> createState() => _RatingProductScreenState();
}

class _RatingProductScreenState extends State<RatingProductScreen> {
  late final TextEditingController noteController;
  var rating = 0.0;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
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
    // if (kDebugMode) {
    //   print("price id ${widget.priceId}");
    // }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
          child: const CustomAppBar(),
        ),
        body: ChangeNotifierProvider<ProductEvaluationModel>(
          create: (context) => ProductEvaluationModel(context,
              productId: int.parse(widget.priceId)),
          child: Consumer<ProductEvaluationModel>(
            builder: (context, model, child) {
              return Padding(
                padding: EdgeInsets.all(15.0.h),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      RatingCard(
                          ratingType: allTranslations.text("product"),
                          initialRating: 0.0,
                          onRatingUpdate: (value) {
                            setState(() {
                              rating = value;
                            });

                            debugPrint("rating value -> $value");

                            // print("rating value dd -> ${value.truncate()}");
                          }),

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
                          validator: (value) {
                            if (value.length == 0) {
                              return allTranslations.text("fieldRequired");
                            }
                            return null;
                          },
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
                                if (rating != 0.0) {
                                  if (_formKey.currentState!.validate()) {
                                    mySetState(() {
                                      isLoading = true;
                                    });
                                    model.items.clear();

                                    debugPrint(" rating value $rating");

                                    ProductEvaluation productEvaluation =
                                        ProductEvaluation(
                                      rate: rating.toString(),
                                      comment: noteController.text,
                                    );
                                    await model.sendProductRate(
                                      productEvaluation: productEvaluation,
                                      productPriceId: widget.priceId,
                                    );
                                    if (model.isLoaded) {
                                      debugPrint("price id ${widget.priceId}");
                                      debugPrint("rated");

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
                                          withYesButton: true,
                                          withActions: true,
                                          onPressed: () {
                                            Navigator.pop(context);
                                            CustomDialog.hideCustomDialog(
                                                context);
                                          });

                                      // facebookAppEvents.logRated(
                                      //   valueToSum: rating
                                      // );
                                    }
                                  } else {
                                    mySetState(() {
                                      isLoading = false;
                                    });
                                    _formKey.currentState!.validate();
                                  }
                                } else {
                                  CustomToast.showFlutterToast(
                                      context: context,
                                      message: allTranslations.text("noRate"));
                                }
                              });
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
