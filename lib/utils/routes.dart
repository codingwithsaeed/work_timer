import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../presentation/screens/month_list_screen.dart';
import '../presentation/screens/month_days_screen.dart';
import '../presentation/screens/splash_screen.dart';

abstract final class Routes {
  const Routes._();
  static const splash = '/splash';
  static const monthList = '/monthList';
  static const monthDays = '/monthDays';
  static const settings = '/settings';

  static Route<dynamic>? onGenerateRoute(settings) {
    return switch (settings.name) {
      splash => _transition(const SplashScreen()),
      monthList => _transition(const MonthListScreen()),
      monthDays => _transition(const MonthDaysScreen()),
      _ => null,
    };
  }
}

PageTransition<dynamic> _transition(Widget child) {
  return PageTransition(child: child, type: PageTransitionType.fade, isIos: Platform.isIOS);
}
