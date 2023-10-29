import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:work_timer/presentation/screens/month_details_screen.dart';
import '../presentation/screens/month_list_screen.dart';
import '../presentation/screens/month_days_screen.dart';
import '../presentation/screens/splash_screen.dart';

abstract final class Routes {
  const Routes._();
  static const splash = '/splash';
  static const monthList = '/monthList';
  static const monthDetails = '/monthDetails';
  static const monthDays = '/monthDays';
  static const settings = '/settings';

  static Route<dynamic>? onGenerateRoute(settings) {
    return switch (settings.name) {
      splash => const SplashScreen().faded(),
      monthList => const MonthListScreen().faded(),
      monthDetails => const MonthDetailsScreen().faded(),
      monthDays => const MonthDaysScreen().faded(),
      _ => null,
    };
  }
}

extension on Widget {
  PageTransition<dynamic> transition({PageTransitionType type = PageTransitionType.fade}) {
    return PageTransition(child: this, type: PageTransitionType.fade, isIos: Platform.isIOS);
  }

  PageTransition<dynamic> faded() => transition(type: PageTransitionType.fade);
}
