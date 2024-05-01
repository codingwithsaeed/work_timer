import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../dimens.dart';
import 'x_text.dart';

class XIconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;
  final Color? textColor;
  final double? iconSize;
  final double? textSize;
  const XIconText({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor,
    this.textColor,
    this.iconSize,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor, size: iconSize ?? Dimens.mPadding + Dimens.xsPadding),
        const SizedBox(width: Dimens.sPadding),
        XText(text, color: textColor, align: TextAlign.center, size: textSize ?? 12.sp),
      ],
    );
  }
}
