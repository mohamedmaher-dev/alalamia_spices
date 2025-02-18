

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_images.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/global_widgets/custom_cached_network_image.dart';
import 'package:alalamia_spices/app/module/user/user_screen/widget/balance_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


class UserHeader extends StatelessWidget {
    UserHeader({Key? key}) : super(key: key);
  bool hiddenBalance = false;
  @override
  Widget build(BuildContext context) {
    var userWalletModel = Provider.of<UserWalletModel>(context);
    return ChangeNotifierProvider<UserModel>(
      create: (context) => UserModel(context),
      child: Consumer<UserModel>(
        builder: (context , userModel , child){
          userModel.getUserInfo();
          userWalletModel.getUserBalance();
          return SizedBox(
            height: 200.h,
            child: appModel.token == "visitor"
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    height: 100.h,
                    width: 100.w,
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(3.0.h),
                    child: Image.asset(
                        AppImages.logo
                    ),
                  ),
                ),
                20.ph,
                Center(
                  child: Text(
                    allTranslations.text("welcomeToAlalamia"),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'cairo'
                    ),
                  ),
                ),
              ],
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                10.ph,

                ClipOval(
                  child: Container(
                    height: 100.h,
                    width: 100.w,
                    color: Theme.of(context).primaryColor,
                    child: CustomCachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: userModel.userImage.toString(),
                    ),
                  ),
                ),
                10.ph,

                Center(
                  child: Text(
                    userModel.userName.toString(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'cairo'
                    ),
                  ),
                ),

                5.ph,

                /// balance
                const BalanceWidget()

              ],
            ),
          );
        },
      ),
    );
  }
}
