import 'package:clean_architecture/core/components/flush_bar/customizable_network_image.dart';
import 'package:clean_architecture/core/components/primary_button.dart';
import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/pngs.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:clean_architecture/core/utils/location_permission_handler.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget with StyleExtension {
  final String image;
  final String title;
  final String description;
  final double latitude;
  final double longitude;
  final bool isVisible;

  const ProductCard(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.isVisible,
      required this.latitude,
      required this.longitude});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> with StyleExtension {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
        margin: const EdgeInsets.symmetric(horizontal: Dimens.dm20),
        transform: widget.isVisible
            ? Matrix4.identity()
            : Matrix4.translationValues(-400, 100, 100),
        decoration: BoxDecoration(
            color: colours(context).backgroundColor,
            borderRadius: BorderRadius.circular(Dimens.dm10),
            border: Border.all(
                color: colours(context).tileColor, width: Dimens.dm1),
            boxShadow: [
              BoxShadow(
                  color: colours(context).shadowColor1,
                  spreadRadius: Dimens.dm1,
                  blurRadius: Dimens.dm10,
                  offset: const Offset(Dimens.dm0, Dimens.dm4))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomizableNetworkImage(
                  imgUrl: widget.image,
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
                          '${widget.title} ${widget.title} ${widget.title} ${widget.title}  ${widget.title} ${widget.title} ${widget.title} ',
                          style: textStyles(context).asgardTextStyle2)))
            ]),
            Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimens.dm10, horizontal: Dimens.dm16),
                child: Text(
                    '${widget.description} ${widget.description} ${widget.description} ${widget.description} ${widget.description} ${widget.description}',
                    style: textStyles(context).asgardTextStyle3)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  const Padding(
                      padding: EdgeInsets.only(left: Dimens.dm16),
                      child: Icon(Icons.social_distance_rounded,
                          color: Colours.purple)),
                  Dimens.dm8.horizontalSpace,
                  Text(
                      currentLocation != null
                          ? '${distanceInKms(currentLocation!.latitude, currentLocation!.longitude, widget.latitude, widget.longitude)} Kms'
                          : 'NA',
                      style: textStyles(context).asgardTextStyle2)
                ]),
                Padding(
                  padding: const EdgeInsets.all(Dimens.dm16),
                  child: PrimaryButton(text: 'View Directions', onTap: () {}),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
