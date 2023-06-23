import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:work_timer/presentation/screens/dialogs/create_day_dialog.dart';
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
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await DialogUtils.showXModalBottomSheetPage<WorkDay?>(
              context,
              content: const CreateDayDialog(),
            );
            if (result != null) store.insertWorkDay(result);
          },
          child: const Icon(Icons.add),
        ),
        body: store.isLoading
            ? const Center(child: CircularProgressIndicator())
            : store.workDays.isEmpty
                ? const Center(child: Text('No work days'))
                : Observer(builder: (_) {
                    return ListView.separated(
                        padding: const EdgeInsets.all(Dimens.mPadding),
                        itemCount: store.workDays.length,
                        separatorBuilder: (_, index) => const SizedBox(height: Dimens.mPadding),
                        itemBuilder: (_, index) {
                          final workDay = store.workDays[index];
                          return WorkDayItem(
                            workDay: workDay,
                            onDelete: () => store.deleteWorkDay(workDay),
                          );
                        });
                  }),
      );
    });
  }
}

class WorkDayItem extends StatelessWidget {
  final WorkDay workDay;
  final VoidCallback? onDelete;
  const WorkDayItem({Key? key, required this.workDay, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: context.primaryContainerColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.sPadding),
        side: BorderSide(color: context.outlineColor),
      ),
      title: Text(Jalali.fromDateTime(workDay.date).formatCompactDate()),
      subtitle: Text('${workDay.arrival.toString()} - ${workDay.exit.toString()}'),
      leading: Icon(Icons.work_history_rounded, color: context.surfaceColor),
      trailing: IconButton(
        onPressed: onDelete,
        icon: Icon(Icons.delete, color: context.errorColor),
        color: context.errorColor,
      ),
      // trailing: Row(
      //   children: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(Icons.edit, color: context.secondaryColor),
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(Icons.delete, color: context.errorColor),
      //     )
      //   ],
      // ),
    );
  }
}
