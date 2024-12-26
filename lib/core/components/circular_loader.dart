import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:flutter/material.dart';

class CircularLoader extends StatefulWidget {
  final double height;
  final double width;
  final Color color;

  const CircularLoader(
      {super.key,
      required this.height,
      required this.width,
      required this.color});

  @override
  State<CircularLoader> createState() => _CircularLoaderState();
}

class _CircularLoaderState extends State<CircularLoader> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: CircularProgressIndicator(
                color: widget.color, strokeWidth: Dimens.dm3)));
  }
}
