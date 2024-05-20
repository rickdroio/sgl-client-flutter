import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sgl_app_flutter/services/app/app_router.dart';
import 'package:sgl_app_flutter/services/app/getit_setup.dart';
import 'package:sgl_app_flutter/services/app/auth.service.dart';
import 'components/message_alert.dart' as globals;

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Color.fromARGB(255, 27, 12, 231)),
  //textTheme: GoogleFonts.latoTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetit();

  //verificar token antes de iniciar o router
  final authService = GetIt.I.get<AuthService>();
  await authService.checkLoginStatus();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GetIt.I.get<AppRouter>();

    return MaterialApp.router(
      scaffoldMessengerKey: globals.scaffoldMessengerKey,
      //theme: theme,
      routerConfig: router.routes(),
      //routeInformationParser: router.routes().routeInformationParser,
      //routerDelegate: router.routes().routerDelegate,
      //routeInformationProvider: router.routes().routeInformationProvider,
    );
  }
}
