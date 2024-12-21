import 'package:clean_architecture/core/components/flush_bar/customizable_network_image.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/pngs.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget with StyleExtension {
  final String image;
  final String title;
  final String description;

  const ProductCard(
      {super.key,
      required this.image,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimens.dm20),
      decoration: BoxDecoration(
          color: colours(context).backgroundColor,
          borderRadius: BorderRadius.circular(Dimens.dm10),
          border:
              Border.all(color: colours(context).tileColor, width: Dimens.dm1),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 4))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomizableNetworkImage(
                  imgUrl: image,
                  placeholderImgPath: Pngs.asgardLogo,
                  imgWidth: Dimens.dm150,
                  imgHeight: Dimens.dm150,
                  boxFit: BoxFit.cover,
                  imgFadeInDuration: 200,
                  imgFadeOutDuration: 100,
                  placeholderFadeInDuration: 0,
                  placeholderPadding: Dimens.dm40,
                  borderRadius: BorderRadius.circular(Dimens.dm10)),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.dm20, vertical: Dimens.dm10),
                      child: Text(
                          '$title $title $title $title  $title $title $title ',
                          style: textStyles(context).asgardTextStyle2)))
            ],
          ),
          Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimens.dm20, horizontal: Dimens.dm16),
              child: Text(
                  '$description $description $description $description $description $description',
                  style: textStyles(context).asgardTextStyle2))
        ],
      ),
    );
  }
}
