
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import '../../../data/model/new_arrival.dart';


class ProductDetailsProvider {


  Future<void> addToCart(BuildContext context, Prices price, Product product , String freeAdd , bool isPaidAdds
      // String paidAdd , String paidAddPrice
      ) async {
    var cartModel = Provider.of<CartModel>(context, listen: false);
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold);

    // double priceSum = double.parse(price.price.toString()) + double.parse(paidAddPrice.toString());
    CartItem cartItem = CartItem(
      id: price.id,
      price:  price.price,
      name: "${price.productName!}  ${price.unitName!} ${price.note!}",
      type: "product",
      quantity: "1",
      branchId: product.branch?.id,
      currency: price.currency,
      image: product.image,
      addAr: freeAdd,
      isPaidAdd: isPaidAdds,
      unitName: price.unitName,
      // paidAdd: paidAdd
    );


    if (!(await cartModel.findDifferent("special")) &&
        !(await cartModel.findDifferent("offer_app")) ) {
      if (await cartModel.findDifferent("product") ||
          await cartModel.findDifferent("offer")) {
        if (await cartModel.findDifferentequalcurrency(
            price.currency.toString()) == (price.currency)

        ) {
          await cartModel.addToCart(
            cartItem : cartItem,
            type: "product",
            branch_id : product.branch!.id.toString(),
              // product.branch!.areaId.toString()
          );

          await cartModel.loadData();
        } else {

          CustomDialog.showCustomDialog(
              context: context,
              barrierDismissible: true,
              title: allTranslations.text("replaceBranchProduct"),
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
                  type: "product",
                  branch_id : product.branch!.id.toString(),
                  // product.branch!.areaId.toString()
                );

                await cartModel.loadData();
                CustomDialog.hideCustomDialog(context);

              }
          );
        }
      } else {
        await cartModel.addToCart(
          cartItem : cartItem,
          type: "product",
          branch_id : product.branch!.id.toString(),
            // product.branch!.areaId.toString()
        );
        await cartModel.loadData();
      }
    } else {
      if ((await cartModel.findDifferent("special")) ||
          (await cartModel.findDifferent("offer_app")) ) {

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
                type: 'product',
                branch_id : product.branch!.id.toString(),
                // product.branch!.areaId.toString()
              );

              await cartModel.loadData();
              CustomDialog.hideCustomDialog(context);
            }
        );
      }

    }
  }

}
