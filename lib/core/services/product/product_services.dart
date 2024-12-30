import 'dart:async';

import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/pngs.dart';
import 'package:clean_architecture/core/utils/google_map_util.dart';
import 'package:clean_architecture/data/model/product/product_model.dart';
import 'package:clean_architecture/presentation/routes/routes.dart';
import 'package:clean_architecture/presentation/screens/products/bloc/products_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProductServices {
  void redirectToDirectionsScreen(BuildContext context, int distance,
      ProductModel product, Position? currentLocation) {
    Navigator.of(context).pushNamed(Routes.directionScreen, arguments: {
      'distance': distance,
      'product': product,
      'currentLocation': currentLocation
    });
  }

  Future<Set<Marker>> initializeMarkers(
      {required BuildContext context,
      required List<ProductModel> products,
      required ProductModel? selectedProduct,
      required GoogleMapController googleMapController,
      required AnimationController animationController}) async {
    BitmapDescriptor customIcon = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(Dimens.dm30, Dimens.dm30)),
        Pngs.asgardLogo);
    Set<Marker> markers = {};
    for (int i = 0; i < products.length; i++) {
      markers.add(Marker(
          markerId: MarkerId('marker_$i'),
          position:
              LatLng(products[i].coordinates[0], products[i].coordinates[1]),
          icon: customIcon,
          onTap: () {
            GoogleMapUtil.animateCameraOnMarkerTap(products[i], googleMapController)
                .whenComplete(() {
              if (selectedProduct == products[i]) {
                animationController.reverse().then((_) {
                  context.read<ProductsBloc>().add(
                      const UpdateSelectedProductEvent(selectedProduct: null));
                });
              } else {
                context.read<ProductsBloc>().add(
                    UpdateSelectedProductEvent(selectedProduct: products[i]));
                animationController.forward();
              }
            });
          }));
    }
    return markers;
  }
}
