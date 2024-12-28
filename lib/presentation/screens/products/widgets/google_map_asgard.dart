import 'package:clean_architecture/core/components/customizable_network_image.dart';
import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/pngs.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/helpers/textstyles.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:clean_architecture/core/utils/maps_util.dart';
import 'package:clean_architecture/data/model/product/product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapAsgard extends StatefulWidget {
  final List<ProductModel> products;
  final AnimationController animationController;

  const GoogleMapAsgard(
      {super.key, required this.products, required this.animationController});

  @override
  State<GoogleMapAsgard> createState() => _GoogleMapAsgardState();
}

class _GoogleMapAsgardState extends State<GoogleMapAsgard>
    with StyleExtension, SingleTickerProviderStateMixin {
  final Set<Marker> _markers = {};
  BitmapDescriptor? _customIcon;
  ProductModel? _selectedProduct;
  GoogleMapController? _mapController;
  late AnimationController _markerAnimationController;
  late double _mapHeight;

  @override
  void initState() {
    super.initState();
    _markerAnimationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _mapHeight = 100;
  }

  @override
  void dispose() {
    _markerAnimationController.dispose();
    super.dispose();
  }

  Future<void> _initializeMarkers() async {
    _customIcon = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(Dimens.dm30, Dimens.dm30)),
        Pngs.asgardLogo);

    for (int i = 0; i < widget.products.length; i++) {
      _markers.add(Marker(
          markerId: MarkerId('marker_$i'),
          anchor: const Offset(1, 1),
          position: LatLng(widget.products[i].coordinates[0],
              widget.products[i].coordinates[1]),
          icon: _customIcon ?? BitmapDescriptor.defaultMarker,
          onTap: () {
            MapsUtil.animateCameraOnMarkerTap(
                    widget.products[i], _mapController)
                .whenComplete(() {
              if (_selectedProduct == widget.products[i]) {
                _markerAnimationController.reverse().then((_) {
                  setState(() {
                    _selectedProduct = null;
                  });
                });
              } else {
                setState(() {
                  _selectedProduct = widget.products[i];
                });
                _markerAnimationController.forward();
              }
            });
          }));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: widget.animationController, curve: Curves.easeInOut)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        height: _mapHeight,
        width: context.contextWidth,
        margin: const EdgeInsets.symmetric(horizontal: Dimens.dm20),
        decoration: BoxDecoration(
            color: colours(context).backgroundColor,
            borderRadius: BorderRadius.circular(Dimens.dm20),
            boxShadow: [
              BoxShadow(
                  color: colours(context).shadowColor1,
                  spreadRadius: Dimens.dm1,
                  blurRadius: Dimens.dm10,
                  offset: const Offset(Dimens.dm0, Dimens.dm4))
            ]),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.dm20),
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  mapType: MapType.terrain,
                  markers: _markers,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(widget.products[0].coordinates[0],
                          widget.products[0].coordinates[1]),
                      zoom: 5.0),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                    _initializeMarkers();
                  },
                  onTap: (_) {
                    if (_markerAnimationController.isCompleted) {
                      _markerAnimationController.reverse().then((_) {
                        setState(() {
                          _selectedProduct = null;
                        });
                      });
                    }
                  },
                )),
            if (_selectedProduct != null)
              ScaleTransition(
                scale: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                    parent: _markerAnimationController, curve: Curves.ease)),
                child: Padding(
                  padding: const EdgeInsets.only(top: Dimens.dm10),
                  child: InkWell(
                    onTap: () {
                      _markerAnimationController.reverse().then((_) {
                        setState(() {
                          _selectedProduct = null;
                        });
                      });
                    },
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: context.contextWidth / 2.2,
                        decoration: BoxDecoration(
                            color: Colours.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(Dimens.dm20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colours.black.withOpacity(0.5),
                                  blurRadius: Dimens.dm10,
                                  offset: const Offset(Dimens.dm5, Dimens.dm5))
                            ]),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: Dimens.dm10,
                                    right: Dimens.dm10,
                                    top: Dimens.dm10),
                                child: Row(children: [
                                  CustomizableNetworkImage(
                                      imgUrl: _selectedProduct!.imageUrl,
                                      placeholderImgPath: Pngs.asgardLogo,
                                      imgWidth: Dimens.dm50,
                                      imgHeight: Dimens.dm50,
                                      boxFit: BoxFit.cover,
                                      imgFadeInDuration: 200,
                                      imgFadeOutDuration: 100,
                                      placeholderFadeInDuration: 0,
                                      placeholderPadding: Dimens.dm10,
                                      borderRadius:
                                          BorderRadius.circular(Dimens.dm100)),
                                  Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: Dimens.dm10),
                                          child: Text(_selectedProduct!.title,
                                              style: textStyles(context)
                                                  .asgardTextStyle1,
                                              textAlign: TextAlign.center)))
                                ])),
                            const Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: Dimens.dm2),
                                child: Divider(
                                    thickness: Dimens.dm2,
                                    color: Colours.ng200)),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: Dimens.dm10,
                                    right: Dimens.dm10,
                                    bottom: Dimens.dm10),
                                child: Text(_selectedProduct!.body,
                                    style: textStyles(context).asgardTextStyle3,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            _mapHeight == Dimens.dm100
                ? InkWell(
                    onTap: () {
                      setState(() {
                        _mapHeight = context.contextHeight / 2.5;
                      });
                    },
                    child: Container(
                        height: Dimens.dm100,
                        padding:
                            const EdgeInsets.symmetric(horizontal: Dimens.dm20),
                        decoration: BoxDecoration(
                            color: Colours.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(Dimens.dm20)),
                        child: Center(
                            child: Text(Strings.tapToUnveilMap,
                                style: TextStyles.textStyle2,
                                textAlign: TextAlign.center))),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
