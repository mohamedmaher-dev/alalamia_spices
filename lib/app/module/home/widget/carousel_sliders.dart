//
// import 'package:alalamia_spices/app/exports/provider.dart';
// import 'package:alalamia_spices/app/module/offers/offer_details_screen.dart';
// import 'package:alalamia_spices/app/module/product_details/product_details_screen.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:alalamia_spices/app/exports/widget.dart';
// import 'package:alalamia_spices/app/exports/services.dart';
//
// import '../../../data/model/new_arrival.dart';
// import '../../../data/model/offers.dart';
//
//
// class CarouselSliders extends StatefulWidget {
//    const CarouselSliders({Key? key}) : super(key: key);
//
//   @override
//   State<CarouselSliders> createState() => _CarouselSlidersState();
// }
//
// class _CarouselSlidersState extends State<CarouselSliders> {
//   int _current = 0;
//
//   @override
//   Widget build(BuildContext context) {
//
//     final advertisementModel = Provider.of<AdvertisementSliderModel>(context);
//
//     List sliderItems = advertisementModel.items.where((element) => element.slideNumber == '1').toList();
//
//
//     return advertisementModel.isLoading || advertisementModel.loadingFailed
//         ?  const CarouseSliderShimmer()
//         : sliderItems.isEmpty
//     ? const CarouseSliderShimmer()
//     : CarouselSlider.builder(
//       itemCount: sliderItems.length,
//       // carouselController: _controller,
//       options: CarouselOptions(
//         autoPlay: true,
//         autoPlayInterval: const Duration(seconds: 5),
//         viewportFraction: 1.0,
//         height: 225.h,
//
//         onPageChanged: (index, reason) {
//           setState(() {
//             _current = index;
//           });
//         },
//       ),
//       itemBuilder: (context, index, realIdx) {
//
//         return InkWell(
//           onTap: (){
//             if (sliderItems[index].clickType == "offer") {
//               Offers offerData = Offers.fromJson(sliderItems[index].clickTo);
//
//               pushScreen(context, OfferDetailsScreen(offers : offerData , index: index));
//             }
//             else if (sliderItems[index].clickType == "product") {
//               Product product = Product.fromJson(sliderItems[index].clickTo);
//
//               pushScreen(context , ProductDetailsScreen(
//                 product: product,
//
//               ));
//             }
//           },
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             color: Theme.of(context).primaryColor,
//             child: CustomCachedNetworkImage(
//               width: double.infinity,
//               fit: BoxFit.fill,
//               imageUrl: sliderItems[index].imagePath.toString(),
//             ),
//           ),
//         );
//       },
//     );
//
//
//   }
//
// }

import 'package:alalamia_spices/app/global_widgets/custom_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
class CarouselSliders extends StatelessWidget {
  const CarouselSliders({super.key});

  @override
  Widget build(BuildContext context) {

    final advertisementModel = Provider.of<AdvertisementSliderModel>(context);

    List sliderItems = advertisementModel.items.where((element) => element.slideNumber == '1').toList();


    return CustomCarouselSliders(sliderItems: sliderItems);


  }
}