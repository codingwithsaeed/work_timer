import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../extensions.dart';
import 'x_container.dart';

class XBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData? icon;
  const XBackButton({super.key, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return XContainer(
      onTap: onTap ?? () => context.pop(),
      width: 35.h,
      height: 35.h,
      borderColor: Colors.transparent,
      color: context.secondaryColor,
      padding: EdgeInsets.only(right: 2.h),
      child: Icon(
        icon ?? (context.isRtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2),
        size: 17.h,
        color: context.onPrimaryColor,
      ).center(),
    );
  }
}
