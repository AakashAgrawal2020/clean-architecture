import 'package:clean_architecture/core/blocs/theme_bloc/theme_bloc.dart';
import 'package:clean_architecture/core/components/customizable_network_image.dart';
import 'package:clean_architecture/core/config/theme/dark_theme_config.dart';
import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/pngs.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/helpers/textstyles.dart';
import 'package:clean_architecture/core/services/product/product_services.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:clean_architecture/core/utils/google_map_util.dart';
import 'package:clean_architecture/data/model/product/product_model.dart';
import 'package:clean_architecture/presentation/screens/products/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapProducts extends StatefulWidget {
  final List<ProductModel> products;
  final AnimationController animationController;

  const GoogleMapProducts(
      {super.key, required this.products, required this.animationController});

  @override
  State<GoogleMapProducts> createState() => _GoogleMapProductsState();
}

class _GoogleMapProductsState extends State<GoogleMapProducts>
    with StyleExtension, SingleTickerProviderStateMixin {
  late GoogleMapController _googleMapController;
  late AnimationController _animationController;
  late String _mapStyle;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    context
        .read<ProductsBloc>()
        .add(const ToggleMapHeightEvent(mapHeight: Dimens.dm100));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: widget.animationController, curve: Curves.easeInOut)),
      child: BlocBuilder<ProductsBloc, ProductsState>(
        buildWhen: (current, previous) {
          return current.selectedProduct != previous.selectedProduct ||
              current.mapHeight != previous.mapHeight;
        },
        builder: (context, state) {
          return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              height: state.mapHeight,
              width: context.contextWidth,
              margin: const EdgeInsets.only(
                  left: Dimens.dm20, right: Dimens.dm20, top: Dimens.dm20),
              decoration: BoxDecoration(
                  color: colours(context).backgroundColor1,
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
                          mapType: MapType.terrain,
                          markers: state.markers,
                          myLocationButtonEnabled: false,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(widget.products[0].coordinates[0],
                                  widget.products[0].coordinates[1]),
                              zoom: 5.0),
                          onMapCreated: (GoogleMapController controller) async {
                            _googleMapController = controller;
                          if (context.read<ThemeBloc>().state.themeData ==
                              darkTheme) {
                            _mapStyle = await GoogleMapUtil.setDarkMapStyle();
                          } else {
                            _mapStyle = await GoogleMapUtil.setLightMapStyle();
                          }
                          _googleMapController.setMapStyle(_mapStyle);
                          if (context.mounted) {
                              await ProductServices()
                                  .initializeMarkers(
                                      context: context,
                                      products: widget.products,
                                      selectedProduct: state.selectedProduct,
                                      googleMapController: _googleMapController,
                                      animationController: _animationController)
                                  .then((Set<Marker> markers) {
                                context
                                    .read<ProductsBloc>()
                                    .add(SetMarkersEvent(markers: markers));
                              });
                            }
                          },
                          onTap: (_) {
                            if (_animationController.isCompleted) {
                              _animationController.reverse().then((_) {
                                context.read<ProductsBloc>().add(
                                    const UpdateSelectedProductEvent(
                                        selectedProduct: null));
                              });
                            }
                          })),
                  if (state.selectedProduct != null)
                    ScaleTransition(
                      scale: Tween<double>(begin: 0, end: 1).animate(
                          CurvedAnimation(
                              parent: _animationController,
                              curve: Curves.ease)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: Dimens.dm4),
                        child: InkWell(
                          onTap: () {
                            _animationController.reverse().then((_) {
                              context.read<ProductsBloc>().add(
                                  const UpdateSelectedProductEvent(
                                      selectedProduct: null));
                            });
                          },
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: context.contextWidth / 2.2,
                              decoration: BoxDecoration(
                                  color: colours(context)
                                      .backgroundColor1
                                      .withOpacity(0.9),
                                  borderRadius:
                                      BorderRadius.circular(Dimens.dm20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colours.black.withOpacity(0.5),
                                        blurRadius: Dimens.dm10,
                                        offset: const Offset(
                                            Dimens.dm5, Dimens.dm5))
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
                                            imgUrl:
                                                state.selectedProduct!.imageUrl,
                                            placeholderImgPath: Pngs.asgardLogo,
                                            imgWidth: Dimens.dm50,
                                            imgHeight: Dimens.dm50,
                                            boxFit: BoxFit.cover,
                                            imgFadeInDuration: 200,
                                            imgFadeOutDuration: 100,
                                            placeholderFadeInDuration: 0,
                                            placeholderPadding: Dimens.dm10,
                                            borderColor:
                                                colours(context).borderColor1,
                                            borderRadius: BorderRadius.circular(
                                                Dimens.dm100)),
                                        Expanded(
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal:
                                                            Dimens.dm10),
                                                child: Text(
                                                    state
                                                        .selectedProduct!.title,
                                                    style: textStyles(context)
                                                        .asgardTextStyle2,
                                                    textAlign:
                                                        TextAlign.center)))
                                      ])),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: Dimens.dm2),
                                      child: Divider(
                                          thickness: Dimens.dm1,
                                          color:
                                              colours(context).borderColor2)),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: Dimens.dm10,
                                          right: Dimens.dm10,
                                          bottom: Dimens.dm10),
                                      child: Text(state.selectedProduct!.body,
                                          style: textStyles(context)
                                              .asgardTextStyle3,
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
                  state.mapHeight == Dimens.dm100
                      ? InkWell(
                          onTap: () {
                            context.read<ProductsBloc>().add(
                                ToggleMapHeightEvent(
                                    mapHeight: context.contextHeight / 2.5));
                          },
                          child: Container(
                              height: Dimens.dm100,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.dm20),
                              decoration: BoxDecoration(
                                  color: Colours.white.withOpacity(0.6),
                                  borderRadius:
                                      BorderRadius.circular(Dimens.dm20)),
                              child: Center(
                                  child: Text(Strings.tapToUnveilMap,
                                      style: TextStyles.textStyle2,
                                      textAlign: TextAlign.center))),
                        )
                      : const SizedBox.shrink()
              ]));
        },
      ),
    );
  }
}
