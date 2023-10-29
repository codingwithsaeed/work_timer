import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:work_timer/utils/dimens.dart';
import 'package:work_timer/utils/extensions.dart';
import 'app_colors.dart';

void changeStatusBarColor(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: context.primaryColor,
      //statusBarIconBrightness: Brightness.dark,
      //statusBarBrightness: Brightness.light,
      systemNavigationBarDividerColor: context.primaryColor,
      systemNavigationBarColor: context.primaryColor,
    ),
  );
}

enum FontFamily { comfortaa, vazir, sahel }

ThemeData getTheme(BuildContext context, ThemeScheme theme, {bool isRtl = false}) {
  final scheme = colorSchemeMap[theme];
  return ThemeData(
      fontFamily: context.isFarsi ? FontFamily.sahel.name : FontFamily.comfortaa.name,
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: lightTextTheme,
      scaffoldBackgroundColor: scheme?.background,
      appBarTheme: AppBarTheme(
        elevation: 3,
        centerTitle: true,
        
        backgroundColor: scheme?.primary,
        foregroundColor: scheme?.onPrimary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(Dimens.sPadding),
          bottomLeft: Radius.circular(Dimens.sPadding),
        )),
        titleTextStyle: titleLarge.copyWith(
          color: scheme?.onPrimary,
          fontSize: 22,
          fontFamily: context.isFarsi ? FontFamily.sahel.name : FontFamily.comfortaa.name,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: scheme?.primaryContainer,
        unselectedItemColor: scheme?.scrim.withOpacity(0.7),
        selectedIconTheme: IconThemeData(color: scheme?.secondary),
        selectedLabelStyle: titleSmall.copyWith(color: scheme?.primary),
        enableFeedback: false,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme?.primary,
        foregroundColor: scheme?.onPrimary,
      ));
}

enum ThemeScheme { teal, yellow, deepOrange, red, violet, blue }

final colorSchemeMap = {
  ThemeScheme.teal: createScheme(AppColors.teal),
  ThemeScheme.yellow: createScheme(AppColors.amber, secondary: AppColors.deepOrange),
  ThemeScheme.deepOrange: createScheme(AppColors.deepOrange),
  ThemeScheme.red: createScheme(AppColors.rufous, error: AppColors.amber),
  ThemeScheme.violet: createScheme(AppColors.violet),
  ThemeScheme.blue: createScheme(AppColors.blue),
};

ColorScheme createScheme(Color primary, {Color? secondary, Color? error}) {
  return ColorScheme.light(
    primary: primary,
    secondary: secondary ?? AppColors.amber,
    background: AppColors.background,
    primaryContainer: AppColors.white,
    error: AppColors.errorRed,
    outline: AppColors.outline,
    surface: AppColors.border,
    scrim: AppColors.icon,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    onBackground: AppColors.darkGray,
    onPrimaryContainer: AppColors.darkGray,
    onSurfaceVariant: AppColors.gray,
    onError: AppColors.white,
  );
}

final lightTextTheme = TextTheme(
  titleLarge: titleLarge,
  titleMedium: titleMedium,
  titleSmall: titleSmall,
  bodyLarge: bodyLarge,
  bodyMedium: bodyMedium,
  bodySmall: bodySmall,
);

final titleLarge = TextStyle(
  color: AppColors.darkGray,
  fontSize: 16.sp,
  fontWeight: FontWeight.bold,
);

final titleMedium = TextStyle(
  color: AppColors.darkGray,
  fontSize: 14.sp,
  fontWeight: FontWeight.bold,
);

final titleSmall = TextStyle(
  color: AppColors.darkGray,
  fontSize: 12.sp,
  fontWeight: FontWeight.bold,
);

final bodyLarge = TextStyle(fontSize: 16.sp, color: AppColors.darkGray);
final bodyMedium = TextStyle(fontSize: 14.sp, color: AppColors.darkGray);
final bodySmall = TextStyle(fontSize: 12.sp, color: AppColors.darkGray);
final labelSmall = TextStyle(fontSize: 10.sp, color: AppColors.darkGray);
