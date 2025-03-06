// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/module/cart/cart_tab.dart';
// import 'package:alalamia_spices/app/module/search/search_screen.dart';
// import 'package:alalamia_spices/app/module/user/user_screen/user_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
//
// import '../core/values/app_images.dart';
// import '../data/model/appModel.dart';
// import '../module/product_details/widget/badges.dart';
// import '../module/start/start.dart';
// import 'package:alalamia_spices/app/exports/services.dart';
//
//
// class CustomAppBar extends StatelessWidget {
//
//   const CustomAppBar({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return  Container(
//       color: Theme.of(context).selectedRowColor , // black color
//       child: Column(
//         children: [
//           // app header
//           Padding(
//             padding:  EdgeInsets.all(5.w),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//
//                 InkWell(
//                   onTap: () {
//                      Navigator.pop(context);
//                   },
//                   child:  Padding(
//                     padding:   EdgeInsets.only(left: 5.0.w , right: 5.0.w),
//                     child:  const Icon(
//                        Icons.arrow_back_ios,
//                       color: Colors.white, // white color
//                       size: 20,
//                     ),
//                   ),
//                 ),
//
//
//
//
//                 Image.asset(
//                   AppImages.horizontalLogo,
//                   width: 180.w,
//                   height: 50.h,
//                 ),
//
//
//                 10.pw,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//
//
//                    InkWell(
//                       onTap: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => SearchScreen()));
//                       },
//                       child:  Padding(
//                         padding: EdgeInsets.only(left: 5.0.w , right: 5.0.w),
//                         child:  const Icon(
//                           Icons.search,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//
//
//
//                     appModel.token == "visitor"
//                         ? InkWell(
//                       onTap: () {
//                         Navigator.push(context,
//                         MaterialPageRoute(builder: (context)=> const UserScreen()));
//                       },
//                       child:  Padding(
//                         padding:  EdgeInsets.only(left: 10.0.w , right: 10.0.w),
//                         child:  const Icon(
//                           Icons.person_add_alt_1,
//                           color:  Colors.white,
//                           size: 20,
//                         ),
//                       ),
//                     )
//                         : InkWell(
//                       onTap: () {
//                         Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => const UserScreen()));
//                       },
//                       child:  Padding(
//                         padding:  EdgeInsets.only(left: 10.0.w , right: 10.0.w),
//                         child:  const Icon(
//                           Icons.person,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//
//
//
//                     Padding(
//                       padding: EdgeInsets.only(left: 10.0.w , right: 10.w),
//                       child: InkWell(
//                           onTap: (){
//                             pushScreen(context, const CartTab(isFromProductDetails: true));
//                           },
//                           child: const Badges()
//                       ),
//                     ),
//
//                   ],
//                 )
//
//
//
//               ],
//             ),
//           ),
//
//
//         ],
//       ),
//     );
//   }
// }

import 'package:alalamia_spices/app/module/branches/branches_location_tab.dart';
import 'package:alalamia_spices/app/module/user/notifications/notifications_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/global_widgets/country_image_app_bar.dart';
import 'package:alalamia_spices/app/module/search/search_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/values/app_images.dart';

class CustomAppBar extends StatelessWidget {
  final bool isHome;
  final bool isSearchScreen;
  final bool isBranchesScreen;
  final bool isCartScreen;
  final bool isNotifiScreen;

  const CustomAppBar({
    super.key,
    this.isHome = false,
    this.isSearchScreen = false,
    this.isBranchesScreen = false,
    this.isCartScreen = false,
    this.isNotifiScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    userModel.getUserInfo();
    return Consumer<ConnectivityNotifier>(
      builder: (context, connection, child) {
        return SafeArea(
          child: Container(
            color: Colors.black, // black color
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (isHome == true) ...[
                    _buildLogo(),
                    _buildSearchIcon(context),
                    _buildImageCountry(context),
                    _buildBranchesIcon(context),
                    _buildNotifiIcon(context)
                  ] else if (isSearchScreen == true) ...[
                    _buildArrowIcon(context),
                    _buildLogo(),
                    _buildImageCountry(context),
                    _buildBranchesIcon(context),
                    _buildNotifiIcon(context)
                  ] else if (isBranchesScreen == true) ...[
                    _buildLogo(),
                    _buildImageCountry(context),
                    _buildNotifiIcon(context)
                  ] else if (isCartScreen == true) ...[
                    _buildArrowIcon(context),
                    _buildLogo(),
                    _buildImageCountry(context),
                    _buildSearchIcon(context),
                    _buildBranchesIcon(context)
                  ] else if (isNotifiScreen == true) ...[
                    _buildArrowIcon(context),
                    _buildLogo(),
                    _buildImageCountry(context),
                    _buildSearchIcon(context),
                    _buildBranchesIcon(context)
                  ] else ...[
                    _buildArrowIcon(context),
                    _buildLogo(),
                    _buildSearchIcon(context),
                    _buildBranchesIcon(context),
                    _buildNotifiIcon(context)
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      AppImages.horizontalLogo,
      width: 180.w,
      height: 50.h,
    );
  }

  Widget _buildImageCountry(BuildContext context) {
    final connection = Provider.of<ConnectivityNotifier>(context);
    return connection.hasConnection ? const CountryImageAppBar() : 0.ph;
  }

  Widget _buildBranchesIcon(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BranchesLocationTab()));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
        child: const Icon(
          Icons.location_on_sharp,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildNotifiIcon(BuildContext context) {
    if (appModel.token == "visitor") {
      return SizedBox.shrink();
    } else {
      return IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotificationsScreen(),
            ),
          );
        },
        icon: Icon(
          CupertinoIcons.bell_fill,
          color: Colors.white,
          size: 20,
        ),
      );
    }
  }

  Widget _buildSearchIcon(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SearchScreen()));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
        child: const Icon(
          Icons.search,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildArrowIcon(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 5.0.w, right: 5.0.w),
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white, // white color
          size: 20,
        ),
      ),
    );
  }
}

extension on ThemeData {
  get selectedRowColor => null;
}
