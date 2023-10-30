import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:work_timer/db/entities/time.dart';
import 'package:work_timer/presentation/screens/dialogs/create_day_dialog.dart';
import 'package:work_timer/utils/routes.dart';
import 'package:work_timer/utils/x_widgets/x_container.dart';
import 'package:work_timer/utils/x_widgets/x_text.dart';
import 'package:work_timer/utils/x_widgets/x_text_button.dart';
import '../../utils/dialog_utils.dart';
import '../../utils/extensions.dart';
import '../../db/entities/work_day.dart';
import '../../utils/dimens.dart';
import '../stores/work_store.dart';

class MonthDaysScreen extends StatelessWidget {
  const MonthDaysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = context.read<WorkStore>()..getWorkDays();
    return Observer(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(store.currentMonth!.name),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await DialogUtils.showXModalBottomSheetPage<WorkDay?>(
              context,
              content: const CreateDayDialog(),
            );
            if (result != null) {
              final error = await store.insertWorkDay(result);
              if (error != null && context.mounted) {
                toastification.show(
                  context: context,
                  title: error,
                  type: ToastificationType.error,
                  style: ToastificationStyle.fillColored,
                  autoCloseDuration: const Duration(seconds: 3),
                );
              }
            }
          },
          child: const Icon(Icons.add),
        ),
        body: store.isLoading
            ? const Center(child: CircularProgressIndicator())
            : store.workDays.isEmpty
                ? Center(child: Text(context.l10n.noWorkDays))
                : Observer(builder: (_) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Observer(builder: (_) {
                          return XContainer(
                            onTap: () => context.pushNamed(Routes.monthDetails),
                            color: context.primaryContainerColor,
                            borderRadius: Dimens.mPadding,
                            padding: const EdgeInsets.all(Dimens.mPadding),
                            child: Column(
                              children: [
                                LinearPercentIndicator(
                                  percent: store.progressValue,
                                  isRTL: context.isFarsi,
                                  backgroundColor: store.progressColor.withOpacity(0.2),
                                  alignment: MainAxisAlignment.center,
                                  leading: XText(
                                    store.calculatedTime.toString(),
                                    style: context.titleMedium,
                                    direction: TextDirection.ltr,
                                  ),
                                  animation: true,
                                  trailing: XText(
                                    store.currentMonth!.dutyHours.time.toString(),
                                    style: context.titleMedium,
                                    direction: TextDirection.ltr,
                                  ),
                                  center: XText(store.progressText,
                                      size: 12, style: context.titleSmall, direction: TextDirection.ltr),
                                  barRadius: const Radius.circular(Dimens.xsPadding),
                                  progressColor: store.progressColor,
                                  lineHeight: 20,
                                ),
                                const SizedBox(height: Dimens.mPadding),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    XText(
                                      store.remainingTime.toString(),
                                      style: context.titleMedium,
                                      direction: TextDirection.ltr,
                                      color: store.progressColor,
                                    ),
                                    const SizedBox(width: Dimens.sPadding),
                                    XText(
                                      store.isOvertime ? context.l10n.overtimeDone : context.l10n.hoursLeft,
                                      style: context.titleMedium,
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: store.progressColor.withOpacity(0.4),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }).margin(const EdgeInsets.all(Dimens.sPadding)),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: Dimens.sPadding, start: Dimens.mPadding),
                          child: XText(context.l10n.days,
                              style: context.titleMedium, color: context.onPrimaryContainerColor.withOpacity(0.7)),
                        ),
                        ListView.separated(
                          padding: const EdgeInsets.all(Dimens.sPadding),
                          itemCount: store.sortedByDate.length,
                          shrinkWrap: true,
                          separatorBuilder: (_, index) => const SizedBox(height: Dimens.sPadding),
                          itemBuilder: (_, index) {
                            final workDay = store.sortedByDate[index];
                            return WorkDayItem(
                              workDay: workDay,
                              onDelete: () async {
                                final result = await DialogUtils.showXBottomSheet<bool?>(
                                  context,
                                  title: context.l10n.deleteDay,
                                  content: context.l10n.doYouWantToDeleteDay,
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
                                if (result != null && result) store.deleteWorkDay(workDay);
                              },
                              onEdit: () async {
                                final result = await DialogUtils.showXModalBottomSheetPage<WorkDay?>(
                                  context,
                                  content: CreateDayDialog(day: workDay),
                                );
                                if (result != null) store.updateWorkDay(result);
                              },
                            );
                          },
                        ).expand(),
                      ],
                    );
                  }),
      );
    });
  }
}

class WorkDayItem extends StatelessWidget {
  final WorkDay workDay;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  const WorkDayItem({Key? key, required this.workDay, this.onDelete, this.onEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsetsDirectional.only(start: Dimens.mPadding),
      tileColor: context.primaryContainerColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.mPadding),
        side: BorderSide(color: context.outlineColor),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          XText(
            Jalali.fromDateTime(workDay.date).myFormat,
            style: context.titleMedium,
            direction: TextDirection.ltr,
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          XText(
            workDay.type.text(context),
            style: context.bodySmall,
            color: workDay.type.color.withOpacity(0.8),
          ),
          const SizedBox(width: Dimens.mPadding),
          const XText(' - '),
          const SizedBox(width: Dimens.mPadding),
          XText(workDay.arrival.padLeft().toString(), direction: TextDirection.ltr),
          const XText(' - '),
          XText(workDay.exit.padLeft().toString(), direction: TextDirection.ltr),
        ],
      ),
      leading: Icon(Icons.work_history_rounded, color: context.surfaceColor),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onEdit,
            icon: Icon(Iconsax.edit_2, color: context.secondaryColor),
          ),
          IconButton(
            onPressed: onDelete,
            icon: Icon(Iconsax.trash, color: context.errorColor),
          )
        ],
      ),
    );
  }
}

extension JalaliUtils on Jalali {
  String get myFormat {
    final f = formatter;
    return '${f.yyyy} - ${f.mm} - ${f.dd}';
  }
}
