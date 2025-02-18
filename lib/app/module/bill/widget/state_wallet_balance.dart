//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../../core/values/app_colors.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';
// import '../../../global_widgets/circular_loading.dart';
// import '../../../global_widgets/custom_card_icon_text.dart';
// import '../bill_screen.dart';
//
// class StateWalletBalance extends StatelessWidget {
//   const StateWalletBalance({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserModel>(builder: (context, model, child) {
//       var userWalletModel = Provider.of<UserWalletModel>(context);
//       var cartProvider = Provider.of<CartModel>(context);
//       var discountModel = Provider.of<DiscountModel>(context);
//       var userBalance;
//       model.isLoaded
//           ? userWalletModel.userWallet == null
//           ? userBalance = "0.0"
//           : userBalance = userWalletModel.userWallet.currentBalance
//           : userBalance = 0.0;
//       var sumOfCart;
//       cartProvider.isLoaded
//           ? sumOfCart =  total
//           : sumOfCart = 0.0;
//       return userWalletModel.isLoading || userWalletModel.loadingFailed
//           ? const CircularLoading()
//           :  CustomCardIconText(
//         color: double.parse(userBalance) >= sumOfCart
//             ? AppColors.green
//             : AppColors.red,
//         icon: Icons.wallet,
//         backIconColor: Colors.white24,
//         iconColor: Colors.white,
//         height: 40.h,
//         width: 45.w,
//         secondWidget: Text(
//             userWalletModel.userWallet.currentBalance.toString(),
//             style: Theme.of(context).textTheme.headline2!.copyWith(
//                 fontWeight: FontWeight.bold,
//                 fontFamily: "cairo"
//             )
//         ),
//         itemsName: double.parse(userBalance) >= sumOfCart
//             ? allTranslations.text('enoughBalance')
//             : allTranslations.text('noEnoughBalance'),
//         itemsNameStyle: Theme.of(context).textTheme.headline1,
//       );
//     });
//   }
// }
