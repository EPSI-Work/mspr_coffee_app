import 'dart:developer';

import 'package:mspr_coffee_app/presentation/feature/auth/screen/done_profile_setup_screen.dart';
import 'package:mspr_coffee_app/presentation/feature/auth/screen/login_screen.dart';
import 'package:mspr_coffee_app/presentation/feature/auth/screen/password_recovery_screen.dart';
import 'package:mspr_coffee_app/presentation/feature/auth/screen/scan_qr_code_screen.dart';
import 'package:mspr_coffee_app/presentation/feature/auth/screen/signup_screen.dart';
import 'package:mspr_coffee_app/presentation/feature/auth/screen/terms_of_services_screen.dart';
import 'package:mspr_coffee_app/presentation/feature/home/screen/home_screen.dart';
import 'package:mspr_coffee_app/presentation/feature/onBoarding/screen/onBoarding_screen.dart';
import 'package:mspr_coffee_app/src/settings/settings_controller.dart';
import 'package:mspr_coffee_app/src/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  onboarding(path: '/onboarding', screen: OnBoardingScreen()),

  login(path: '/login', screen: LoginScreen()),
  scanQrCode(path: '/scanQrCode', screen: ScanQrCodeScreen()),
  loginFromPasswordRecovery(path: '/loginFromPasswordRecovery'),
  passwordRecovery(path: '/passwordRecovery', screen: PasswordRecoveryScreen()),

  signup(path: '/signup', screen: SignUpScreen()),
  termsOfServices(path: '/termsOfServices', screen: TermsOfServicesScreen()),
  doneProfileSetup(path: '/doneProfileSetup', screen: DoneProfileSetupScreen()),

  home(path: '/home'),
  settings(path: '/settings');

  final String path;
  final Widget? screen;

  const AppRoute({required this.path, this.screen});

  static List<GoRoute> getRoutes() {
    return [
      GoRoute(
        name: AppRoute.home.name,
        path: '${AppRoute.home.path}/:index',
        builder: (_, state) {
          log(state.params['index'].toString());
          return HomeScreen(
            key: state.pageKey,
            index: (state.params['index'] != null)
                ? int.parse(state.params['index'] as String)
                : 0,
          );
        },
      ),
      GoRoute(
        name: AppRoute.settings.name,
        path: AppRoute.settings.path,
        builder: (_, state) {
          return SettingsView(
            controller: (state.params['controller'] != null)
                ? state.params['controller'] as SettingsController
                : null,
          );
        },
      ),
      GoRoute(
        name: AppRoute.onboarding.name,
        path: AppRoute.onboarding.path,
        builder: (context, state) => AppRoute.onboarding.screen!,
      ),
      GoRoute(
        name: AppRoute.login.name,
        path: AppRoute.login.path,
        builder: (context, state) => AppRoute.login.screen!,
      ),
      GoRoute(
        name: AppRoute.scanQrCode.name,
        path: AppRoute.scanQrCode.path,
        builder: (context, state) => AppRoute.scanQrCode.screen!,
      ),
      GoRoute(
        name: AppRoute.loginFromPasswordRecovery.name,
        path: AppRoute.loginFromPasswordRecovery.path,
        builder: (context, state) => AppRoute.login.screen!,
      ),
      GoRoute(
        name: AppRoute.passwordRecovery.name,
        path: AppRoute.passwordRecovery.path,
        builder: (context, state) => AppRoute.passwordRecovery.screen!,
      ),
      GoRoute(
        name: AppRoute.signup.name,
        path: AppRoute.signup.path,
        builder: (context, state) => AppRoute.signup.screen!,
      ),
      GoRoute(
        name: AppRoute.termsOfServices.name,
        path: AppRoute.termsOfServices.path,
        builder: (context, state) => AppRoute.termsOfServices.screen!,
      ),
      GoRoute(
        name: AppRoute.doneProfileSetup.name,
        path: AppRoute.doneProfileSetup.path,
        builder: (context, state) => AppRoute.doneProfileSetup.screen!,
      ),
    ];
  }
}
