import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:work_timer/presentation/stores/app_store.dart';
import 'package:work_timer/presentation/stores/work_store.dart';
import 'package:work_timer/utils/extensions.dart';
import 'di/injector.dart';
import 'utils/app_theme.dart';
import 'utils/routes.dart';

final navKey = GlobalKey<NavigatorState>();

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
        Provider(create: (_) => getIt<AppStore>()..init()),
        Provider(create: (_) => getIt<WorkStore>()),
      ],
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          ensureScreenSize: true,
          builder: (context, widget) {
            return Observer(builder: (_) {
              final appStore = context.watch<AppStore>();
              return MaterialApp(
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                navigatorKey: navKey,
                locale: appStore.currentLocal,
                supportedLocales: AppLocalizations.supportedLocales,
                builder: (context, child) => Observer(builder: (context) {
                  return MediaQuery(
                    data: context.withTextScale(1.0),
                    child: Theme(data: getTheme(context, appStore.scheme), child: child!),
                  );
                }),
                debugShowCheckedModeBanner: false,
                initialRoute: Routes.splash,
                onGenerateRoute: Routes.onGenerateRoute,
              );
            });
          },
        );
      },
    );
  }
}
