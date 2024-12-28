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
  late LatLng _source, _dest;
  GoogleMapController? _googleMapController;

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
        backgroundColor: colours(context).backgroundColor,
        appBar: AppBar(
            title: Text('Directions for ${widget.product.title}',
                style: textStyles(context).asgardTextStyle2),
            backgroundColor: colours(context).backgroundColor,
            surfaceTintColor: colours(context).backgroundColor),
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
                      mapType: MapType.terrain,
                      markers: state.markers,
                      initialCameraPosition:
                          CameraPosition(target: _source, zoom: Dimens.dm10),
                      polylines: {
                        Polyline(
                            polylineId: const PolylineId('route'),
                            points: state.polylinePoints,
                            color: Colours.purple,
                            width: Dimens.dm6.toInt())
                      },
                      onMapCreated: (GoogleMapController controller) {
                        _googleMapController = controller;
                        if (state.markers.isNotEmpty) {
                          MapsUtil.fitMarkersInView(
                              markers: state.markers,
                              googleMapController: _googleMapController!);
                        }
                      }),
                  state.apiStatus == ApiStatus.loading
                      ? const DirectionsLoading()
                      : const SizedBox.shrink(),
                  state.apiStatus == ApiStatus.error
                      ? const DirectionsError()
                      : const SizedBox.shrink()
                ])),
                const SourceDestNames()
              ]);
            },
          ),
        ));
  }
}
