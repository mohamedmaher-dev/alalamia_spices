

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/global_widgets/circular_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/exports/provider.dart';

class ProductDetailsRating extends StatelessWidget {
  final String overAllAssessment;
  final String numberResident;
  final String productId;
  const ProductDetailsRating({
    Key? key,
    required this.overAllAssessment,
    required this.numberResident,
    required this.productId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductEvaluationModel>(
      create: (context) => ProductEvaluationModel(context ,  productId: int.parse(productId)),
      child: Consumer<ProductEvaluationModel>(
        builder: (context , model , child){
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// users ratings
              Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.all(10.0.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        allTranslations.text("usersRatings"),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold
                        )
                    ),
                    10.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            overAllAssessment,
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: "cairo"
                            )
                        ),
                        5.pw,
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:



                                  List.generate( 5, (index) {
                                    return index < double.parse(overAllAssessment).round()
                                        ?   Icon(Icons.star , color: Theme.of(context).colorScheme.secondary,)
                                        : index > double.parse(overAllAssessment).round() - 1 &&
                                        index < double.parse(overAllAssessment).round()
                                        ?  Icon(Icons.star_half , color: Theme.of(context).colorScheme.secondary,)
                                        : const Icon(Icons.star , color: Colors.grey,);
                                  })
                              ),

//
                              5.ph,
                              Padding(
                                padding: const EdgeInsets.only(left : 5.0 , right: 5),
                                child: Text(
                                  "${allTranslations.text("basedOn")} $numberResident ${allTranslations.text("ofRatings")}",
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontFamily: "cairo"
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),

                      ],
                    )
                  ],
                ),
              ),

              2.ph,

              Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.all(10.0.w),
                child: Text(
                  "${allTranslations.text("have")} $numberResident ${allTranslations.text("customerRatings")} "
                      "${allTranslations.text("and")} $numberResident ${allTranslations.text("customerReview")}",
//                          "يوجد 367 تقييماً من العملاء و 96 تعليقاً من العملاء",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontFamily: "cairo"
                  ),
                ),
              ),

              2.ph,
              model.items.isNotEmpty
               ? Stack(
                children: [
                  model.isLoading || model.loadingFailed
                  ? const CircularLoading()
                  : ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: model.items.length,
                    itemBuilder: (context , index){
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        color: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: EdgeInsets.all(10.0.w),
                          child: Column(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width,

                                  padding:  EdgeInsets.all(5.w),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: List.generate(5, (starIndex) {
                                                return starIndex < double.parse(model.items[index].rate)
                                                    ?   Icon(Icons.star , color: Theme.of(context).colorScheme.secondary, size: 15,)
                                                    : starIndex > double.parse(model.items[index].rate) - 1 && starIndex < double.parse(model.items[index].rate)
                                                    ?  Icon(Icons.star_half , color: Theme.of(context).colorScheme.secondary,  size: 15,)
                                                    : const Icon(Icons.star , color: Colors.grey , size: 15,);
                                              })
                                          ),

                                          15.ph,
                                          SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              model.items[index].comment,
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context).textTheme.bodySmall,
                                            ),
                                          ),
                                        ],
                                      ),

                                      Text(
                                        model.items[index].userName,
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ),
                                    ],
                                  )
                              ),
                              Divider(color: Colors.grey[300],),




                            ],

                          ),
                        ),
                      );
                    },
                  ),

                  /// show more
                  // Positioned(
                  //   bottom: 0,
                  //   left: 100,
                  //   right: 100,
                  //   child: Container(
                  //     width: 100.w,
                  //     height: 40.h,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                  //         color: Theme.of(context).secondaryHeaderColor
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         allTranslations.text("showMore"),
                  //         style: Theme.of(context).textTheme.headline1!.copyWith(
                  //             fontWeight: FontWeight.bold
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              )
               : 0.ph,
            ],
          );
        },
      ),
    );
  }
}
