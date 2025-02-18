
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/offers/offer_details_screen.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/constants.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import '../../data/model/new_arrival.dart';
import '../product_details/product_details_screen.dart';

class AdsPopupDialog extends StatefulWidget {
  final AdsPopup adsPopup;
  const AdsPopupDialog({super.key, required this.adsPopup});

  @override
  _AdsPopupDialogState createState() => _AdsPopupDialogState();
}

class _AdsPopupDialogState extends State<AdsPopupDialog> {
  @override
  Widget build(BuildContext context) {

    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadius.w))),
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width/1.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
              color: Theme.of(context).primaryColor,
            ),
            child: SizedBox(
                height: 500.0.h,
                child: InkWell(
                  onTap: () {
                    if(widget.adsPopup.clickType=="product")
                    {
                      Product product = Product.fromJson(widget.adsPopup.clickTo);
//
                      pushScreen(context, ProductDetailsScreen(product : product));
                    }
                    else if(widget.adsPopup.clickType=="offer")
                    {
                      Offers offerData = Offers.fromJson(widget.adsPopup.clickTo);

                      pushScreen(context, OfferDetailsScreen( offers: offerData ,  index: 0, ));
                    }
                  },
                  child:  CustomCachedNetworkImage(
                    imageUrl: widget.adsPopup.imagePath.toString(),
                  ),
                )
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(8.0.w),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);

              },
              child: Container(
                  height: 25.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(60.0.w),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Theme.of(context).primaryColor,
                    size: 21.0,
                  )),
            ),
          ),
        ],
      ),
    );

  }

}

class Consts {
  Consts._();
  static const double padding = 1.0;
  static const double avatarRadius = 1.0;
}
