
import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/exports/provider.dart';


class CartDetails extends StatefulWidget {
  const CartDetails({Key? key}) : super(key: key);

  @override
  State<CartDetails> createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {
  int quantity = 1;

  bool isCartHidden = true;
  bool condition = false;
  @override
  Widget build(BuildContext context) {
    var cartModel = Provider.of<CartModel>(context);
    for(int i = 0; i < cartModel.items.length; i++){
      condition = cartModel.items[i].type == "product" || cartModel.items[i].type == "offer" || cartModel.items[i].type == "special";
    }
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCardIconText(
          icon: CupertinoIcons.info,
          iconColor: Colors.grey,
          itemsName: allTranslations.text("orderDetails"),
          secondIcon: isCartHidden == false
            ? Icons.arrow_forward_ios
            : Icons.arrow_drop_down,
          secondIconColor: Colors.grey,
          borderRadius:  BorderRadius.only(
            topRight: Radius.circular(AppConstants.defaultBorderRadius.w),
            topLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
          ),
          onTap: _toggleCart
        ),

        Visibility(
          visible: isCartHidden,
          child: Container(
            padding: EdgeInsets.all(10.0.w),
            decoration: BoxDecoration(
              borderRadius:  BorderRadius.only(
                bottomRight: Radius.circular(AppConstants.defaultBorderRadius.w),
                bottomLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
              ),
              color: Theme.of(context).primaryColor,
            ),
            child: ListView.separated(
              itemCount: cartModel.nCount,
              shrinkWrap: true,
              primary: false,
              separatorBuilder: (context , _) => 12.ph,
              itemBuilder: (context , index){
                return  Container(
                  height: 100.h,
                  width: MediaQuery.of(context).size.width,
                  padding:  EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                      color: condition && cartModel.items[index].isPaidAdd == false
                          ? Theme.of(context).colorScheme.surface // white color
                          : Theme.of(context).colorScheme.secondary.withOpacity(0.3)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// product name

                            CustomTowText(
                              title: condition && cartModel.items[index].isPaidAdd == false
                                  ? "${allTranslations.text("productName")}: "
                                  : "${allTranslations.text("addName")}: ",
                              textOverflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              titleStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,

                              ),
                              subWidget: SizedBox(
                                width: 130.w,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                      condition && cartModel.items[index].isPaidAdd == false
                                          ? "${cartModel.items[index].name}"
                                          : "${cartModel.items[index].unitName}",
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "cairo"
                                    ),
                                  ),
                                ),
                              ),
                              subTitle: cartModel.items[index].name.toString(),

                            ),


                            /// product price

                            CustomTowText(
                              title: condition && cartModel.items[index].isPaidAdd == false
                                  ? "${allTranslations.text("productPrice")}: "
                                  : "${allTranslations.text("addPrice")}: "  ,
                              titleStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold
                              ),

                              subWidget: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${cartModel.items[index].price}",
                                    style:  Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "cairo",
                                        fontSize: 12.sp
                                    ),
                                  ),
                                  5.pw,
                                  Center(
                                    child: Text(
                                      "${cartModel.items[index].currency}",
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "cairo",
                                          fontSize: 10.sp
                                      ),
                                    ),
                                  )
                                ],
                              ),


                            ),


                            /// increment & decrement & delete icon
                            Row(

                              children: [

                                /// increment & decrement
                                CustomIncDecButtons(
                                  borderRadius: 30.0,
                                  onIncTap: () async {
                                    await cartModel.increment(cartModel.items[index], cartModel.items[index].type, 1);
                                    cartModel.loadData();
                                  },
                                  arrowIncIcon: Icons.arrow_drop_up,
                                  onDecTap: () async {
                                    if (int.parse(cartModel.items[index].quantity) > 1) {
                                      await cartModel.decrement(cartModel.items[index], cartModel.items[index].type);
                                    }
                                  },
                                  arrowDecIcon: Icons.arrow_drop_down,
                                  quantity: cartModel.items[index].quantity.toString(),
                                  borderColor: Theme.of(context).colorScheme.secondary,
                                  backgroundColor: Theme.of(context).primaryColor,
                                  backgroundIconColor: Theme.of(context).colorScheme.surface,
                                  arrowsIconColor: Theme.of(context).secondaryHeaderColor,
                                  iconSize: 20,
                                ),

                                20.pw,

                                InkWell(
                                  onTap: () async{
                                    await cartModel.delete(cartModel.items[index], cartModel.items[index].type);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      3.pw,
                                      Text(
                                          allTranslations.text("delete"),
                                          style: Theme.of(context).textTheme.bodySmall
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),

                      condition && cartModel.items[index].isPaidAdd == false
                       ? Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                          child: CustomCachedNetworkImage(
                            height: 220.h,
                            width: 167.w,
                            fit: BoxFit.cover,
                            imageUrl: cartModel.items[index].image.toString(),
                          ),

                        ),
                      )
                       : 0.ph,
                    ],
                  ),
                );
              },
            ),
          ),
        )
      ],
    );



  }
  void _toggleCart() {
    setState(() {
      isCartHidden = !isCartHidden;
    });
  }
}
