import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/helpers/textstyles.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/main.dart';
import 'package:clean_architecture/presentation/screens/login/widgets/email_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';
import 'widgets/password_text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(loginRepository: getIt()),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.dm20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(Strings.loginScreenHeading, style: TextStyles.textStyle1),
                20.0.verticalSpace,
                const SizedBox(height: 20.0),
                EmailTextInput(focusNode: _emailFocusNode),
                Dimens.dm20.verticalSpace,
                PasswordTextInput(focusNode: _passwordFocusNode),
                Dimens.dm40.verticalSpace,
                // LoginButton(formKey: _formKey)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
