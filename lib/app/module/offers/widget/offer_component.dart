import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';

class OfferComponent extends StatelessWidget {
  final List<OfferProductPrice>? offerProductPrice;
  const OfferComponent({
    Key? key,
     this.offerProductPrice
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(10.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          5.ph,
          Text(
            allTranslations.text("offerComponent"),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold
              )
          ),

          15.ph,

          ListView.builder(
            itemCount: offerProductPrice!.length,
            shrinkWrap: true,
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context , index){
              return Column(
                children: [
                  Container(
                    height : 40.h,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    color: Theme.of(context).primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                           Text(
                          offerProductPrice![index].name.toString(),
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontFamily: "cairo"
                          )
                        ),
                        CustomVerticalDivider(
                          color: Colors.grey.shade300,
                          height: 20.h,
                        ),
                         Text(
                           offerProductPrice![index].unit.toString(),
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontFamily: "cairo"
                          )
                        ),

                        CustomVerticalDivider(
                          color: Colors.grey.shade300,
                          height: 20.h,
                        ),
                         Text(
                           offerProductPrice![index].quantity.toString(),
                          style:  Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontFamily: "cairo"
                          )
                        ),
                      ],
                    ),
                  ),


                    Divider(
                     height: 2.h,
                   )
                ],
              );
            },
          ),


        ],
      ),
    );
  }
}
