
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class SVGPictureAssets extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final Color? imageColor;
  final AlignmentGeometry? alignment;
  const SVGPictureAssets({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.boxFit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.imageColor
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
     image,
     semanticsLabel: 'icon',
      width: width,
      height: height,
      alignment: alignment!,
      fit: boxFit!,
      color: imageColor ?? null,
    );
  }
}
