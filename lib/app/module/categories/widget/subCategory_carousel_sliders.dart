import 'package:alalamia_spices/app/global_widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class SubCategoryCarouselSliders extends StatelessWidget {
  final String sliderImage;
  const SubCategoryCarouselSliders({super.key, required this.sliderImage});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: CustomCachedNetworkImage(
        width: double.infinity,
        height: 225.h,
        fit: BoxFit.fill,
        imageUrl: sliderImage,
      ),
    );
  }
}

