import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:work_timer/db/entities/time.dart';
import 'package:work_timer/db/entities/work_day.dart';
import 'package:work_timer/presentation/stores/work_store.dart';
import 'package:work_timer/utils/dimens.dart';
import 'package:work_timer/utils/extensions.dart';
import 'package:work_timer/utils/i_app_bar.dart';
import 'package:work_timer/utils/x_widgets/x_container.dart';
import 'package:work_timer/utils/x_widgets/x_text.dart';

class MonthDetailsScreen extends StatelessWidget {
  const MonthDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<WorkStore>();
    return Observer(builder: (_) {
      return Scaffold(
        appBar: IAppBar(title: context.l10n.infoOf(store.currentMonth!.name)),
        body: Column(
          children: [
            Observer(builder: (_) {
              return TileItem(
                label: context.l10n.dutyHours,
                value: store.dutyHours.toString(),
              );
            }),
            const SizedBox(height: Dimens.sPadding),
            Observer(builder: (_) {
              return TileItem(
                label: context.l10n.allowAbsenceHours,
                value: store.absenceTime.toString(),
              );
            }),
            if (store.calculatedTime.isNotZero()) ...[
              const SizedBox(height: Dimens.sPadding),
              Observer(builder: (_) {
                return TileItem(
                  label: context.l10n.sumOfCalculatedHours,
                  value: store.calculatedTime.toString(),
                  color: WorkDayType.presence.color,
                );
              }),
            ],
            if (store.remainingTime.isNotZero()) ...[
              const SizedBox(height: Dimens.sPadding),
              Observer(builder: (_) {
                return TileItem(
                  label: store.isOvertime ? context.l10n.overtimeDone : context.l10n.sumOfRemainingHours,
                  value: store.remainingTime.toString(),
                  color: store.progressColor,
                );
              }),
            ],
            if (store.workHours.isNotZero()) ...[
              const SizedBox(height: Dimens.sPadding),
              Observer(builder: (_) {
                return TileItem(
                  label: context.l10n.workedHours,
                  value: store.workHours.toString(),
                  color: WorkDayType.presence.color,
                );
              }),
            ],
            if (store.sumOfUsedAbsenceTime.isNotZero()) ...[
              const SizedBox(height: Dimens.sPadding),
              Observer(builder: (_) {
                return TileItem(
                  label: context.l10n.sumOfAbsenceHours,
                  value: store.sumOfUsedAbsenceTime.toString(),
                  color: WorkDayType.absence.color,
                );
              }),
            ],
            if (store.sumOfRemainingAbsenceTime.isNotZero()) ...[
              const SizedBox(height: Dimens.sPadding),
              Observer(builder: (_) {
                return TileItem(
                  label: context.l10n.reminedAbsenceHours,
                  value: store.sumOfRemainingAbsenceTime.toString(),
                  color: WorkDayType.absence.color,
                );
              }),
            ],
            if (store.sumOfRemoteTime.isNotZero()) ...[
              const SizedBox(height: Dimens.sPadding),
              Observer(builder: (_) {
                return TileItem(
                  label: context.l10n.sumOfRemoteHours,
                  value: store.sumOfRemoteTime.toString(),
                  color: WorkDayType.remote.color,
                );
              }),
            ],
            if (store.sumOfMissionTime.isNotZero()) ...[
              const SizedBox(height: Dimens.sPadding),
              Observer(builder: (_) {
                return TileItem(
                  label: context.l10n.sumOfMissionHours,
                  value: store.sumOfMissionTime.toString(),
                  color: WorkDayType.mission.color,
                );
              }),
            ],
          ],
        ).margin(),
      );
    });
  }
}

class TileItem extends StatelessWidget {
  const TileItem({super.key, required this.label, required this.value, this.color});
  final String label;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return XContainer(
      borderColor: color?.withOpacity(0.2),
      borderRadius: Dimens.sPadding,
      color: color?.withOpacity(0.1) ?? context.primaryContainerColor,
      padding: const EdgeInsets.all(Dimens.mPadding),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        XText(label, style: context.titleMedium),
        const SizedBox(width: Dimens.sPadding),
        XText(value, direction: TextDirection.ltr, color: color, style: context.titleMedium),
        const SizedBox(width: Dimens.sPadding),
        XText(context.l10n.hours, style: context.titleMedium)
      ]),
    );
  }
}
