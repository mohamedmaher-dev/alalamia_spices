
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/special_order.dart';



class SpecialOrderProvider {


  Future<void> addToCart(
      {required BuildContext context,
        required String price,
        required String productName,
        required String id,
        required SpecialOrder specialOrder}) async {
    var cartModel = Provider.of<CartModel>(context, listen: false);
    var userModel = Provider.of<UserModel>(context, listen: false);
    CartItem cartItem = CartItem(
      id: id,
      price: price,
      name: productName,
      type: "special",
      quantity: "1",
      branchId: specialOrder.branchId,
      currency: userModel.user.currencyName,
      addAr: allTranslations.text("noAdds"),
      isPaidAdd : false



    );


    if (!(await cartModel.findDifferent("product")) &&
        !(await cartModel.findDifferent("offer")) &&
        !(await cartModel.findDifferent("special"))) {
      await cartModel.addToCart(
        cartItem : cartItem,
        type: "special",
        branch_id : specialOrder.branchId.toString(),
          // specialOrder.branch!.areaId.toString()
      );

      await cartModel.loadData();
    } else {
      bool thereIsSpecialItem = await cartModel.findDifferent("special");
      CustomDialog.showCustomDialog(
          context: context,
          barrierDismissible: false,
          title: !(thereIsSpecialItem)
              ? allTranslations.text("replaceProductSpecial")
              : allTranslations.text("replaceSpecialSpecial"),
          withActions: true,
          withYesButton: true,
          withNoButton: true,
          icon: const Icon(
            Icons.info_outline_rounded,
            size: 90,
            color: Colors.grey,
          ),
          onPressed: () async {
            await cartModel.deleteAll();
            await cartModel.addToCart(
              cartItem :cartItem,
              type: "special",
              branch_id : specialOrder.branchId.toString(),
              // specialOrder.branch!.areaId.toString()
            );
            await cartModel.loadData();
            CustomDialog.hideCustomDialog(context);
          }
      );
    }


  }





}
