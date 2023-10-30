import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:work_timer/utils/app_theme.dart';
import '../../utils/extensions.dart';
import '../../utils/dimens.dart';
import '../../utils/routes.dart';
import '../../utils/x_widgets/x_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    changeStatusBarColor(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        context.pushReplacementNamed(Routes.monthList);
      });
    });
    return Scaffold(
      backgroundColor: context.primaryColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(Dimens.sPadding),
                color: context.primaryContainerColor,
                child: XText(
                  context.l10n.appName,
                  color: context.primaryColor,
                  style: context.titleLarge.copyWith(fontWeight: FontWeight.w900),
                  size: 35.sp,
                  align: TextAlign.center,
                ),
              ),
            ],
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
