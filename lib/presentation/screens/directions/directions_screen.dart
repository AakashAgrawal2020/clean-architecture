import 'dart:convert';
import 'dart:ui';

import 'package:clean_architecture/core/components/circular_loader.dart';
import 'package:clean_architecture/core/config/secrets.dart';
import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:clean_architecture/core/utils/maps_util.dart';
import 'package:clean_architecture/data/model/product/product_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class DirectionsScreen extends StatefulWidget {
  final ProductModel product;
  final Position currentLocation;

  const DirectionsScreen(
      {super.key, required this.product, required this.currentLocation});

  @override
  State<DirectionsScreen> createState() => _DirectionsScreenState();
}

class _DirectionsScreenState extends State<DirectionsScreen>
    with StyleExtension {
  late GoogleMapController _googleMapController;
  late Set<Polyline> _polyLines;
  late Set<Marker> _markers;
  late String _sourceName, _destinationName;
  late LatLng _sourceLatLng, _destLatLng;

  @override
  void initState() {
    super.initState();
    _sourceName = '';
    _destinationName = '';
    _polyLines = {};
    _markers = {};
    _sourceLatLng = LatLng(
        widget.currentLocation.latitude, widget.currentLocation.longitude);
    _destLatLng =
        LatLng(widget.product.coordinates[0], widget.product.coordinates[1]);
    _fetchPlaceNames();
  }

  Future<void> _fetchPlaceNames() async {
    String sourceName = await MapsUtil.getPlaceName(
        latitude: _sourceLatLng.latitude, longitude: _sourceLatLng.longitude);
    String destinationName = await MapsUtil.getPlaceName(
        latitude: _destLatLng.latitude, longitude: _destLatLng.longitude);

    setState(() {
      _sourceName = sourceName;
      _destinationName = destinationName;
      _markers = {
        Marker(
            markerId: const MarkerId('source'),
            position: _sourceLatLng,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet)),
        Marker(
            markerId: const MarkerId('dest'),
            position: _destLatLng,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
      };
    });
    await _fetchAndDrawRoute();
    MapsUtil.fitMarkersInView(
        markers: _markers, googleMapController: _googleMapController);
  }

  Future<void> _fetchAndDrawRoute() async {
    String apiKey = Secrets.GOOGLE_MAP_API_KEY;
    final origin = '${_sourceLatLng.latitude},${_sourceLatLng.longitude}';
    final destination = '${_destLatLng.latitude},${_destLatLng.longitude}';

    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);

      if (data['status'] == 'OK') {
        final encodedPoints = data['routes'][0]['overview_polyline']['points'];
        final List<LatLng> polylinePoints =
            MapsUtil.decodePolyline(encodedPoints);
        setState(() {
          _polyLines = {
            Polyline(
                polylineId: const PolylineId('route'),
                points: polylinePoints,
                color: Colours.purple,
                width: Dimens.dm6.toInt())
          };
        });
      } else {
        print('Directions API error: ${data['status']}');
      }
    } catch (e) {
      print('Error fetching route: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours(context).backgroundColor,
      appBar: AppBar(
          title: Text('Directions for ${widget.product.title}',
              style: textStyles(context).asgardTextStyle2),
          backgroundColor: colours(context).backgroundColor,
          surfaceTintColor: colours(context).backgroundColor),
      body: Column(
        children: [
          Expanded(
              child: Stack(children: [
            Stack(
              children: [
                GoogleMap(
                    mapType: MapType.terrain,
                    markers: _markers,
                    initialCameraPosition: CameraPosition(
                        target: _sourceLatLng, zoom: Dimens.dm10),
                    polylines: _polyLines,
                    onMapCreated: (GoogleMapController controller) {
                      _googleMapController = controller;
                      MapsUtil.fitMarkersInView(
                          markers: _markers,
                          googleMapController: _googleMapController);
                    }),
                _polyLines.isEmpty
                    ? BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: Dimens.dm2, sigmaY: Dimens.dm2),
                        child: Container(
                            height: context.contextHeight,
                            width: context.contextWidth,
                            color: Colours.white.withOpacity(0.5),
                            alignment: Alignment.center,
                            child: Text(
                              Strings.identifyingRoute,
                              style: textStyles(context)
                                  .asgardTextStyle2
                                  ?.copyWith(shadows: [
                                Shadow(
                                    blurRadius: Dimens.dm10,
                                    color: Colors.black.withOpacity(0.5),
                                    offset:
                                        const Offset(Dimens.dm2, Dimens.dm2))
                              ]),
                            )),
                      )
                    : const SizedBox.shrink()
              ],
            )
          ])),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: context.contextWidth,
            padding: const EdgeInsets.symmetric(vertical: Dimens.dm20),
            decoration: BoxDecoration(
                color: colours(context).backgroundColor,
                boxShadow: [
                  BoxShadow(
                      color: colours(context).shadowColor1,
                      spreadRadius: Dimens.dm1,
                      blurRadius: Dimens.dm10,
                      offset: const Offset(Dimens.dm0, -Dimens.dm4))
                ]),
            child: _sourceName.isNotEmpty && _destinationName.isNotEmpty
                ? Column(children: [
                    Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: Dimens.dm20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.location_on_rounded,
                                  color: Colours.purple, size: 24),
                              Dimens.dm10.horizontalSpace,
                              Text(_sourceName,
                                  style: textStyles(context).asgardTextStyle2,
                                  textAlign: TextAlign.center)
                            ])),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: Dimens.dm10),
                        child: Stack(alignment: Alignment.center, children: [
                          Divider(color: Colours.purple1, thickness: 1),
                          Icon(Icons.route_rounded,
                              color: Colours.purple, size: 30.0)
                        ])),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: Dimens.dm20,
                            right: Dimens.dm20,
                            bottom: Dimens.dm10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.location_on_rounded,
                                  color: Colours.red, size: 24),
                              Dimens.dm10.horizontalSpace,
                              Text(_destinationName,
                                  style: textStyles(context).asgardTextStyle2,
                                  textAlign: TextAlign.center)
                            ])),
                  ])
                : const Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimens.dm32),
                    child: Stack(alignment: Alignment.center, children: [
                      CircularLoader(
                          height: Dimens.dm50,
                          width: Dimens.dm50,
                          color: Colours.purple),
                      Icon(Icons.route_rounded,
                          color: Colours.purple, size: Dimens.dm30)
                    ])),
          ),
        ],
      ),
    );
  }
}
