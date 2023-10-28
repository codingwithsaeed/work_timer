import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:work_timer/db/entities/work_day.dart';
import 'package:work_timer/presentation/stores/work_store.dart';
import 'package:work_timer/utils/extensions.dart';
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
  DateTime? date;
  @action
  void setDate(DateTime? date) => this.date = date;

  @computed
  String get dateText {
    if (date == null) return 'Select date';
    return Jalali.fromDateTime(date!).formatCompactDate();
  }

  @observable
  Time? arrival;
  @action
  void setArrival(Time? arrival) => this.arrival = arrival;

  @computed
  String get arrivalText {
    if (arrival == null) return 'Select arrival';
    return arrival!.padLeft().toString();
  }

  @observable
  Time? exit;
  @action
  void setExit(Time? exit) => this.exit = exit;

  @computed
  String get exitText {
    if (exit == null) return 'Select exit';
    return exit!.padLeft().toString();
  }

  @observable
  bool isRemote = false;
  @action
  void setIsRemote(bool isRemote) => this.isRemote = isRemote;

  @computed
  bool get isValid => date != null && arrival != null && exit != null;

  @computed
  WorkDay? get workDay =>
      isValid ? WorkDay(date: date!, arrival: arrival!, exit: exit!, isRemote: isRemote, monthId: monthId) : null;
}

class CreateDayDialog extends StatelessWidget {
  const CreateDayDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workStore = context.read<WorkStore>();
    return Provider(
      create: (_) => CreateDayStore(workStore.currentMonth!.id!),
      child: Builder(builder: (context) {
        final store = context.read<CreateDayStore>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Observer(builder: (_) {
              return XTextButton(
                onTap: () async {
                  final date = await DialogUtils.showDatePicker(context);
                  if (date != null) store.setDate(date);
                },
                color: context.backgroundColor,
                borderColor: context.outlineColor,
                text: store.dateText,
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
                    text: store.arrivalText,
                  );
                }).expand(),
                const SizedBox(width: Dimens.sPadding),
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
                    text: store.exitText,
                  );
                }).expand(),
              ],
            ),
            const SizedBox(height: Dimens.sPadding),
            Observer(builder: (_) {
              return XTextButton(
                onTap: store.isValid ? () => context.pop<WorkDay>(store.workDay) : null,
                text: 'Save',
              );
            }),
            const SizedBox(height: Dimens.sPadding),
            XTextButton(
              color: context.backgroundColor,
              borderColor: context.outlineColor,
              onTap: () => context.pop(),
              text: 'Cancel',
            ),
          ],
        );
      }),
    );
  }
}
