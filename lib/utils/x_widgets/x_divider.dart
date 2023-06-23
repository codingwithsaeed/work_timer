import 'package:flutter/material.dart';
import '../extensions.dart';
class XDivider extends StatelessWidget {
  final Color? color;
  final double? thickness;
  final double? height;
  final double? indent;
  const XDivider({super.key, this.color, this.thickness, this.height, this.indent});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? context.outlineColor,
      thickness: thickness,
      height: height,
      indent: indent,
      endIndent: indent,
    );
  }
}
