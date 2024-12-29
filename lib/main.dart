import 'package:clean_architecture/core/blocs/theme_bloc/theme_bloc.dart';
import 'package:clean_architecture/core/config/theme/dark_theme_config.dart';
import 'package:clean_architecture/core/service_locator/service_locator.dart';
import 'package:clean_architecture/presentation/routes/route_generator.dart';
import 'package:clean_architecture/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().initServiceLocators();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ThemeBloc()..add(SetThemeEvent(themeData: darkTheme)),
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
          return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: context.read<ThemeBloc>().state.themeData,
              initialRoute: Routes.splashScreen,
              onGenerateRoute: RouteGenerator.generateRoute);
        }));
  }
}
