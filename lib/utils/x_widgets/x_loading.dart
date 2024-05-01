import 'package:flutter/material.dart';
import '../../../utils/extensions.dart';

class XLoading extends StatelessWidget {
  final Color? color;
  final double strokeWidth;
  const XLoading({
    super.key,
    this.color,
    this.strokeWidth = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? context.primaryColor,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
