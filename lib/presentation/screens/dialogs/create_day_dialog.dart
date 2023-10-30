import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:work_timer/db/entities/work_day.dart';
import 'package:work_timer/presentation/screens/month_days_screen.dart';
import 'package:work_timer/presentation/stores/work_store.dart';
import 'package:work_timer/utils/extensions.dart';
import 'package:work_timer/utils/x_widgets/x_container.dart';
import 'package:work_timer/utils/x_widgets/x_text.dart';
import 'package:work_timer/utils/x_widgets/x_text_button.dart';

import '../../../db/entities/time.dart';
import '../../../utils/dialog_utils.dart';
import '../../../utils/dimens.dart';
part 'create_day_dialog.g.dart';

class CreateDayStore = _CreateDayStoreBase with _$CreateDayStore;

abstract class _CreateDayStoreBase with Store {
  final int monthId;
  _CreateDayStoreBase(this.monthId);

  @observable
  WorkDay? workDayToEdit;
  @action
  void setWorkDay(WorkDay? workDay) => workDayToEdit = workDay;

  void init(WorkDay? workDay) {
    setWorkDay(workDay);
    setDate(workDay?.date);
    setArrival(workDay?.arrival);
    setExit(workDay?.exit);
    setType(workDay?.type ?? WorkDayType.presence);
  }

  @observable
  DateTime? date;
  @action
  void setDate(DateTime? date) => this.date = date;

  @computed
  String? get dateText {
    if (date == null) return null;
    return Jalali.fromDateTime(date!).myFormat;
  }

  @observable
  Time? arrival;
  @action
  void setArrival(Time? arrival) => this.arrival = arrival;

  @computed
  String? get arrivalText {
    if (arrival == null) return null;
    return arrival!.padLeft().toString();
  }

  @observable
  Time? exit;
  @action
  void setExit(Time? exit) => this.exit = exit;

  @computed
  String? get exitText {
    if (exit == null) return null;
    return exit!.padLeft().toString();
  }

  @observable
  WorkDayType type = WorkDayType.presence;
  @action
  void setType(WorkDayType type) => this.type = type;

  @computed
  bool get isValid => date != null && arrival != null && exit != null;

  @computed
  bool get canEdit => isValid && workDay != null && workDayToEdit != null && !workDay!.isEqualTo(workDayToEdit!);

  @computed
  WorkDay? get workDay =>
      isValid ? WorkDay(date: date!, arrival: arrival!, exit: exit!, type: type, monthId: monthId) : null;
}

class CreateDayDialog extends StatelessWidget {
  final WorkDay? day;
  const CreateDayDialog({Key? key, this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workStore = context.read<WorkStore>();
    return Provider(
      create: (_) => CreateDayStore(workStore.currentMonth!.id!),
      child: Builder(builder: (context) {
        final store = context.read<CreateDayStore>()..init(day);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            XText(
              day == null ? context.l10n.createDay : context.l10n.editDay,
              style: context.titleLarge,
              align: TextAlign.center,
            ),
            const SizedBox(height: Dimens.mPadding),
            Observer(builder: (_) {
              return XTextButton(
                onTap: () async {
                  final date = await DialogUtils.showDatePicker(context);
                  if (date != null) store.setDate(date);
                },
                color: context.backgroundColor,
                borderColor: context.outlineColor,
                text: store.dateText ?? context.l10n.selectDate,
                textDirection: TextDirection.ltr,
              );
            }),
            const SizedBox(height: Dimens.sPadding),
            Row(
              children: [
                Observer(builder: (_) {
                  return XTextButton(
                    color: context.backgroundColor,
                    borderColor: context.outlineColor,
                    onTap: () async {
                      final arrival = await showPersianTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (arrival != null) {
                        store.setArrival(
                          Time(hour: arrival.hour.toString(), minute: arrival.minute.toString()),
                        );
                      }
                    },
                    text: store.arrivalText ?? context.l10n.arrivalTime,
                  );
                }).expand(),
                const SizedBox(width: Dimens.mPadding),
                Observer(builder: (_) {
                  return XTextButton(
                    color: context.backgroundColor,
                    borderColor: context.outlineColor,
                    onTap: () async {
                      final exit = await showPersianTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (exit != null) {
                        store.setExit(
                          Time(hour: exit.hour.toString(), minute: exit.minute.toString()),
                        );
                      }
                    },
                    text: store.exitText ?? context.l10n.exitTime,
                  );
                }).expand(),
              ],
            ),
            const SizedBox(height: Dimens.sPadding + Dimens.xsPadding),
            XContainer(
              padding: const EdgeInsets.all(Dimens.sPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: WorkDayType.values.map(
                  (e) {
                    return Observer(builder: (_) {
                      return RadioListTile<WorkDayType>(
                        value: e,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        controlAffinity: ListTileControlAffinity.leading,
                        groupValue: store.type,
                        contentPadding: EdgeInsets.zero,
                        tileColor: context.primaryColor,
                        visualDensity: VisualDensity.compact,
                        selectedTileColor: context.primaryColor,
                        selected: store.type == e,
                        hoverColor: context.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimens.sPadding),
                          side: BorderSide(color: context.outlineColor),
                        ),
                        title: XText(
                          e.text(context),
                        ),
                        dense: true,
                        onChanged: (type) => store.setType(type ?? WorkDayType.presence),
                      );
                    });
                  },
                ).toList(),
              ),
            ),
            if (day != null) ...[
              const SizedBox(height: Dimens.sPadding + Dimens.xsPadding),
              Observer(builder: (_) {
                return XTextButton(
                  onTap: store.canEdit ? () => context.pop<WorkDay>(store.workDay?.copyWith(id: day?.id)) : null,
                  text: context.l10n.save,
                );
              }),
            ],
            if (day == null) ...[
              const SizedBox(height: Dimens.sPadding + Dimens.xsPadding),
              Observer(builder: (_) {
                return XTextButton(
                  onTap: store.isValid ? () => context.pop<WorkDay>(store.workDay) : null,
                  text: context.l10n.save,
                );
              }),
            ],
            const SizedBox(height: Dimens.sPadding),
            XTextButton(
              color: context.backgroundColor,
              borderColor: context.outlineColor,
              onTap: () => context.pop(),
              text: context.l10n.cancel,
            ),
          ],
        );
      }),
    );
  }
}
