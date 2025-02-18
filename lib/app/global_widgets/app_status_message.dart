
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/values/app_colors.dart';

class AppStatusMessage extends StatelessWidget {
  const AppStatusMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserModel>(
      create: (context) => UserModel(context),
      child: Consumer<UserModel>(
        builder: (context , model, child){
          model.getUserInfo();
          return SafeArea(
            child: Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const  Icon(
                        CupertinoIcons.lock,
                        size: 100,
                        color: AppColors.red,
                      ),
                      20.ph,
                      Text(
                        model.errorMessage == "Unauthorized"
                            ? allTranslations.text("unauthorizedUser")
                            : model.errorMessage == "attitude"
                            ? allTranslations.text("accountStopped")
                            : model.errorMessage == "deleted"
                            ? allTranslations.text("accountDeleted")
                            : model.errorMessage == "blacklist"
                            ? allTranslations.text("accountBlackList")
                            : model.errorMessage.toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                )
            ),
          );
        },
      ),
    );
  }
}
