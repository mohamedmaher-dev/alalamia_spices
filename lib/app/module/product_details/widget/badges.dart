import 'package:alalamia_spices/app/data/model/cart.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/exports/provider.dart';

class Badges extends StatelessWidget {
  const Badges({super.key, this.textOnly = false});
  final bool textOnly;

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context, listen: false);

    if (!textOnly) {
      return Consumer<CartModel>(builder: (context, model, child) {
        var cartList =
            model.items.where((element) => element.isPaidAdd == false).toList();
        return badges.Badge(
            showBadge: model.items.isEmpty ? false : true,
            position: badges.BadgePosition.topStart(top: -20, start: -13),
            badgeContent: Text(cartList.length.toString(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 10.sp,
                    fontFamily: "cairo")),
            badgeAnimation: const badges.BadgeAnimation.rotation(
              animationDuration: Duration(seconds: 1),
              colorChangeAnimationDuration: Duration(seconds: 1),
              loopAnimation: false,
              curve: Curves.fastOutSlowIn,
              colorChangeAnimationCurve: Curves.easeInCubic,
            ),
            badgeStyle: badges.BadgeStyle(
              shape: badges.BadgeShape.circle,
              badgeColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              padding: EdgeInsets.all(8.h),
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  width: 2),
            ),
            child: Icon(
              CupertinoIcons.cart,
              size: 20,
              color: themeModel.darkTheme == false
                  ? Theme.of(context).primaryColor
                  : Colors.white,
            ));
      });
    } else {
      return Consumer<CartModel>(
        builder: (context, model, child) {
          if (model.items.isEmpty) {
            return Icon(
              CupertinoIcons.cart,
            );
          } else {
            return Badge(
              label: Text(
                model.items.length.toString(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 10.sp,
                      fontFamily: "cairo",
                    ),
              ),
              child: Icon(
                CupertinoIcons.cart,
              ),
            );
          }
        },
      );
    }
  }
}
