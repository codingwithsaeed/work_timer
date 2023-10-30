import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:work_timer/locale_notifier.dart';
import 'package:work_timer/utils/x_widgets/x_text_button.dart';
import '../../utils/dialog_utils.dart';
import '../../utils/extensions.dart';
import '../../utils/dimens.dart';
import '../../utils/routes.dart';
import '../../db/entities/month.dart';
import '../../utils/x_widgets/x_text.dart';
import '../stores/work_store.dart';
import 'dialogs/create_month_dialog.dart';

class MonthListScreen extends StatelessWidget {
  const MonthListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = context.read<WorkStore>()..getMonths();
    return Observer(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text(context.l10n.appName), automaticallyImplyLeading: false, actions: [
          IconButton(
              icon: const Icon(Icons.translate),
              onPressed: () {
                log('Switching from ${context.read<LocaleNotifier>().locale}');
                context.read<LocaleNotifier>().switchLocale(context);
              })
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await DialogUtils.showXModalBottomSheetPage<Month?>(
              context,
              content: const CreateMonthDialog(),
            );
            if (result != null) store.insertMonth(result);
          },
          child: const Icon(Icons.add),
        ),
        body: store.isLoading
            ? const Center(child: CircularProgressIndicator())
            : store.months.isEmpty
                ? Center(child: Text(context.l10n.noMonth))
                : Observer(builder: (_) {
                    return ListView.separated(
                      separatorBuilder: (_, __) => const SizedBox(height: Dimens.sPadding),
                      padding: const EdgeInsets.all(Dimens.sPadding),
                      itemBuilder: (_, index) {
                        final month = store.months[index];
                        return MonthItem(
                          month: month,
                          onTap: () {
                            store.setCurrentMonth(month);
                            context.pushNamed(Routes.monthDays);
                          },
                          onDelete: () async {
                            final result = await DialogUtils.showXBottomSheet<bool?>(
                              context,
                              title: context.l10n.deleteMonth,
                              content: context.l10n.doYouWantToDelete(month.name),
                              cancelActionText: context.l10n.cancel,
                              actions: [
                                XTextButton(
                                  text: context.l10n.delete,
                                  color: context.errorColor,
                                  textColor: context.onErrorColor,
                                  onTap: () => context.pop(true),
                                ),
                              ],
                            );
                            if (result != null && result) store.deleteMonth(month);
                          },
                          onEdit: () async {
                            final result = await DialogUtils.showXModalBottomSheetPage<Month?>(
                              context,
                              content: CreateMonthDialog(month: month),
                            );
                            if (result != null) store.updateMonth(result.copyWith(id: month.id));
                          },
                        );
                      },
                      itemCount: store.months.length,
                    );
                  }),
      );
    });
  }
}

class MonthItem extends StatelessWidget {
  final Month month;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const MonthItem({Key? key, required this.month, this.onTap, this.onDelete, this.onEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsetsDirectional.only(start: Dimens.mPadding),
      tileColor: context.primaryContainerColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.mPadding),
        side: BorderSide(color: context.outlineColor),
      ),
      title: XText(month.name, style: context.titleMedium),
      subtitle: XText(context.l10n.dutyHoursOf(month.dutyHours.toString())),
      leading: Icon(Icons.calendar_month_rounded, color: context.outlineColor),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(onPressed: onEdit, icon: Icon(Iconsax.edit_2, color: context.secondaryColor)),
          IconButton(onPressed: onDelete, icon: Icon(Iconsax.trash, color: context.errorColor)),
        ],
      ),
    );
  }
}
