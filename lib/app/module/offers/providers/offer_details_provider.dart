import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../global_widgets/custom_dialog.dart';
import 'package:alalamia_spices/app/exports/model.dart';

class OfferDetailsProvider {


  Future<void> addToCart(BuildContext context, Offers offers) async {


    var cartModel = Provider.of<CartModel>(context, listen: false);
        CartItem cartItem = CartItem(
          id: offers.id,
          price: offers.price,
          name: offers.name,
          type: "offer",
          quantity: "1",
          branchId: offers.branchId.toString(),
          currency: offers.currencyName,
          image: offers.imagePath,
          addAr: allTranslations.text("noAdds"),
          isPaidAdd: false

        );

          if (!(await cartModel.findDifferent("special")) && !(await cartModel.findDifferent("prescription_reply")) ) {
            if (await cartModel.findDifferent("product") ||
                await cartModel.findDifferent("offer")) {
              await cartModel.addToCart(
                cartItem : cartItem,
                type: "offer",
                  // offers.areaId.toString()
              );
              await cartModel.loadData();
            }else{
              await cartModel.deleteAll();
              await cartModel.addToCart(
                cartItem : cartItem,
                type: 'offer',
                  // offers.areaId.toString()
              );
              await cartModel.loadData();
            }

          }
          else {
            CustomDialog.showCustomDialog(
                context: context,
                barrierDismissible: true,
                title: allTranslations.text("replaceSpecialProduct"),
                icon: const Icon(
                  Icons.info_outline_rounded,
                  size: 90,
                  color: Colors.grey,
                ),
                withActions: true,
                withYesButton: true,
                withNoButton: true,
                onPressed: () async {

                  await cartModel.deleteAll();
                  await cartModel.addToCart(
                    cartItem : cartItem,
                    type: 'offer',
                    // offers.areaId.toString()
                  );
                  await cartModel.loadData();
                  CustomDialog.hideCustomDialog(context);

                }
            );
          }




/// old work
          // if (!(await cartModel.findDifferent("special")) && !(await cartModel.findDifferent("prescription_reply")) ) {
          //   if (await cartModel.findDifferent("product") ||
          //       await cartModel.findDifferent("offer")) {
          //     if (await cartModel.findDifferentequal(offers.branchId.toString()) == (offers.branchId) && await cartModel.findDifferentequalcurrency(
          //             offers.currency.toString()) == (offers.currency)) {
          //       await cartModel.addToCart(
          //           cartItem, "offer", offers.branchId.toString(),
          //           offers.areaId.toString());
          //
          //       await cartModel.loadData();
          //     }else{
          //       CustomDialog().showCustomDialog(
          //           context: context,
          //           title: Text(
          //             allTranslations.text("replaceSpecialProduct"),
          //             style: Theme
          //                 .of(context)
          //                 .textTheme
          //                 .bodyMedium!!
          //                 .copyWith(
          //                 fontWeight: FontWeight.bold
          //             ),
          //           ),
          //           withActions: true,
          //           withYesButton: true,
          //           withNoButton: true,
          //           onPressed: () async {
          //             await cartModel.deleteAll();
          //             await cartModel.addToCart(
          //                 cartItem, 'offer',offers.branchId.toString(), offers.areaId.toString());
          //
          //             await cartModel.loadData();
          //           }
          //       );
          //
          //       Navigator.of(context);
          //
          //
          //     }
          //   }else{
          //     await cartModel.deleteAll();
          //     await cartModel.addToCart(
          //         cartItem, 'offer', offers.branchId.toString(),
          //         offers.areaId.toString());
          //     await cartModel.loadData();
          //   }
          //
          // }
          // else {
          //   CustomDialog().showCustomDialog(
          //       context: context,
          //       title: Text(
          //         allTranslations.text("replaceSpecialProduct"),
          //         style: Theme
          //             .of(context)
          //             .textTheme
          //             .bodyMedium!!
          //             .copyWith(
          //             fontWeight: FontWeight.bold
          //         ),
          //       ),
          //       withActions: true,
          //       withYesButton: true,
          //       withNoButton: true,
          //       onPressed: () async {
          //         await cartModel.deleteAll();
          //         await cartModel.addToCart(
          //             cartItem, 'offer', offers.branchId.toString(), offers.areaId.toString());
          //         await cartModel.loadData();
          //       }
          //   );
          // }

          }



  }


