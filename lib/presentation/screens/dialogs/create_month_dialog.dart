import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
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

  @computed
  bool get isValid => name.isNotEmpty && dutyHours.isNotEmpty && int.tryParse(dutyHours) != null;

  @computed
  Month? get month => isValid ? Month(name: name, dutyHours: int.parse(dutyHours)) : null;
}

class CreateMonthDialog extends StatelessWidget {
  const CreateMonthDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CreateMonthStore(),
      child: Builder(
        builder: (context) {
          final store = context.read<CreateMonthStore>();
          return Column(
            children: [
              XTextField(
                label: 'Month name',
                inputAction: TextInputAction.next,
                onChanged: (name) => store.setName(name),
              ),
              const SizedBox(height: Dimens.mPadding),
              XTextField(
                label: 'Duty hours',
                inputAction: TextInputAction.done,
                onChanged: (dutyHours) => store.setDutyHours(dutyHours),
              ),
              const SizedBox(height: Dimens.mPadding),
              Observer(builder: (_) {
                return XTextButton(
                  onTap: store.isValid ? () => context.pop(store.month) : null,
                  text: 'Save',
                );
              }),
              const SizedBox(height: Dimens.mPadding),
              XTextButton(onTap: () => context.pop(), text: 'Cancel'),
            ],
          );
        },
      ),
    );
  }
}
