import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomizableNetworkImage extends StatelessWidget {
  final String imgUrl;
  final String placeholderImgPath;
  final double imgWidth;
  final double imgHeight;
  final BoxFit boxFit;
  final int imgFadeInDuration;
  final int imgFadeOutDuration;
  final int placeholderFadeInDuration;
  final double placeholderPadding;
  final BorderRadiusGeometry borderRadius;

  const CustomizableNetworkImage(
      {super.key,
      required this.imgUrl,
      required this.placeholderImgPath,
      required this.imgWidth,
      required this.imgHeight,
      required this.boxFit,
      required this.imgFadeInDuration,
      required this.imgFadeOutDuration,
      required this.placeholderFadeInDuration,
      required this.placeholderPadding,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
          width: imgWidth,
          height: imgHeight,
          fit: boxFit,
          imageUrl: imgUrl,
          placeholder: (context, url) {
            return Padding(
                padding: EdgeInsets.all(placeholderPadding),
                child: Image.asset(placeholderImgPath));
          },
          errorWidget: (context, url, error) {
            return Padding(
                padding: EdgeInsets.all(placeholderPadding),
                child: Image.asset(placeholderImgPath));
          },
          fadeInDuration: Duration(milliseconds: imgFadeInDuration),
          fadeOutDuration: Duration(milliseconds: imgFadeOutDuration),
          placeholderFadeInDuration:
              Duration(milliseconds: placeholderFadeInDuration)),
    );
  }
}
