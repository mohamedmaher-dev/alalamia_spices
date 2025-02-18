import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
//import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../offer_details_screen.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';

class OfferBody extends StatelessWidget {
  const OfferBody({super.key});
  // static final facebookAppEvents = FacebookAppEvents();
  @override
  Widget build(BuildContext context) {
    var offersModel = Provider.of<OffersModel>(context);
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300.w,
          mainAxisExtent:
              245.h, // when it is in vertical this control the space vertically
          // childAspectRatio: 3 / 6,
          crossAxisSpacing: 4.w, // the space between them horizontally
          mainAxisSpacing: 5.h),
      itemCount: offersModel.items.length,
      itemBuilder: (context, index) {
        return CustomOfferCard(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: OfferDetailsScreen(
                  offers: offersModel.items[index],
                ),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );

              // facebookAppEvents.logAddToWishlist(
              //     id: offersModel.items[index].id.toString(),
              //     type: 'offer',
              //     currency: "RY",
              //     price: double.parse(offersModel.items[index].price.toString())
              // );
            },
            image: offersModel.items[index].imagePath.toString(),
            name: offersModel.items[index].name.toString());
      },
    );
  }
}
