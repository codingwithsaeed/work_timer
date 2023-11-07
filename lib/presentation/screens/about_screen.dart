import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_timer/presentation/stores/app_store.dart';
import 'package:work_timer/utils/dimens.dart';
import 'package:work_timer/utils/extensions.dart';
import 'package:work_timer/utils/i_app_bar.dart';
import 'package:work_timer/utils/x_widgets/x_text.dart';
import 'package:work_timer/utils/x_widgets/x_text_button.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<AppStore>();
    return Scaffold(
      appBar: IAppBar(title: context.l10n.about),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(Dimens.sPadding),
            child: XText(
              context.l10n.appName,
              color: context.primaryColor,
              style: context.titleLarge.copyWith(fontWeight: FontWeight.w900),
              size: 40.sp,
              align: TextAlign.center,
            ),
          ),
          Observer(builder: (_) {
            return RichText(
              text: TextSpan(
                style: context.titleMedium,
                children: [
                  TextSpan(text: '${context.l10n.version} '),
                  TextSpan(text: store.version),
                ],
              ),
            ).center();
          }),
          // Text(context.l10n.appDesc).center(),
          const Gap(Dimens.sPadding),
          Text(context.l10n.sayYourOpinion).center(),
          const Gap(Dimens.mPadding),
          XTextButton(
            text: context.l10n.contactWithSupport,
            onTap: _launchTelegram,
          ),
          const Spacer(),
          RichText(
            text: TextSpan(
              style: context.bodyMedium.copyWith(color: context.onPrimaryContainerColor.withOpacity(0.8)),
              children: [
                TextSpan(text: context.l10n.madeWith),
                WidgetSpan(
                    child: Icon(Iconsax.heart5, color: context.errorColor).marginSymmetric(horizontal: Dimens.sPadding),
                    alignment: PlaceholderAlignment.middle),
                TextSpan(text: context.l10n.bySaeed),
              ],
            ),
          ).center(),
        ],
      ).marginAll(),
    );
  }

  void _launchTelegram() async {
    try {
      final uri = Uri.parse('tg://resolve?domain=codingwithsaeed');
      final canLaunch = await canLaunchUrl(uri);
      log('can launch: $canLaunch');
      if (canLaunch) await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication);
    } catch (e) {
      log(e.toString());
    }
  }
}
