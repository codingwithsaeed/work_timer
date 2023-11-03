import 'package:flutter/material.dart';
import '../extensions.dart';
import '../dimens.dart';

class XContainer extends StatelessWidget {
  final Color? color;
  final Color? borderColor;
  final Widget? child;
  final VoidCallback? onTap;
  final double? borderRadius;
  final double? borderWidth;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final BoxDecoration? decoration;
  const XContainer({
    Key? key,
    this.child,
    this.color,
    this.borderColor,
    this.onTap,
    this.borderRadius,
    this.borderWidth,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin ?? EdgeInsets.zero,
        padding: padding ?? EdgeInsets.zero,
        decoration: decoration?.copyWith(
              color: color,
              border: Border.all(color: borderColor ?? context.outlineColor, width: borderWidth ?? 1),
              borderRadius: borderRadius == null ? null : BorderRadius.circular(borderRadius!),
            ) ??
            BoxDecoration(
              color: color ?? context.backgroundColor,
              border: Border.all(color: borderColor ?? context.outlineColor, width: borderWidth ?? 1),
              borderRadius: BorderRadius.circular(borderRadius ?? Dimens.sPadding),
            ),
        child: child,
      ),
    );
  }
}
