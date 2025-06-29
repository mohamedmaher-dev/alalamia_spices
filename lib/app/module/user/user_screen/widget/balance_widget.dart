import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/data/providers/userModel.dart';
import 'package:alalamia_spices/app/global_widgets/currency_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../data/providers/translations.dart';
import '../../../../data/providers/user_wallet_model.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var userWalletModel = Provider.of<UserWalletModel>(context);
    var userModel = Provider.of<UserModel>(context);
    userWalletModel.getUserBalance();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          allTranslations.text("walletBalance"),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              fontFamily: "cairo"),
        ),

        // Icon(
        //   Icons.wallet,
        //   size: 20,
        //   color: Theme.of(context).textTheme.caption!.color,
        // ),

        10.pw,
        StatefulBuilder(
          builder: (context, mySetState) {
            return InkWell(
              onTap: () {
                if (userWalletModel.hiddenBalance == false) {
                  mySetState(() {
                    userWalletModel.hiddenBalance = true;
                  });
                } else {
                  mySetState(() {
                    userWalletModel.hiddenBalance = false;
                  });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    userWalletModel.hiddenBalance == false
                        ? Icons.visibility
                        : Icons.visibility_off,
                    size: 20,
                    color: Theme.of(context).textTheme.bodySmall!.color,
                  ),
                  10.pw,
                  Text(
                    userWalletModel.hiddenBalance == false
                        ? "* * * * *"
                        : userWalletModel.items.isEmpty
                            ? "0.0"
                            : userWalletModel.userBalance.toString(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        fontFamily: "cairo"),
                  ),
                  10.pw,
                  if (userWalletModel.hiddenBalance == true)
                    CurrencyView(
                      currency: userModel.user.currencyName,
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
