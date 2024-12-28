import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:clean_architecture/core/utils/maps_util.dart';
import 'package:clean_architecture/data/model/product/product_model.dart';
import 'package:clean_architecture/main.dart';
import 'package:clean_architecture/presentation/screens/directions/bloc/directions_bloc.dart';
import 'package:clean_architecture/presentation/screens/directions/widgets/directions_failure.dart';
import 'package:clean_architecture/presentation/screens/directions/widgets/directions_loading.dart';
import 'package:clean_architecture/presentation/screens/directions/widgets/source_dest_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  late String _sourceName, _destName;
  late LatLng _sourceLatLng, _destLatLng;
  late Map<String, dynamic> _directionsQueryParams;

  @override
  void initState() {
    super.initState();
    _sourceName = '';
    _destName = '';
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
      _destName = destinationName;
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
    MapsUtil.fitMarkersInView(
        markers: _markers, googleMapController: _googleMapController);
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
        body: BlocProvider(
          create: (context) {
            final bloc = DirectionsBloc(mapRepository: getIt());
            bloc.add(
                FetchDirectionsEvent(source: _sourceLatLng, dest: _destLatLng));
            return bloc;
          },
          child: Column(children: [
            Expanded(child: BlocBuilder<DirectionsBloc, DirectionsState>(
              builder: (context, state) {
                return Stack(children: [
                  GoogleMap(
                      mapType: MapType.terrain,
                      markers: _markers,
                      initialCameraPosition: CameraPosition(
                          target: _sourceLatLng, zoom: Dimens.dm10),
                      polylines: {
                        Polyline(
                            polylineId: const PolylineId('route'),
                            points: state.polylinePoints,
                            color: Colours.purple,
                            width: Dimens.dm6.toInt())
                      },
                      onMapCreated: (GoogleMapController controller) {
                        _googleMapController = controller;
                        MapsUtil.fitMarkersInView(
                            markers: _markers,
                            googleMapController: _googleMapController);
                      }),
                  state.status == ApiStatus.loading
                      ? const DirectionsLoading()
                      : const SizedBox.shrink(),
                  state.status == ApiStatus.error
                      ? const DirectionsError()
                      : const SizedBox.shrink()
                ]);
              },
            )),
            SourceDestNames(sourceName: _sourceName, destName: _destName)
          ]),
        ));
  }
}
