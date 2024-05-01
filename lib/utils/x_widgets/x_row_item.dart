import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../extensions.dart';
import '../dimens.dart';
import 'x_container.dart';
import 'x_text.dart';

class XRowItem extends StatelessWidget {
  const XRowItem({
    super.key,
    required this.text,
    this.icon,
    this.value,
    this.showTrailingIcon = true,
    this.onTap,
    this.color,
    this.borderColor,
    this.textStyle,
    this.valueStyle,
    this.padding,
    this.margin,
  });
  final String text;
  final String? value;
  final IconData? icon;
  final bool showTrailingIcon;
  final VoidCallback? onTap;
  final Color? color;
  final Color? borderColor;
  final TextStyle? textStyle;
  final TextStyle? valueStyle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return XContainer(
      color: color,
      borderColor: borderColor,
      onTap: onTap,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(Dimens.mPadding),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: context.primaryColor, size: Dimens.lPadding),
            const SizedBox(width: Dimens.sPadding),
          ],
          XText(text, style: textStyle),
          const Spacer(),
          if (value != null) XText(value!, style: valueStyle, color: context.primaryColor),
          if (showTrailingIcon) ...[
            if (value != null) const SizedBox(width: Dimens.sPadding),
            Icon(
              context.isRtl ? Iconsax.arrow_left_2 : Iconsax.arrow_right_3,
              color: context.primaryColor,
            ),
          ],
        ],
      ),
    );
  }
}
