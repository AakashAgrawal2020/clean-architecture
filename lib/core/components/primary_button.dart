import 'package:clean_architecture/core/components/circular_loader.dart';
import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/textstyles.dart';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final ApiStatus? status;
  final VoidCallback onTap;

  const PrimaryButton(
      {super.key,
      required this.text,
      this.status = ApiStatus.initial,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.dm100),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.dm18, vertical: Dimens.dm8),
        decoration: BoxDecoration(
            color: Colours.black,
            borderRadius: BorderRadius.circular(Dimens.dm100),
            shape: BoxShape.rectangle),
        child: Center(
          child: status != ApiStatus.loading
              ? Text(text,
                  style: TextStyles.textStyle3, textAlign: TextAlign.center)
              : const CircularLoader(
                  height: Dimens.dm25,
                  width: Dimens.dm25,
                  color: Colours.white),
        ),
      ),
    );
  }
}
