import 'package:flutter/material.dart';
import 'package:work_timer/utils/extensions.dart';
import 'package:work_timer/utils/i_app_bar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IAppBar(title: context.l10n.about),
    );
  }
}
