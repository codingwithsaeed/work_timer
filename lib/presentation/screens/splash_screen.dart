import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/extensions.dart';
import '../../utils/dimens.dart';
import '../../utils/routes.dart';
import '../../utils/x_widgets/x_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        context.pushReplacementNamed(Routes.monthList);
      });
    });

    return Scaffold(
      backgroundColor: context.primaryColor,
      body: Stack(
        children: [
          Center(
            child: XText(
              'Work Timer',
              color: context.onPrimaryColor,
              style: context.titleLarge.copyWith(fontWeight: FontWeight.w900),
              size: 35.sp,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.mPadding),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator(
                color: context.onPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
