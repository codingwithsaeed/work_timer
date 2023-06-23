import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
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
    return Provider(
      create: (_) => getIt<WorkStore>(),
      child: Builder(
        builder: (context) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, widget) {
              return MaterialApp(
                builder: (context, child) => MediaQuery(
                  data: context.withTextScale(1.0),
                  child: child!,
                ),
                debugShowCheckedModeBanner: false,
                initialRoute: Routes.splash,
                theme: getTheme(ThemeScheme.violet),
                onGenerateRoute: Routes.onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
