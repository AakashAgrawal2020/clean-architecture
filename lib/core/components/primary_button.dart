import 'package:clean_architecture/core/components/circular_loader.dart';
import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/textstyles.dart';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget with StyleExtension {
  final String text;
  final ApiStatus? status;
  final VoidCallback onTap;

  const PrimaryButton(
      {super.key,
      required this.text,
      this.status = ApiStatus.initial,
      required this.onTap});

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> with StyleExtension {
  late bool _isButtonTapped;

  @override
  void initState() {
    super.initState();
    _isButtonTapped = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isButtonTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isButtonTapped = false;
        });
      },
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.dm16, vertical: Dimens.dm10),
        decoration: BoxDecoration(
            color: Colours.purple,
            borderRadius: BorderRadius.circular(Dimens.dm10),
            boxShadow: !_isButtonTapped
                ? [
                    BoxShadow(
                        color: colours(context).shadowColor2,
                        spreadRadius: Dimens.dm1,
                        blurRadius: Dimens.dm10,
                        offset: const Offset(Dimens.dm0, Dimens.dm4))
                  ]
                : []),
        child: widget.status != ApiStatus.loading
            ? Text(widget.text,
                style: TextStyles.textStyle1, textAlign: TextAlign.center)
            : const CircularLoader(
                    height: Dimens.dm25,
                    width: Dimens.dm25,
                    color: Colours.white)));
  }
}
