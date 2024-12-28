import 'package:clean_architecture/core/components/circular_loader.dart';
import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:clean_architecture/presentation/screens/directions/bloc/directions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SourceDestNames extends StatelessWidget with StyleExtension {
  final int distance;

  const SourceDestNames({super.key, required this.distance});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.contextWidth,
      padding: const EdgeInsets.symmetric(vertical: Dimens.dm20),
      decoration: BoxDecoration(color: Colours.purple2, boxShadow: [
        BoxShadow(
            color: colours(context).shadowColor1,
            spreadRadius: Dimens.dm1,
            blurRadius: Dimens.dm10,
            offset: const Offset(Dimens.dm0, -Dimens.dm4))
      ]),
      child: BlocBuilder<DirectionsBloc, DirectionsState>(
          builder: (context, state) {
        if (state.geocodeApiStatus == ApiStatus.initial ||
            state.geocodeApiStatus == ApiStatus.loading) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.dm32),
              child: Row(children: [
                Expanded(
                    child: Container(height: Dimens.dm1, color: Colours.ng100)),
                const Stack(alignment: Alignment.center, children: [
                  CircularLoader(
                      height: Dimens.dm50,
                      width: Dimens.dm50,
                      color: Colours.purple),
                  Icon(Icons.route_rounded,
                      color: Colours.purple, size: Dimens.dm30)
                ]),
                Expanded(
                    child: Container(height: Dimens.dm1, color: Colours.ng100))
              ]));
        } else if (state.geocodeApiStatus == ApiStatus.completed) {
          return Column(children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.dm20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.location_on_rounded,
                      color: Colours.blue, size: Dimens.dm24),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.dm10),
                          child: Text(state.sourceName,
                              style: textStyles(context).asgardTextStyle3,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center)))
                ])),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.dm10),
                child: Row(children: [
                  Expanded(
                      child:
                          Container(height: Dimens.dm1, color: Colours.ng100)),
                  Text('$distance Kms',
                      style: textStyles(context).asgardTextStyle5),
                  Expanded(
                      child:
                          Container(height: Dimens.dm1, color: Colours.ng100))
                ])),
            Padding(
                padding: const EdgeInsets.only(
                    left: Dimens.dm20, right: Dimens.dm20, bottom: Dimens.dm10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.location_on_rounded,
                      color: Colours.purple, size: Dimens.dm24),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.dm10),
                          child: Text(state.destName,
                              style: textStyles(context).asgardTextStyle3,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center)))
                ]))
          ]);
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimens.dm10, horizontal: Dimens.dm20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.error, size: Dimens.dm24, color: Colours.red),
                Expanded(
                    child: Text(Strings.identifyingLocationsNameError,
                        textAlign: TextAlign.center,
                        style: textStyles(context).asgardTextStyle3))
              ],
            ),
          );
        }
      }),
    );
  }
}
