import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:work_timer/locale_notifier.dart';
import 'package:work_timer/presentation/stores/work_store.dart';
import 'package:work_timer/utils/extensions.dart';
import 'di/injector.dart';
import 'utils/app_theme.dart';
import 'utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => getIt<WorkStore>()),
        ChangeNotifierProvider(create: (_) => getIt<LocaleNotifier>()),
      ],
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, widget) {
            return MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: context.watch<LocaleNotifier>().locale,
              supportedLocales: const [Locale('en'), Locale('fa')],
              builder: (context, child) => MediaQuery(
                data: context.withTextScale(1.0),
                child: Theme(data: getTheme(context, ThemeScheme.violet), child: child!),
              ),
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.splash,
              onGenerateRoute: Routes.onGenerateRoute,
            );
          },
        );
      },
    );
  }
}
