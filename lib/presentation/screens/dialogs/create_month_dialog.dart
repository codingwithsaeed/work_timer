import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:work_timer/utils/x_widgets/x_text.dart';
import '../../../db/entities/month.dart';
import '../../../utils/extensions.dart';
import '../../../utils/x_widgets/x_text_button.dart';
import '../../../utils/x_widgets/x_text_field.dart';
import '../../../utils/dimens.dart';

part 'create_month_dialog.g.dart';

class CreateMonthStore = _CreateMonthStoreBase with _$CreateMonthStore;

abstract class _CreateMonthStoreBase with Store {
  @observable
  String name = '';
  @action
  void setName(String name) => this.name = name;

  @observable
  String dutyHours = '';
  @action
  void setDutyHours(String dutyHours) => this.dutyHours = dutyHours;
  @observable
  String absenceHours = '20';
  @action
  void setAbsenceHours(String absenceHours) => this.absenceHours = absenceHours;

  @computed
  bool get isValid =>
      name.isNotEmpty &&
      dutyHours.isNotEmpty &&
      absenceHours.isNotEmpty &&
      int.tryParse(dutyHours) != null &&
      int.tryParse(absenceHours) != null;

  @computed
  Month? get month =>
      isValid ? Month(name: name, dutyHours: int.parse(dutyHours), absenceHours: int.parse(absenceHours)) : null;
}

class CreateMonthDialog extends StatefulWidget {
  const CreateMonthDialog({Key? key}) : super(key: key);

  @override
  State<CreateMonthDialog> createState() => _CreateMonthDialogState();
}

class _CreateMonthDialogState extends State<CreateMonthDialog> {
  late TextEditingController absenceHoursController;
  late CreateMonthStore store;

  @override
  void initState() {
    super.initState();
    absenceHoursController = TextEditingController(text: '20');
    store = CreateMonthStore();
  }

  @override
  void dispose() {
    absenceHoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        XText(context.l10n.createMonth, style: context.titleLarge),
        const SizedBox(height: Dimens.mPadding),
        XTextField(
          label: context.l10n.monthName,
          inputAction: TextInputAction.next,
          onChanged: (name) => store.setName(name),
        ),
        const SizedBox(height: Dimens.mPadding),
        XTextField(
          label: context.l10n.dutyHours,
          inputAction: TextInputAction.done,
          onChanged: (dutyHours) => store.setDutyHours(dutyHours),
        ),
        const SizedBox(height: Dimens.mPadding),
        XTextField(
          label: context.l10n.allowAbsenceHours,
          inputAction: TextInputAction.done,
          controller: absenceHoursController,
          onChanged: (absenceHours) => store.setAbsenceHours(absenceHours),
        ),
        const SizedBox(height: Dimens.sPadding),
        Observer(builder: (_) {
          return XTextButton(
            onTap: store.isValid ? () => context.pop(store.month) : null,
            text: context.l10n.save,
          );
        }),
        const SizedBox(height: Dimens.sPadding),
        XTextButton(
          onTap: () => context.pop(),
          color: context.backgroundColor,
          borderColor: context.outlineColor,
          text: context.l10n.cancel,
        ),
      ],
    );
  }
}
