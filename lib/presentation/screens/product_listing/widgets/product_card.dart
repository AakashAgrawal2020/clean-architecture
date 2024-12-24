import 'package:clean_architecture/core/components/customizable_network_image.dart';
import 'package:clean_architecture/core/components/primary_button.dart';
import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/pngs.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:clean_architecture/core/utils/location_permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ProductCard extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final double latitude;
  final double longitude;
  final Position? currentLocation;
  final AnimationController animationController;

  const ProductCard(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.latitude,
      required this.longitude,
      required this.animationController,
      this.currentLocation});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> with StyleExtension {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(-1.0, 0.2), end: Offset.zero)
          .animate(CurvedAnimation(
              parent: widget.animationController, curve: Curves.decelerate)),
      child: FadeTransition(
        opacity:
            widget.animationController.drive(CurveTween(curve: Curves.easeIn)),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: Dimens.dm20),
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
                          padding: EdgeInsets.only(
                              left: Dimens.dm16, right: Dimens.dm6),
                          child: Icon(Icons.social_distance_rounded,
                              color: Colours.purple)),
                      const Icon(Icons.arrow_right_alt_outlined,
                          color: Colours.purple),
                      currentLocation != null
                          ? Padding(
                              padding: const EdgeInsets.only(left: Dimens.dm4),
                              child: Text(
                                  '${distanceInKms(currentLocation!.latitude, currentLocation!.longitude, widget.latitude, widget.longitude)} Kms',
                                  style: textStyles(context).asgardTextStyle2),
                            )
                          : IconButton(
                              onPressed: () async {
                                requestLocationPermission(openSettings: true);
                              },
                              icon: const Icon(Icons.map_outlined))
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(Dimens.dm16),
                      child:
                          PrimaryButton(text: 'View Directions', onTap: () {}),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
