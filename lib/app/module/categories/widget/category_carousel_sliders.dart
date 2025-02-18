//
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/global_widgets/custom_cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:alalamia_spices/app/exports/model.dart';
// import '../../../data/model/new_arrival.dart';
// import '../../../global_widgets/carousel_slider_shimmer.dart';
// import '../../../services/screen_navigation_service.dart';
// import '../../offers/offer_details_screen.dart';
// import '../../product_details/product_details_screen.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';
//
// class CategoryCarouselSliders extends StatefulWidget {
//    CategoryCarouselSliders({Key? key}) : super(key: key);
//
//   @override
//   State<CategoryCarouselSliders> createState() => _CategoryCarouselSlidersState();
// }
//
// class _CategoryCarouselSlidersState extends State<CategoryCarouselSliders> {
//   int _current = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     final advertisementModel = Provider.of<AdvertisementSliderModel>(context);
//
//     List _sliderItems = advertisementModel.items.where((element) => element.slideNumber == '3').toList();
//
//     return advertisementModel.isLoading || advertisementModel.loadingFailed
//       ? const CarouseSliderShimmer()
//       : _sliderItems.isEmpty
//       ? 0.ph
//       : Column(
//         children: [
//           _sliderItems.isEmpty
//           ? const CarouseSliderShimmer()
//           : CarouselSlider.builder(
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
//                     pushScreen(context , OfferDetailsScreen(offers : offerData , index: index));
//                   }
//                   else if (_sliderItems[index].clickType == "product") {
//                     Product product = Product.fromJson(_sliderItems[index].clickTo);
//
//                     pushScreen(context, ProductDetailsScreen(
//                       product: product,
//
//                     ));
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
//         ]);
//   }
//
//
// }


import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/exports/provider.dart';




class CategoryCarouselSliders extends StatelessWidget {
  const CategoryCarouselSliders({super.key});

  @override
  Widget build(BuildContext context) {
    final advertisementModel = Provider.of<AdvertisementSliderModel>(context);

    List sliderItems = advertisementModel.items.where((element) => element.slideNumber == '3').toList();

    return CustomCarouselSliders(sliderItems: sliderItems);
  }
}