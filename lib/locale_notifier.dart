import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:work_timer/utils/extensions.dart';

@injectable
class LocaleNotifier extends ChangeNotifier {
  Locale _locale = AppLocalizations.supportedLocales.last;

  Locale get locale => _locale;

  set locale(Locale locale) {
    if (!AppLocalizations.supportedLocales.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void switchLocale(BuildContext context) {
    context.isFarsi ? locale = const Locale('en') : locale = const Locale('fa');
    notifyListeners();
  }
}
