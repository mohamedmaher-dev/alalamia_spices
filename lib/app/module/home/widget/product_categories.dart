// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/global_widgets/custom_buttons.dart';
// import 'package:alalamia_spices/app/global_widgets/custom_rotated_box.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../core/values/app_images.dart';
// import '../../../data/model/translations.dart';
// import '../../product_details/product_details_screen.dart';
// import 'new_arrival.dart';
//
//
// class ProductCategories extends StatelessWidget {
//    const ProductCategories({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       primary: false,
//       itemCount: imageList.length,
//       cacheExtent: 128.0,
//       scrollDirection: Axis.vertical,
//       itemBuilder: (context, index) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 5 , vertical: 5),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//
//                 children: [
//                   Text(
//                     imageList[index]['name'],
//                     style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                       fontWeight: FontWeight.bold
//                     ),
//                   ),
//
//                   CustomButtons(
//                       width: 80.w,
//                       height: 25.h,
//                       text: allTranslations.text('showMore'),
//                       textStyle: Theme.of(context).textTheme.caption!.copyWith(
//                         color: Theme.of(context).primaryColor
//                       ),
//                       buttonColor: Theme.of(context).secondaryHeaderColor
//                   ),
//
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: 172.h,
//               child: ListView.builder(
//
//                 shrinkWrap: true,
//                 primary: false,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: imageList.length,
//                 itemBuilder: (context , innerIndex){
//                   return InkWell(
//                     onTap: (){
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>ProductDetailsScreen(
//                                   product: ,
//                               )));
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 3 , right: 3),
//                       child: Container(
//                         width: 120.w,
//                         padding: const EdgeInsets.all(5.w),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                           color: Colors.white
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(top: 5 , bottom: 5 , left : 5 , right: 5),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
//                                 child: SizedBox(
//                                   height: 105.h,
//                                   width: 100.w,
//                                   child:  CachedNetworkImage(
//                                     fit: BoxFit.fill,
//                                     imageUrl: imageList[index]['image'],
//                                     placeholder: (context, url) => SizedBox(
//                                       width: 70,
//                                       height: 70,
//                                       child: Padding(
//                                           padding: EdgeInsets.all(10.0.w),
//                                           child: Image.asset(
//                                             AppImages.logo,
//                                           )),
//                                     ),
//                                     errorWidget: (context, url, error) => SizedBox(
//                                       width: 70,
//                                       height: 70,
//                                       child: Padding(
//                                           padding: EdgeInsets.all(10.0.w),
//                                           child: Image.asset(
//                                             AppImages.logo,
//                                           )),
//                                     ),
//                                   ),
//
//
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               width: 300.w,
//                               padding: const EdgeInsets.only(left: 10 , right: 10 , bottom: 5),
//                               decoration: const BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.only(
//                                       bottomLeft: Radius.circular(5),
//                                       bottomRight: Radius.circular(5)
//                                   )
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     imageList[index]['name'],
//                                     style: Theme.of(context).textTheme.bodyLarge,
//                                   ),
//
//
//
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             )
//
//
//
//           ],
//         );
//       },
//
//     );
//   }
// }
