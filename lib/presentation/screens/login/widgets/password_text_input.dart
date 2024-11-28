import 'package:clean_architecture/core/components/primary_text_input.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/presentation/screens/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordTextInput extends StatelessWidget {
  final FocusNode focusNode;

  const PasswordTextInput({super.key, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, next) => false,
      builder: (context, state) {
        return PrimaryTextInput(
            focusNode: focusNode,
            label: Strings.passwordLabel,
            hintText: Strings.passwordHintText,
            isObscureText: true,
            onChanged: (value) {
              context.read<LoginBloc>().add(PasswordChanged(password: value));
            },
            validator: (value) {
              if (value!.isEmpty) {
                return Strings.emptyPasswordError;
              }
              return null;
            });
      },
    );
  }
}
