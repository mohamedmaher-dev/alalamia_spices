


import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/user/user_screen/widget/index.dart';
import 'package:alalamia_spices/app/module/user/user_screen/widget/user_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import 'package:alalamia_spices/app/exports/provider.dart';


class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    userModel.loadData();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
            child: const CustomAppBar(isProfileScreen: true,),
          ),
        body: ListView(
          children: [

            /// user logo & name & email
             UserHeader(),

            /// user settings
             const UserBody(),

            /// about app & alalamia

            const UserFooter()



          ],
        ),
      ),
    );
  }
}
