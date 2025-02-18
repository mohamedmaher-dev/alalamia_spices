//
//
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';new_arrival.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:alalamia_spices/app/module/product_details/product_details_screen.dart';
// import 'package:chips_choice/chips_choice.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
//
// import '../../../core/utils/constants.dart';
// import '../../../data/model/translations.dart';
// import '../../../global_widgets/custom_two_text.dart';
//
//
// class ProductDetailsFreeAdds extends StatefulWidget {
//   final Product product;
//   const ProductDetailsFreeAdds({
//     Key? key,
//     required this.product
//   }) : super(key: key);
//
//   @override
//   State<ProductDetailsFreeAdds> createState() => _ProductDetailsFreeAddsState();
// }
//
// class _ProductDetailsFreeAddsState extends State<ProductDetailsFreeAdds> {
//
//   // int selectedPrice = 0;
//
//   List<String> addSizeList = [];
//   getFreeAdds()  {
//     addSizeList = [];
//
//     if(widget.product.addSize != null ) {
//       for(int i = 0; i < widget.product.addSize!.length; i ++)
//       {
//         addSizeList.add(
//           allTranslations.currentLanguage == "ar"
//             ? "${widget.product.addSize![i].typeAr} / ${widget.product.addSize![i].addAr}"
//             : "${widget.product.addSize![i].typeEn} / ${widget.product.addSize![i].addEn}"
//         );
//
//       }
//     }
//
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     getFreeAdds();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return addSizeList.isEmpty
//       ? 0.ph
//       : Container(
//       height: 120.h,
//       color: Theme.of(context).primaryColor,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding : EdgeInsets.all(10.0.w),
//             child: CustomTowText(
//               title: allTranslations.text("freeAdds"),
//               titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                   fontWeight: FontWeight.bold
//               ),
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               subWidget: Icon(
//                 Icons.arrow_drop_down,
//                 size: 20,
//                 color: Theme.of(context).secondaryHeaderColor,
//               ),
//             ),
//           ),
//
//
//
//           /// multi selection
//
//           ChipsChoice<String>.multiple(
//
//             scrollPhysics: const BouncingScrollPhysics(),
//             direction: Axis.horizontal,
//             // choiceStyle: C2ChipStyle(
//             //   elevation: 0.1,
//             // ),
//             value: freeAdd,
//             onChanged: (val) => setState(() => freeAdd = val),
//             choiceItems: C2Choice.listFrom<String, String>(
//               source: addSizeList,
//               value: (i, value) => value,
//               label: (i, v) => v,
//             ),
//           ),
//
//
//           /// single selection
//           // Flexible(
//           //   child: ListView.builder(
//           //     shrinkWrap: true,
//           //     primary: false,
//           //     scrollDirection: Axis.horizontal,
//           //     physics: const BouncingScrollPhysics(),
//           //     itemCount: widget.product.addSize!.length,
//           //     itemBuilder: (context , index){
//           //       return  InkWell(
//           //         onTap: (){
//           //           setState(() {
//           //             selectedPrice = index;
//           //             freeAdd = widget.product.addSize![selectedPrice].typeAr.toString();
//           //             // quantity = 1;
//           //           });
//           //         },
//           //         child: Padding(
//           //           padding:  EdgeInsets.symmetric(horizontal: 5.w),
//           //           child: Container(
//           //             height: 80.h,
//           //             padding: EdgeInsets.all(5.0.w),
//           //             decoration: BoxDecoration(
//           //                 borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//           //                 border: selectedPrice == index
//           //                     ? Border.all(color: Theme.of(context).colorScheme.secondary , width: 2.w)
//           //                     : Border.all(color: Colors.transparent)
//           //
//           //             ),
//           //             child: Column(
//           //               mainAxisAlignment: MainAxisAlignment.center,
//           //               crossAxisAlignment: CrossAxisAlignment.center,
//           //               children: [
//           //                 Text(
//           //                     widget.product.addSize![index].typeAr.toString() ,
//           //                     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//           //                         fontWeight: FontWeight.bold,
//           //                         fontFamily: "cairo"
//           //                     )
//           //                 ),
//           //                 5.ph,
//           //                 Text(
//           //                     widget.product.addSize![index].addAr.toString() ,
//           //                     style: Theme.of(context).textTheme.caption!.copyWith(
//           //                         fontWeight: FontWeight.bold,
//           //                         fontFamily: "cairo"
//           //                     )
//           //                 ),
//           //               ],
//           //             ),
//           //           ),
//           //         ),
//           //       );
//           //     },
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
