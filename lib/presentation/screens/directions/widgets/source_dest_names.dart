import 'package:clean_architecture/core/components/circular_loader.dart';
import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:flutter/material.dart';

class SourceDestNames extends StatelessWidget with StyleExtension {
  final String sourceName;
  final String destName;

  const SourceDestNames(
      {super.key, required this.sourceName, required this.destName});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: context.contextWidth,
        padding: const EdgeInsets.symmetric(vertical: Dimens.dm20),
        decoration:
            BoxDecoration(color: colours(context).backgroundColor, boxShadow: [
          BoxShadow(
              color: colours(context).shadowColor1,
              spreadRadius: Dimens.dm1,
              blurRadius: Dimens.dm10,
              offset: const Offset(Dimens.dm0, -Dimens.dm4))
        ]),
        child: sourceName.isNotEmpty && destName.isNotEmpty
            ? Column(children: [
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Dimens.dm20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on_rounded,
                              color: Colours.purple, size: Dimens.dm24),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.dm10),
                              child: Text(sourceName,
                                  style: textStyles(context).asgardTextStyle2,
                                  textAlign: TextAlign.center),
                            ),
                          )
                        ])),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.dm10),
                    child: Row(children: [
                      Expanded(
                          child: Container(
                              height: Dimens.dm1, color: Colours.ng100)),
                      const Icon(Icons.route_rounded,
                          color: Colours.purple, size: Dimens.dm30),
                      Expanded(
                          child: Container(
                              height: Dimens.dm1, color: Colours.ng100))
                    ])),
                Padding(
                    padding: const EdgeInsets.only(
                        left: Dimens.dm20,
                        right: Dimens.dm20,
                        bottom: Dimens.dm10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on_rounded,
                              color: Colours.red, size: Dimens.dm24),
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimens.dm10),
                                  child: Text(destName,
                                      style:
                                          textStyles(context).asgardTextStyle2,
                                      textAlign: TextAlign.center)))
                        ])),
              ])
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.dm32),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            height: Dimens.dm1, color: Colours.ng100)),
                    const Stack(alignment: Alignment.center, children: [
                      CircularLoader(
                          height: Dimens.dm50,
                          width: Dimens.dm50,
                          color: Colours.purple),
                      Icon(Icons.route_rounded,
                          color: Colours.purple, size: Dimens.dm30)
                    ]),
                    Expanded(
                        child: Container(
                            height: Dimens.dm1, color: Colours.ng100)),
                  ],
                )));
  }
}
