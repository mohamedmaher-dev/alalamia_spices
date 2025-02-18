//
//
//
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:alalamia_spices/app/global_widgets/country_image_app_bar.dart';
// import 'package:alalamia_spices/app/module/search/search_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../../core/values/app_images.dart';
// import '../../../services/screen_navigation_service.dart';
// import '../../cart/cart_tab.dart';
// import '../../product_details/widget/badges.dart';
// import '../../user/user_screen/user_screen.dart';
//
//
// class HomeAppBar extends StatefulWidget {
//   const  HomeAppBar({Key? key}) : super(key: key);
//
//   @override
//   State<HomeAppBar> createState() => _HomeAppBarState();
// }
//
// class _HomeAppBarState extends State<HomeAppBar> {
//   @override
//   Widget build(BuildContext context) {
//     var userModel = Provider.of<UserModel>(context);
//     userModel.getUserInfo();
//     return Consumer<ConnectivityNotifier>(
//       builder: (context , connection , child){
//         return SafeArea(
//           child: Container(
//             color: Theme.of(context).selectedRowColor , // black color
//             child: Column(
//               children: [
//                 // app header
//                 Padding(
//                   padding:  EdgeInsets.symmetric(horizontal: 5.0.w , vertical: 5.h),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//
//
//                       Image.asset(
//                         AppImages.horizontalLogo,
//                         width: 180.w,
//                         height: 50.h,
//                       ),
//
//
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//
//                           InkWell(
//                             onTap: () {
//
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) => SearchScreen()));
//
//                             },
//                             child:  Padding(
//                               padding:   EdgeInsets.only(left: 10.0.w , right: 10.0.w),
//                               child:  const Icon(
//                                 Icons.search,
//                                 color: Colors.white,
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//
//
//                           10.pw,
//
//
//
//                           connection.hasConnection
//                               ? const CountryImageAppBar()
//                               : 0.ph,
//
//                           10.pw,
//
//                           appModel.token == "visitor"
//                               ? InkWell(
//                             onTap: () {
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) => const UserScreen()));
//                             },
//                             child:  Padding(
//                               padding:  EdgeInsets.only(left: 10.0.w , right: 10.0.w),
//                               child:  const Icon(
//                                 Icons.person_add_alt_1,
//                                 color: Colors.white,
//                                 size: 20,
//                               ),
//                             ),
//                           )
//                               : InkWell(
//                             onTap: () {
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) => const UserScreen()));
//                             },
//                             child:  Padding(
//                               padding:  EdgeInsets.only(left: 10.0.w , right: 10.0.w),
//                               child:  const Icon(
//                                 Icons.person,
//                                 color: Colors.white,
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//
//                           Padding(
//                             padding: EdgeInsets.only(left: 10.0.w , right: 10.w),
//                             child: InkWell(
//                                 onTap: (){
//                                   pushScreen(context, const CartTab(isFromProductDetails: true));
//                                 },
//                                 child: const Badges()
//                             ),
//                           ),
//                         ],
//                       )
//
//                     ],
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
