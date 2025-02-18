

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/global_widgets/custom_two_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/constants.dart';
import '../../../data/model/new_arrival.dart';

class ProductDetailsPaidAdds extends StatefulWidget {
  final Product product;

  const ProductDetailsPaidAdds({
    Key? key,
    required this.product
  }) : super(key: key);

  @override
  State<ProductDetailsPaidAdds> createState() => _ProductDetailsPaidAddsState();
}

class _ProductDetailsPaidAddsState extends State<ProductDetailsPaidAdds> {

  int selectedPrice = 0;
  int quantity = 1;


  @override
  Widget build(BuildContext context) {
    var paidAddsList = widget.product.prices!.where((element) => element.paidAdds == "true").toList();
    return Container(
      height: 140.h,
      padding : EdgeInsets.all(10.0.w),
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTowText(
            title: allTranslations.text("paidAdds"),
            titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold
            ),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            subWidget: Icon(
              Icons.arrow_drop_down,
              size: 20,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          10.ph,
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: paidAddsList.length,
              itemBuilder: (context , index){
                return  InkWell(
                  onTap: (){
                    setState(() {
                      selectedPrice = index;
                      // quantity = 1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70.h,
                      padding: EdgeInsets.all(5.0.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                          border: selectedPrice == index
                              ? Border.all(color: Theme.of(context).colorScheme.secondary , width: 2.w)
                              : Border.all(color: Theme.of(context).selectedRowColor),
                        color: selectedPrice == index
                           ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).primaryColor

                      ),
                      child: Text(
                          paidAddsList[selectedPrice].unitName.toString() ,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: "cairo"
                          )
                      ),
                    ),
                  ),
                );
              },
            )
          ),
          /// pricing
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
            child: CustomTowText(
              title: allTranslations.text("price"),
              titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              subTitle: "${paidAddsList[selectedPrice].price} ${paidAddsList[selectedPrice].currency} ",
              subTitleStyle:  Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: "cairo"
              ),
            ),
          )
        ],
      ),
    );
  }
}

extension on ThemeData {
  get selectedRowColor => null;
}
