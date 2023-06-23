import 'package:flutter/material.dart';
import '../../../utils/extensions.dart';

class XLoading extends StatelessWidget {
  final Color? color;
  final double strokeWidth;
  const XLoading({
    Key? key,
    this.color,
    this.strokeWidth = 1.5,
  }) : super(key: key);

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
