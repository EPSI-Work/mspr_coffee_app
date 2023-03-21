import 'dart:developer';

import 'package:mspr_coffee_app/presentation/app/app_route.dart';
import 'package:mspr_coffee_app/presentation/app/bloc/app_bloc.dart';
import 'package:mspr_coffee_app/presentation/app/bloc/auth_bloc.dart';
import 'package:mspr_coffee_app/presentation/app/bloc/product_bloc/product_bloc.dart';
import 'package:mspr_coffee_app/presentation/app/bloc/theme_bloc.dart';
import 'package:mspr_coffee_app/presentation/app/bloc/user_bloc.dart';
import 'package:mspr_coffee_app/src/settings/settings_controller.dart';
import 'package:mspr_coffee_app/theme/dark_theme.dart';
import 'package:mspr_coffee_app/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoot extends StatefulWidget {
  final SettingsController settingsController;
  const AppRoot({Key? key, required this.settingsController}) : super(key: key);

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late AuthBloc _authBloc;
  late AppBloc _appBloc;
  late ThemeBloc _themeBloc;
  GoRouter? _router;
  AppStatus? oldAppStatus;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc();
    _appBloc = AppBloc(authBloc: _authBloc);
    if (SchedulerBinding.instance.window.platformBrightness ==
        Brightness.dark) {
      _themeBloc = ThemeBloc()..add(ThemeDarkMode());
    } else {
      _themeBloc = ThemeBloc()..add(ThemeLightMode());
    }
    _router = _goRouter(_appBloc..add(UserLogInState()));
  }

  GoRouter _goRouter(AppBloc appBloc) {
    return GoRouter(
        refreshListenable: GoRouterRefreshStream(appBloc.stream),
        initialLocation: AppRoute.home.path,
        routes: AppRoute.getRoutes(),
        redirect: (state) {
          if (appBloc.state.status != oldAppStatus) {
            oldAppStatus = appBloc.state.status;
            final goingFromHome = state.subloc == AppRoute.home.path;
            final goingFromLogin = state.subloc == AppRoute.login.path;
            final goingFromOnBoarding =
                state.subloc == AppRoute.onboarding.path;

            switch (appBloc.state.status) {
              case AppStatus.login:
                if (!goingFromHome) {
                  return state.namedLocation(AppRoute.home.name,
                      params: {"index": "0"});
                } else if (!goingFromOnBoarding) {
                  return AppRoute.onboarding.path;
                } else {
                  return null;
                }

              case AppStatus.logout:
                if (!goingFromLogin) {
                  return AppRoute.login.path;
                } else {
                  return null;
                }

              default:
                return AppRoute.onboarding.path;
            }
          } else {
            return null;
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.settingsController,
        builder: (BuildContext context, Widget? child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _appBloc,
              ),
              BlocProvider.value(
                value: _themeBloc,
              ),
              BlocProvider.value(
                value: _authBloc,
              ),
              BlocProvider(create: (context) => UserBloc()),
              BlocProvider(create: (context) => ProductBloc()),
            ],
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return MaterialApp.router(
                  routeInformationProvider: _router!.routeInformationProvider,
                  routeInformationParser: _router!.routeInformationParser,
                  routerDelegate: _router!.routerDelegate,
                  title: "Mspr Coffee App",
                  debugShowCheckedModeBanner: false,
                  theme: lightTheme(context),
                  darkTheme: darkTheme(context),
                );
              },
            ),
          );
        });
  }
}
