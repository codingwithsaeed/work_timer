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
  Month? monthForEdit;
  @action
  void setMonthForEdit(Month? monthForEdit) => this.monthForEdit = monthForEdit;

  @action
  void init(Month? month) {
    setMonthForEdit(month);
    setName(month?.name ?? '');
    setDutyHours(month?.dutyHours.toString() ?? '');
    setAbsenceHours(month?.absenceHours.toString() ?? '20');
  }

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
  bool get canEdit => isValid && monthForEdit != null && month != monthForEdit;

  @computed
  Month? get month =>
      isValid ? Month(name: name, dutyHours: int.parse(dutyHours), absenceHours: int.parse(absenceHours)) : null;
}

class CreateMonthDialog extends StatefulWidget {
  final Month? month;
  const CreateMonthDialog({Key? key, this.month}) : super(key: key);

  @override
  State<CreateMonthDialog> createState() => _CreateMonthDialogState();
}

class _CreateMonthDialogState extends State<CreateMonthDialog> {
  late TextEditingController monthNameController;
  late TextEditingController dutyHoursController;
  late TextEditingController absenceHoursController;
  late CreateMonthStore store;

  @override
  void initState() {
    super.initState();
    monthNameController = TextEditingController(text: widget.month?.name ?? '');
    dutyHoursController = TextEditingController(text: widget.month?.dutyHours.toString() ?? '');
    absenceHoursController = TextEditingController(text: widget.month?.absenceHours.toString() ?? '20');
    store = CreateMonthStore()..init(widget.month);
  }

  @override
  void dispose() {
    monthNameController.dispose();
    dutyHoursController.dispose();
    absenceHoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        XText(widget.month == null ? context.l10n.createMonth : context.l10n.editMonth, style: context.titleLarge),
        const SizedBox(height: Dimens.mPadding),
        XTextField(
          label: context.l10n.monthName,
          inputAction: TextInputAction.next,
          controller: monthNameController,
          onChanged: (name) => store.setName(name),
        ),
        const SizedBox(height: Dimens.mPadding),
        XTextField(
          label: context.l10n.dutyHours,
          inputAction: TextInputAction.done,
          controller: dutyHoursController,
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
          return Visibility(
            visible: widget.month != null,
            child: XTextButton(
              onTap: store.canEdit ? () => context.pop(store.month) : null,
              text: context.l10n.save,
            ),
          );
        }),
        Observer(builder: (_) {
          return Visibility(
            visible: widget.month == null,
            child: XTextButton(
              onTap: store.isValid ? () => context.pop(store.month) : null,
              text: context.l10n.save,
            ),
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
