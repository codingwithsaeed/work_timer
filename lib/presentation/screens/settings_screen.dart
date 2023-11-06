import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:work_timer/presentation/stores/app_store.dart';
import 'package:work_timer/utils/app_theme.dart';
import 'package:work_timer/utils/dimens.dart';
import 'package:work_timer/utils/extensions.dart';
import 'package:work_timer/utils/i_app_bar.dart';
import 'package:work_timer/utils/x_widgets/x_container.dart';
import 'package:work_timer/utils/x_widgets/x_text.dart';
import 'package:work_timer/utils/x_widgets/x_text_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<AppStore>();
    return Scaffold(
      appBar: IAppBar(title: context.l10n.settings),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          XContainer(
            borderRadius: Dimens.sPadding,
            color: context.primaryContainerColor,
            padding: const EdgeInsets.all(Dimens.mPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                XText(
                  context.l10n.language,
                  color: context.surfaceColor,
                  style: context.titleLarge,
                ),
                const SizedBox(height: Dimens.sPadding),
                XContainer(
                  color: context.backgroundColor,
                  padding: const EdgeInsets.all(Dimens.sPadding),
                  child: Row(
                    children: AppLocales.values
                        .map(
                          (item) => Observer(builder: (_) {
                            return XTextButton(
                              borderColor: Colors.transparent,
                              color: store.locale == item ? context.primaryColor : context.backgroundColor,
                              textColor:
                                  store.locale == item ? context.onPrimaryColor : context.onPrimaryContainerColor,
                              onTap: () => store.setLocale(item),
                              text: item.nameIn(context),
                            ).expand();
                          }),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          const Gap(Dimens.sPadding),
          XContainer(
            borderRadius: Dimens.sPadding,
            color: context.primaryContainerColor,
            padding: const EdgeInsets.all(Dimens.mPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                XText(
                  context.l10n.theme,
                  color: context.surfaceColor,
                  style: context.titleLarge,
                ),
                const SizedBox(height: Dimens.sPadding),
                XContainer(
                  padding: const EdgeInsets.all(Dimens.sPadding),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ThemeScheme.values.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: Dimens.sPadding,
                        mainAxisSpacing: Dimens.sPadding,
                        childAspectRatio: 1),
                    itemBuilder: (_, inedx) {
                      final item = ThemeScheme.values[inedx];
                      return Observer(builder: (_) {
                        return XContainer(
                          borderColor: Colors.transparent,
                          onTap: () async {
                            store.setTheme(item);
                            await Future.delayed(const Duration(milliseconds: 100));
                            if (context.mounted) changeStatusBarColor(context);
                          },
                          color: getTheme(context, item).colorScheme.primary,
                          child: store.scheme == item
                              ? SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Icon(
                                    Iconsax.tick_square,
                                    color: context.onPrimaryColor,
                                    size: 30,
                                  ))
                              : const SizedBox(width: 50, height: 50),
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ).margin(),
    );
  }
}
