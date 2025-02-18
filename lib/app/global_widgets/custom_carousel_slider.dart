

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/module/offers/offer_details_screen.dart';
import 'package:alalamia_spices/app/module/product_details/product_details_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import '../data/model/new_arrival.dart';
import 'package:alalamia_spices/app/exports/model.dart';


class CustomCarouselSliders extends StatefulWidget {
  final List sliderItems;
  const CustomCarouselSliders({
    super.key,
    required this.sliderItems
  });

  @override
  State<CustomCarouselSliders> createState() => _CustomCarouselSlidersState();
}

class _CustomCarouselSlidersState extends State<CustomCarouselSliders> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {

    final advertisementModel = Provider.of<AdvertisementSliderModel>(context);

    return advertisementModel.isLoading || advertisementModel.loadingFailed
        ?  const CarouseSliderShimmer()
        : widget.sliderItems.isEmpty
        ? 0.ph
        : CarouselSlider.builder(
      itemCount: widget.sliderItems.length,
      // carouselController: _controller,
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        viewportFraction: 1.0,
        height: 225.h,

        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
      itemBuilder: (context, index, realIdx) {

        return InkWell(
          onTap: (){
            if (widget.sliderItems[index].clickType == "offer") {
              Offers offerData = Offers.fromJson(widget.sliderItems[index].clickTo);

              pushScreen(context, OfferDetailsScreen(offers : offerData , index: index));
            }
            else if (widget.sliderItems[index].clickType == "product") {
              Product product = Product.fromJson(widget.sliderItems[index].clickTo);

              pushScreen(context , ProductDetailsScreen(
                product: product,

              ));
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
            child: CustomCachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.fill,
              imageUrl: widget.sliderItems[index].imagePath.toString(),
            ),
          ),
        );
      },
    );


  }
}




