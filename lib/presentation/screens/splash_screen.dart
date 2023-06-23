import 'package:flutter/material.dart';
import '../../utils/extensions.dart';
import '../../utils/dimens.dart';
import '../../utils/routes.dart';

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
            child: Text(
              'Work Timer',
              style: context.titleLarge.copyWith(color: context.onPrimaryColor),
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
