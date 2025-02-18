

import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/model.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';


class OffersDetailsSliders extends StatelessWidget {
  final Offers offers;
  const OffersDetailsSliders({
    Key? key,
    required this.offers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("ooooofer id ${offers.id}");
    return ChangeNotifierProvider<OfferImageModel>(
      create : (context) => OfferImageModel(context  , offers.id.toString()),
      child: Consumer<OfferImageModel>(
        builder: (context , model , child){
          return  Container(
            height: 400.w,

            color: Theme.of(context).primaryColor,
            child: Stack(
              children: [

                model.isLoading || model.loadingFailed
                 ? const CarouseSliderShimmer()
                 : model.items.isNotEmpty
                 ? Swiper(
                  duration: 700,
                  autoplay: true,
                  itemCount: model.items.length,
                  autoplayDelay: 6000,
                  itemBuilder: (BuildContext context,int index){
                    return model.isLoading || model.loadingFailed
                        ? const CarouseSliderShimmer()
                        : CustomCachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 300.w,
                      width: 300.w,
                      imageUrl: model.items[index].imagePath.toString(),
                    );
                  },

                )
                 : CustomCachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: offers.imagePath.toString(),
                  errorImageHeight: 200.h,
                  errorImageWidth: MediaQuery.of(context).size.width,
                ),

                ///  share

                // Positioned(
                //   top: 50,
                //   left: 10,
                //   right: 10,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children:  [
                //
                //       InkWell(
                //         onTap: () {
                //           Share.share("${AppConstants.domain}/${AppConstants.offerDetails}/$offerId");
                //         },
                //         child: Container(
                //           width: 35,
                //           height: 35,
                //           padding: const EdgeInsets.all(3),
                //           decoration: BoxDecoration(
                //               shape: BoxShape.circle,
                //               color: Colors.grey[100]
                //           ),
                //           child: const Padding(
                //             padding:  EdgeInsets.only(left: 2 , right: 2 , top: 1 , bottom: 1),
                //             child: Icon(
                //               Icons.share,
                //               color: Colors.grey,
                //               size: 20,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
