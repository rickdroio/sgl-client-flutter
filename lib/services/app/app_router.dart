import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sgl_app_flutter/home_page.dart';
import 'package:sgl_app_flutter/login_page.dart';
import 'package:sgl_app_flutter/pages/cidade_page.dart';
import 'package:sgl_app_flutter/pages/cor_page.dart';
import 'package:sgl_app_flutter/services/app/auth.service.dart';

final _key = GlobalKey<NavigatorState>();

enum AppRoute { login, home }

class AppRouter {
  final AuthService authService;
  AppRouter(this.authService);

  //final authService = GetIt.I.get<AuthService>();

  routes() {
    return GoRouter(
      navigatorKey: _key,

      /// Forwards diagnostic messages to the dart:developer log() API.
      //debugLogDiagnostics: true,

      /// Initial Routing Location
      initialLocation: '/',

      /// The listeners are typically used to notify clients that the object has been
      /// updated.
      refreshListenable: authService,

      routes: [
        GoRoute(
          path: '/',
          name: AppRoute.home.name,
          builder: (context, state) {
            return const HomePage();
          },
        ),
        GoRoute(
          path: '/${AppRoute.login.name}',
          name: AppRoute.login.name,
          builder: (context, state) {
            return const LoginPage();
          },
        ),
        GoRoute(
            path: '/cidades', builder: (context, state) => const CidadePage()),
        GoRoute(path: '/cores', builder: (context, state) => const CorPage()),
      ],
      redirect: (context, state) {
        /**
      * Your Redirection Logic Code  Here..........
      */
        final isAuthenticated = authService.isLogged;
        print('ROUTER isAuthenticated = $isAuthenticated');

        if (!isAuthenticated) {
          return '/${AppRoute.login.name}';
        } else {
          return null;
        }

        //return isAuthenticated ? '/' : '/${AppRoute.login.name}';

        /*
        /// [state.fullPath] will give current  route Path

        if (state.fullPath == '/${AppRoute.login.name}') {
          return isAuthenticated ? null : '/${AppRoute.login.name}';
        }

        /// null redirects to Initial Location
        return isAuthenticated ? null : '/${AppRoute.splash.name}';
        */
      },
    );
  }
}
