//
// import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
// import 'package:alalamia_spices/app/exports/services.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:alalamia_spices/app/exports/model.dart';
// import 'package:alalamia_spices/app/exports/widget.dart';
// import '../../../data/model/new_arrival.dart';
// import '../../offers/offer_details_screen.dart';
// import '../../product_details/product_details_screen.dart';
//
// class SecondCarouselSlider extends StatefulWidget {
//   const SecondCarouselSlider({Key? key}) : super(key: key);
//
//   @override
//   State<SecondCarouselSlider> createState() => _SecondCarouselSliderState();
// }
//
// class _SecondCarouselSliderState extends State<SecondCarouselSlider> {
//
//   int _current = 0;
//
//   @override
//   Widget build(BuildContext context) {
//
//     final advertisementModel = Provider.of<AdvertisementSliderModel>(context);
//
//     List _sliderItems = advertisementModel.items.where((element) => element.slideNumber == '2').toList();
//
//     return advertisementModel.isLoading || advertisementModel.loadingFailed
//         ? const CarouseSliderShimmer()
//         : _sliderItems.isEmpty
//         ? 0.ph
//         : CarouselSlider.builder(
//       itemCount: _sliderItems.length,
//       options: CarouselOptions(
//         autoPlay: true,
//         autoPlayInterval: const Duration(seconds: 5),
//         height: 180.h,
//
//         viewportFraction: 1.0,
//         onPageChanged: (index, reason) {
//           setState(() {
//             _current = index;
//           });
//         },
//       ),
//       itemBuilder: (context, index, realIdx) {
//         return InkWell(
//           onTap: (){
//             if (_sliderItems[index].clickType == "offer") {
//               Offers offerData = Offers.fromJson(_sliderItems[index].clickTo);
//
//               pushScreen(context, OfferDetailsScreen(offers : offerData , index: index));
//             }
//             else if (_sliderItems[index].clickType == "product") {
//               Product product = Product.fromJson(_sliderItems[index].clickTo);
//
//               pushScreen(context, ProductDetailsScreen(
//                 product: product,
//               ));
//             }
//           },
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: CustomCachedNetworkImage(
//               width: double.infinity,
//               fit: BoxFit.fill,
//               imageUrl: _sliderItems[index].imagePath,
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//
//
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';



class SecondCarouselSlider extends StatelessWidget {
  const SecondCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {

    final advertisementModel = Provider.of<AdvertisementSliderModel>(context);

    List sliderItems = advertisementModel.items.where((element) => element.slideNumber == '2').toList();

    return CustomCarouselSliders(sliderItems: sliderItems);
  }
}