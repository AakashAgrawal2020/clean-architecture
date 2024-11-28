import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/helpers/textstyles.dart';
import 'package:clean_architecture/core/services/session/session_manager.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.magenta,
        centerTitle: true,
        title: Text(Strings.appBar, style: TextStyles.textStyle2),
        actions: [
          IconButton(
              onPressed: () {
                SessionManager().clearSession();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.loginScreen, (route) => false);
              },
              icon: const Icon(Icons.logout, color: Colours.white)),
          Dimens.dm20.horizontalSpace
        ],
      ),
      body: Center(
        child: Text(Strings.homeScreen, style: TextStyles.textStyle5),
      ),
    );
  }
}
