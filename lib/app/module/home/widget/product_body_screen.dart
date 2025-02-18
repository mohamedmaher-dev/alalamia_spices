

import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/module/home/widget/second_carousel_slider.dart';
import 'package:flutter/material.dart';

import 'most_selling.dart';
import 'new_arrival.dart';
import 'offers.dart';




class ProductBodyScreen extends StatelessWidget {
   const ProductBodyScreen({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: false,
      children: [

        const MostSelling(),

        15.ph,

        const SecondCarouselSlider(),

        15.ph,

        Offers(),

        15.ph,

        const NewArrival(),




      ],
    );
  }
}
