import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:flutter/material.dart';

class PrimaryTextInput extends StatelessWidget {
  final FocusNode focusNode;
  final String label;
  final String hintText;
  final bool? isObscureText;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String> validator;

  const PrimaryTextInput(
      {super.key,
      required this.focusNode,
      required this.label,
      required this.hintText,
      this.isObscureText = false,
      this.onFieldSubmitted,
      required this.onChanged,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onChanged: onChanged,
      validator: validator,
      obscureText: isObscureText!,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.dm100)),
      ),
    );
  }
}
