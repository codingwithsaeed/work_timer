import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dimens.dart';

extension FormatedDate on DateTime {
  String get formated => '$year/$month/$day';
  String get formatedHour =>
      '${hour.toString().length == 1 ? '0$hour' : hour}:${minute.toString().length == 1 ? '0$minute' : minute.toString()}';
}

extension EdgeInsetsExtensions on EdgeInsets {
  EdgeInsets only({double? left, double? top, double? right, double? bottom}) {
    return EdgeInsets.only(
      left: left ?? this.left,
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
    );
  }
}

extension GeneralExtensions on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get height => size.height;
  double get width => size.width;

  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  MediaQueryData withTextScale(double scale) => mediaQuery.copyWith(textScaleFactor: scale);
  double getScaledWidth(double scale) => scale * width;
  double getScaledHeight(double scale) => scale * height;
  double getScaledSize(double scale) => scale * (isPortrait ? width : height);

  TextDirection get _direction => Directionality.of(this);
  String get _textDirection => _direction.name.toLowerCase();
  bool get isRtl => _textDirection == TextDirection.rtl.name.toLowerCase();
  bool get isLtr => _textDirection == TextDirection.ltr.name.toLowerCase();

  void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  Locale get local => Localizations.localeOf(this);
  bool get isFarsi => local == const Locale('fa');
}

extension ThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get _textTheme => theme.textTheme;

  TextStyle get titleLarge => _textTheme.titleLarge!;
  TextStyle get titleMedium => _textTheme.titleMedium!;
  TextStyle get titleSmall => _textTheme.titleSmall!;
  TextStyle get primaryTitleLarge => _textTheme.titleLarge!.copyWith(color: primaryColor);
  TextStyle get primaryTitleMedium => _textTheme.titleMedium!.copyWith(color: primaryColor);
  TextStyle get primaryTitleSmall => _textTheme.titleSmall!.copyWith(color: primaryColor);

  TextStyle get bodyLarge => _textTheme.bodyLarge!;
  TextStyle get bodyMedium => _textTheme.bodyMedium!;
  TextStyle get bodySmall => _textTheme.bodySmall!;
  TextStyle get primaryBodyLarge => _textTheme.bodyLarge!.copyWith(color: primaryColor);
  TextStyle get primaryBodyMedium => _textTheme.bodyMedium!.copyWith(color: primaryColor);
  TextStyle get primaryBodySmall => _textTheme.bodySmall!.copyWith(color: primaryColor);

  ColorScheme get _colorScheme => theme.colorScheme;

  Color get primaryColor => _colorScheme.primary;
  Color get secondaryColor => _colorScheme.secondary;
  Color get backgroundColor => _colorScheme.background;
  Color get primaryContainerColor => _colorScheme.primaryContainer;
  Color get surfaceColor => _colorScheme.surface;
  Color get outlineColor => _colorScheme.outline;
  Color get scrimColor => _colorScheme.scrim;
  Color get errorColor => _colorScheme.error;
  Color get onPrimaryColor => _colorScheme.onPrimary;
  Color get onSecondaryColor => _colorScheme.onSecondary;
  Color get onBackgroundColor => _colorScheme.onBackground;
  Color get onSurfaceColor => _colorScheme.onSurface;
  Color get onSurfaceVarientColor => _colorScheme.onSurfaceVariant;
  Color get onErrorColor => _colorScheme.onError;
  Color get onPrimaryContainerColor => _colorScheme.onPrimaryContainer;
  Color get onSecondaryContainerColor => _colorScheme.onSecondaryContainer;

  bool get isDark => theme.brightness == Brightness.dark;
  bool get isLight => theme.brightness == Brightness.light;
}

extension NavigateExtensions on BuildContext {
  NavigatorState get _navigator => Navigator.of(this);

  void pop<T extends Object?>([T? result]) => _navigator.pop<T>(result);

  Future<T?> pushNamed<T extends Object?>(String routeName, {Object? arguments}) {
    return _navigator.pushNamed<T>(routeName, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return _navigator.pushReplacementNamed<T, TO>(routeName, arguments: arguments, result: result);
  }
}

extension WidgetExtensions on Widget {
  Widget center() => Center(child: this);
  Widget expand({int flex = 1}) => Expanded(flex: flex, child: this);
  Widget containColor(Color color) => Container(color: color, child: this);

  Widget margin([EdgeInsetsGeometry margin = const EdgeInsets.all(Dimens.sPadding)]) =>
      Padding(padding: margin, child: this);

  Widget marginAll([double margin = Dimens.sPadding]) => Padding(padding: EdgeInsets.all(margin), child: this);

  Widget marginLTRB([
    double left = Dimens.zero,
    double top = Dimens.zero,
    double right = Dimens.zero,
    double bottom = Dimens.zero,
  ]) =>
      Padding(padding: EdgeInsets.fromLTRB(left, top, right, bottom), child: this);

  Widget marginSymmetric({double? vertical, double? horizontal}) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: vertical ?? Dimens.zero,
          horizontal: horizontal ?? Dimens.zero,
        ),
        child: this,
      );

  Widget marginOnly({double? left, double? top, double? right, double? bottom}) => Padding(
        padding: EdgeInsets.only(
          left: left ?? Dimens.zero,
          top: top ?? Dimens.zero,
          right: right ?? Dimens.zero,
          bottom: bottom ?? Dimens.zero,
        ),
        child: this,
      );
}
