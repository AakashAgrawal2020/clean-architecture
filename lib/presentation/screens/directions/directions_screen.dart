import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/textstyles.dart';
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
  final int distance;

  const DirectionsScreen({super.key,
    required this.product,
    required this.currentLocation,
    required this.distance});

  @override
  State<DirectionsScreen> createState() => _DirectionsScreenState();
}

class _DirectionsScreenState extends State<DirectionsScreen>
    with StyleExtension {
  late LatLng _source, _dest;
  GoogleMapController? _googleMapController;
  late String _mapStyle;

  @override
  void initState() {
    super.initState();
    _source = LatLng(
        widget.currentLocation.latitude, widget.currentLocation.longitude);
    _dest =
        LatLng(widget.product.coordinates[0], widget.product.coordinates[1]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colours(context).backgroundColor1,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(Dimens.dm60),
            child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colours.purple, Colours.purple1],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(Dimens.dm16),
                        bottomRight: Radius.circular(Dimens.dm16))),
                child: AppBar(
                    iconTheme: const IconThemeData(color: Colours.ng100),
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colours.white,
                    shadowColor: Colours.black.withOpacity(0.5),
                    title: Text('Directions for ${widget.product.title}',
                        style: TextStyles.textStyle3),
                    centerTitle: true,
                    elevation: 5))),
        body: BlocProvider(
          create: (context) {
            final bloc = DirectionsBloc(mapRepository: getIt());
            bloc.add(FetchDirectionsEvent(source: _source, dest: _dest));
            bloc.add(SetMarkersEvent(source: _source, dest: _dest));
            bloc.add(FetchLocationNamesEvent(source: _source, dest: _dest));
            return bloc;
          },
          child: BlocConsumer<DirectionsBloc, DirectionsState>(
            listenWhen: (previous, current) {
              return previous != current;
            },
            listener: (BuildContext context, DirectionsState state) {
              if (_googleMapController != null && state.markers.isNotEmpty) {
                MapsUtil.fitMarkersInView(
                  markers: state.markers,
                  googleMapController: _googleMapController!,
                );
              }
            },
            builder: (context, state) {
              return Column(children: [
                Expanded(
                    child: Stack(children: [
                  GoogleMap(
                      mapType: MapType.normal,
                      markers: state.markers,
                      myLocationEnabled: true,
                      zoomGesturesEnabled: true,
                      buildingsEnabled: true,
                      trafficEnabled: true,
                      initialCameraPosition:
                          CameraPosition(target: _source, zoom: Dimens.dm10),
                      polylines: {
                        Polyline(
                            polylineId: const PolylineId('route'),
                            points: state.polylinePoints,
                            color: Colours.purple3,
                            width: Dimens.dm6.toInt())
                      },
                      onMapCreated: (GoogleMapController controller) async {
                        _googleMapController = controller;
                        _mapStyle = await MapsUtil.setLightMapStyle();
                        _googleMapController?.setMapStyle(_mapStyle);
                        if (state.markers.isNotEmpty) {
                          MapsUtil.fitMarkersInView(
                              markers: state.markers,
                              googleMapController: _googleMapController!);
                        }
                      }),
                  AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: state.directionsApiStatus == ApiStatus.loading ||
                              state.directionsApiStatus == ApiStatus.initial
                          ? const DirectionsLoading()
                          : const SizedBox.shrink()),
                  AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: state.directionsApiStatus == ApiStatus.error
                          ? const DirectionsError()
                          : const SizedBox.shrink()),
                ])),
                SourceDestNames(distance: widget.distance)
              ]);
            },
          ),
        ));
  }
}
