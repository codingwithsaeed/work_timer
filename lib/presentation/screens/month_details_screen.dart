import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:work_timer/db/entities/time.dart';
import 'package:work_timer/db/entities/work_day.dart';
import 'package:work_timer/presentation/stores/work_store.dart';
import 'package:work_timer/utils/dimens.dart';
import 'package:work_timer/utils/extensions.dart';
import 'package:work_timer/utils/x_widgets/x_container.dart';
import 'package:work_timer/utils/x_widgets/x_text.dart';

class MonthDetailsScreen extends StatelessWidget {
  const MonthDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<WorkStore>();
    return Observer(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.infoOf(store.currentMonth!.name)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => context.pop(),
          ),
        ),
        body: Column(
          children: [
            Observer(builder: (_) {
              return TileItem(
                label: context.l10n.dutyHours,
                value: store.dutyHours.toString(),
                borderColor: context.outlineColor,
              );
            }),
            const SizedBox(height: Dimens.sPadding),
            Observer(builder: (_) {
              return TileItem(
                label: context.l10n.allowAbsenceHours,
                value: store.absenceTime.toString(),
                borderColor: context.outlineColor,
              );
            }),
            if (store.calculatedTime.isNotZero()) ...[
              const SizedBox(height: Dimens.sPadding),
              Observer(builder: (_) {
                return TileItem(
                  label: context.l10n.sumOfCalculatedHours,
                  value: store.calculatedTime.toString(),
                  valueColor: WorkDayType.presence.color,
                  borderColor: WorkDayType.presence.color,
                );
              }),
            ],
            if (store.remainingTime.isNotZero()) ...[
              const SizedBox(height: Dimens.sPadding),
              Observer(builder: (_) {
                return TileItem(
                  label: context.l10n.sumOfRemainingHours,
                  value: store.remainingTime.toString(),
                  valueColor: store.progressColor,
                  borderColor: store.progressColor,
                );
              }),
            ],
            if (store.workHours.isNotZero()) ...[
              const SizedBox(height: Dimens.sPadding),
              Observer(builder: (_) {
                return TileItem(
                  label: context.l10n.workedHours,
                  value: store.workHours.toString(),
                  valueColor: WorkDayType.presence.color,
                  borderColor: WorkDayType.presence.color,
                );
              }),
            ],
            if (store.sumOfUsedAbsenceTime.isNotZero()) ...[
              const SizedBox(height: Dimens.sPadding),
              Observer(builder: (_) {
                return TileItem(
                  label: context.l10n.sumOfAbsenceHours,
                  value: store.sumOfUsedAbsenceTime.toString(),
                  valueColor: WorkDayType.absence.color,
                  borderColor: WorkDayType.absence.color,
                );
              }),
            ],
            if (store.sumOfRemainingAbsenceTime.isNotZero()) ...[
              const SizedBox(height: Dimens.sPadding),
              Observer(builder: (_) {
                return TileItem(
                  label: context.l10n.reminedAbsenceHours,
                  value: store.sumOfRemainingAbsenceTime.toString(),
                  valueColor: WorkDayType.absence.color,
                  borderColor: WorkDayType.absence.color,
                );
              }),
            ],
            if (store.sumOfRemoteTime.isNotZero()) ...[
              const SizedBox(height: Dimens.sPadding),
              Observer(builder: (_) {
                return TileItem(
                  label: context.l10n.sumOfRemoteHours,
                  value: store.sumOfRemoteTime.toString(),
                  valueColor: WorkDayType.remote.color,
                  borderColor: WorkDayType.remote.color,
                );
              }),
            ],
            if (store.sumOfMissionTime.isNotZero()) ...[
              const SizedBox(height: Dimens.sPadding),
              Observer(builder: (_) {
                return TileItem(
                  label: context.l10n.sumOfMissionHours,
                  value: store.sumOfMissionTime.toString(),
                  valueColor: WorkDayType.mission.color,
                  borderColor: WorkDayType.mission.color,
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
  const TileItem({super.key, required this.label, required this.value, this.valueColor, this.borderColor});
  final String label;
  final String value;
  final Color? borderColor;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return XContainer(
      borderColor: borderColor,
      color: borderColor?.withOpacity(0.2),
      padding: const EdgeInsets.all(Dimens.sPadding),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        XText(label, style: context.titleMedium),
        const SizedBox(width: Dimens.sPadding),
        XText(value, direction: TextDirection.ltr, color: valueColor, style: context.titleMedium),
        const SizedBox(width: Dimens.sPadding),
        XText(context.l10n.hours, style: context.titleMedium)
      ]),
    );
  }
}
