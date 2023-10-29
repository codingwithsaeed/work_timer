import 'package:flutter/material.dart';
import '../extensions.dart';
import '../dimens.dart';

class XText extends StatelessWidget {
  final String title;
  final Color? color;
  final double? size;
  final TextAlign? align;
  final TextStyle? style;
  final TextDirection? direction;
  final EdgeInsetsGeometry? margin;
  const XText(this.title, {Key? key, this.direction, this.color, this.size, this.align, this.style, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(Dimens.zero),
      child: Text(
        title,
        style: style?.copyWith(
              color: color,
              fontSize: size,
            ) ??
            context.bodyMedium.copyWith(
              color: color,
              fontSize: size,
            ),
        textAlign: align,
        overflow: TextOverflow.ellipsis,
        textDirection: direction,
      ),
    );
  }
}
