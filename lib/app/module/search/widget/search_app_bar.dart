//
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/data/model/connectivity_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../../core/values/app_images.dart';
// import '../../../data/model/appModel.dart';
// import '../../../data/model/userModel.dart';
// import '../../../global_widgets/circular_loading.dart';
// import '../../../global_widgets/country_image_app_bar.dart';
// import '../../../global_widgets/custom_cached_network_image.dart';
// import '../../../services/screen_navigation_service.dart';
// import '../../cart/cart_tab.dart';
// import '../../product_details/widget/badges.dart';
// import '../../user/settings/settings_screen.dart';
// import '../../user/user_screen/user_screen.dart';
//
// class SearchAppBar extends StatelessWidget {
//   const SearchAppBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var userModel = Provider.of<UserModel>(context);
//     userModel.getUserInfo();
//     return Consumer<ConnectivityNotifier>(
//       builder: (context , connection , child) {
//         return Container(
//           color: Theme.of(context).selectedRowColor , // black color
//           child: Column(
//             children: [
//               // app header
//               Padding(
//                 padding:  EdgeInsets.all(5.w),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//
//                     InkWell(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child:  Padding(
//                         padding: EdgeInsets.only(left: 10.0.w , right: 10.0.w),
//                         child:  const Icon(
//                           Icons.arrow_back_ios,
//                           color: Colors.white, // white color
//                           size: 20,
//                         ),
//                       ),
//                     ),
//
//
//
//                     Image.asset(
//                       AppImages.horizontalLogo,
//                       width: 180.w,
//                       height: 50.h,
//                     ),
//
//
//                     10.pw,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//
//
//
//                          connection.hasConnection
//                           ? const CountryImageAppBar()
//                           : 0.ph,
//
//                         10.pw,
//                         appModel.token == "visitor"
//                             ? InkWell(
//                           onTap: () {
//                             Navigator.push(context,
//                                 MaterialPageRoute(builder: (context) => const UserScreen()));
//                           },
//                           child:  Padding(
//                             padding:  EdgeInsets.only(left: 10.0.w , right: 10.0.w),
//                             child:  const Icon(
//                               Icons.person_add_alt_1,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ),
//                         )
//                             : InkWell(
//                           onTap: () {
//                             Navigator.push(context,
//                                 MaterialPageRoute(builder: (context) => const UserScreen()));
//                           },
//                           child:  Padding(
//                             padding:  EdgeInsets.only(left: 10.0.w , right: 10.0.w),
//                             child:  const Icon(
//                               Icons.person,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//
//
//                         Padding(
//                           padding: EdgeInsets.only(left: 10.0.w , right: 10.w),
//                           child: InkWell(
//                               onTap: (){
//                                 pushScreen(context, const CartTab(isFromProductDetails: true));
//                               },
//                               child: const Badges()
//                           ),
//                         ),
//                       ],
//                     )
//
//
//
//                   ],
//                 ),
//               ),
//
//
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
