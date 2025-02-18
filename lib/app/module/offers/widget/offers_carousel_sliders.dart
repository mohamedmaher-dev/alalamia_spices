//
//
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/exports/services.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:alalamia_spices/app/exports/model.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:alalamia_spices/app/exports/widget.dart';
// import '../../../data/model/new_arrival.dart';
// import '../../product_details/product_details_screen.dart';
// import '../offer_details_screen.dart';
//
// class OffersCarouselSliders extends StatefulWidget {
//   const OffersCarouselSliders({Key? key}) : super(key: key);
//
//   @override
//   State<OffersCarouselSliders> createState() => _OffersCarouselSlidersState();
// }
//
// class _OffersCarouselSlidersState extends State<OffersCarouselSliders> {
//   int _current = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     final advertisementModel = Provider.of<AdvertisementSliderModel>(context);
//
//     List _sliderItems = advertisementModel.items.where((element) => element.slideNumber == '5').toList();
//     return advertisementModel.isLoading || advertisementModel.loadingFailed
//         ? const CarouseSliderShimmer()
//         : _sliderItems.isEmpty
//         ? 0.ph
//         : Column(
//         children: [
//           CarouselSlider.builder(
//             itemCount: _sliderItems.length,
//             options: CarouselOptions(
//               autoPlay: true,
//               autoPlayInterval: const Duration(seconds: 5),
//               viewportFraction: 1.0,
//               height: 225.h,
//
//               onPageChanged: (index, reason) {
//                 setState(() {
//                   _current = index;
//                 });
//               },
//             ),
//             itemBuilder: (context, index, realIdx) {
//
//               return InkWell(
//                 onTap: (){
//                   if (_sliderItems[index].clickType == "offer") {
//                     Offers offerData = Offers.fromJson(_sliderItems[index].clickTo);
//
//                     pushScreen(context, OfferDetailsScreen(offers : offerData , index: index));
//                   }
//                   else if (_sliderItems[index].clickType == "product") {
//                     Product product = Product.fromJson(_sliderItems[index].clickTo);
//
//                    pushScreen(context, ProductDetailsScreen(
//                      product: product,
//
//                    ));
//                   }
//                 },
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   color: Theme.of(context).primaryColor,
//                   child: CustomCachedNetworkImage(
//                     width: double.infinity,
//                     fit: BoxFit.fill,
//                     imageUrl: _sliderItems[index].imagePath,
//                   ),
//                 ),
//               );
//             },
//           ),
//
//
//         ]);
//   }
// }



import 'package:flutter/material.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:provider/provider.dart';




class OffersCarouselSliders extends StatelessWidget {
  const OffersCarouselSliders({super.key});

  @override
  Widget build(BuildContext context) {
    final advertisementModel = Provider.of<AdvertisementSliderModel>(context);

    List sliderItems = advertisementModel.items.where((element) => element.slideNumber == '5').toList();
    return CustomCarouselSliders(sliderItems: sliderItems);
  }
}

