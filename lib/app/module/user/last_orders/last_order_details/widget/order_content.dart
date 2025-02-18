
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:alalamia_spices/app/module/user/last_orders/last_order_details/rating_product/rating_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../data/model/request.dart';
import '../last_order_details_screen.dart';
import 'package:alalamia_spices/app/exports/provider.dart';

class OrderContent extends StatefulWidget {
  final Request request;
  const OrderContent({
    required this.request,
    Key? key
  }) : super(key: key);

  @override
  State<OrderContent> createState() => _OrderContentState();
}

class _OrderContentState extends State<OrderContent> {


  @override
  Widget build(BuildContext context) {

    List<Widget> list = [];
    String currancy = '';
    try {
      list = (widget.request.requestItems!.cartProductItems)
          !.map((item) => _buildTableRow(
          context ,
          item.name.toString(),
          item.productUnit != null ? item.productUnit.toString() : "",
          item.quantity.toString(),
          item.price.toString() ,
          item.id.toString()
      ))
          .toList();
      setState(() {
        currancy = widget.request.requestItems!.cartProductItems![0].currency.toString();
      });
    } catch (e) {}
    try {
      list.addAll((widget.request.requestItems!.cartOfferItems)
          !.map((item) => _buildTableRow(
          context ,
          item.name.toString(),
          item.productUnit != null ? item.productUnit.toString() : "",
          item.quantity.toString(),
          item.price.toString() ,
          item.id.toString()
      ))
          .toList());
      setState(() {
        currancy = widget.request.requestItems!.cartOfferItems![0].currency.toString();
      });
    } catch (e) {}
    try {
      list.addAll((widget.request.requestItems!.cartSpecialItems)
          !.map((item) => _buildTableRow(
          context ,
          item.name.toString(),
          item.productUnit != null ? item.productUnit.toString() : "",
          item.quantity.toString(),
          item.price.toString() ,
          item.id.toString()
      ))
          .toList());
      setState(() {
        currancy = widget.request.requestItems!.cartSpecialItems![0].currency.toString();
      });
    } catch (e) {}
    // try {
    //   list.addAll((widget.request.requestItems!.cartHospitalityItem)
    //       .map((item) => _buildTableRow(context , item.name, item.quantity, item.price))
    //       .toList());
    //   setState(() {
    //     currancy = widget.request.requestItems.cartHospitalityItem[0].currency;
    //   });
    // } catch (e) {}


      // try {
      //   list.addAll((widget.request.requestItems.customProduct)
      //       .map((item) => _buildTableRow(context , item.customProduct, item.quantity, "0"))
      //       .toList());
      //   // setState(() {
      //   //   currancy = widget.request.requestItems.customProduct[0].currency;
      //   // });
      // } catch (e) {}


    return ChangeNotifierProvider<ListenToRequestStatusModel>(
      create: (context) => ListenToRequestStatusModel(context , widget.request.requestId.toString()),
      child: Consumer<ListenToRequestStatusModel>(
        builder: (context , listenToRequestStatusModel , child){
          if(listenToRequestStatusModel.isLoaded){
            status = listenToRequestStatusModel.status.status!;
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w , vertical: 10.h),
                child: Text(
                  allTranslations.text("orderDetails"),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp
                  ),
                ),
              ),
              10.ph,

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
                child: Container(
                  padding:  EdgeInsets.all(10.0.w),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius:  BorderRadius.circular(AppConstants.defaultBorderRadius.w)
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex : 2,
                            child: Text(
                              allTranslations.text("product"),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),


                          Expanded(
                            child: Text(
                              allTranslations.text("price"),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),

                          20.pw,

                          Expanded(
                            child: Text(
                              allTranslations.text("quantity"),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),

                          20.pw,
                          Expanded(
                            flex: 2,
                            child: Text(
                              allTranslations.text("total"),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),

                          listenToRequestStatusModel.isLoaded  && status == "delivered" ||
                              status == "on_branch" ||
                              status == "reviewed"
                              ? Expanded(
                              child: Text(
                                allTranslations.text("rating"),
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                          )
                              : 0.ph,

                        ],
                      ),
                      const Divider(),
                      Column(
                        children: list,
                      )
                    ],
                  ),
                ),
              ),


            ],
          );
        },
      ),
    );
  }
  Widget _buildTableRow(
      BuildContext context ,
      String productName,
      String productUnit,
      String quantity,
      String productPrice,
      String priceId
      ) {
    var total = double.parse(quantity) * double.parse(productPrice);
    return ChangeNotifierProvider<ListenToRequestStatusModel>(
      create: (context) => ListenToRequestStatusModel(context , widget.request.requestId.toString()),
      child: Consumer<ListenToRequestStatusModel>(
        builder: (context , listenToRequestStatusModel , child){
          if(listenToRequestStatusModel.isLoaded){
            status = listenToRequestStatusModel.status.status!;
          }
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child:  Text(
                      "$productName  $productUnit",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12.sp,
                          fontFamily: 'cairo'
                      ),
                    ),
                  ),

                  10.pw,
                  Expanded(
                    flex: 2,
                    child: Text(
                      productPrice.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12.sp,
                          fontFamily: "cairo"
                      ),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      double.parse(quantity).round().toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12.sp,
                          fontFamily: "cairo"
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Text(
                      total.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12.sp,
                          fontFamily: "cairo"
                      ),
                    ),
                  ),

                  listenToRequestStatusModel.isLoaded  && status == "delivered" ||
                      status == "on_branch" ||
                      status == "reviewed"
                      ? Expanded(
                    child:  InkWell(
                      onTap: () {
                        pushScreenReplacement(context, RatingProductScreen(
                          priceId: priceId.toString(),
                        ));
                      },
                      child: Text(
                        allTranslations.text("rating"),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).colorScheme.secondary,
                            fontFamily: 'cairo'
                        ),
                      ),
                    ),
                  )
                      : 0.ph,
                ],
              ),
              const Divider()
            ],
          );
        },
      ),
    );
  }
}
