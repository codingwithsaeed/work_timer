import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:work_timer/db/entities/time.dart';
import 'package:work_timer/presentation/screens/dialogs/create_day_dialog.dart';
import 'package:work_timer/utils/x_widgets/x_divider.dart';
import 'package:work_timer/utils/x_widgets/x_text.dart';
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
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Observer(builder: (_) {
                          return LinearPercentIndicator(
                            percent: store.progressValue,
                            leading: XText(
                              store.totalTime.toString(),
                              style: context.titleMedium,
                            ),
                            animation: true,
                            trailing: XText(
                              store.currentMonth!.dutyHours.time.toString(),
                              style: context.titleMedium,
                            ),
                            center: XText(
                              store.progressText,
                              size: 12,
                              style: context.titleSmall,
                            ),
                            barRadius: const Radius.circular(Dimens.sPadding),
                            progressColor: store.progressColor,
                            lineHeight: 20,
                            backgroundColor: context.outlineColor,
                          );
                        }).margin(const EdgeInsets.all(Dimens.mPadding)),
                        Observer(builder: (_) {
                          return XText(
                            'Remaining Hours: ${store.remainingTime.toString()}',
                            style: context.titleMedium,
                          );
                        }).marginOnly(
                          left: Dimens.mPadding,
                          right: Dimens.mPadding,
                        ),
                        const XDivider(indent: Dimens.sPadding, thickness: 1),
                        ListView.separated(
                          padding: const EdgeInsets.all(Dimens.sPadding),
                          itemCount: store.sortedByDate.length,
                          shrinkWrap: true,
                          separatorBuilder: (_, index) => const SizedBox(height: Dimens.sPadding),
                          itemBuilder: (_, index) {
                            final workDay = store.sortedByDate[index];
                            return WorkDayItem(
                              workDay: workDay,
                              onDelete: () => store.deleteWorkDay(workDay),
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
  const WorkDayItem({Key? key, required this.workDay, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsets.only(left: Dimens.mPadding),
      tileColor: context.primaryContainerColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.sPadding),
        side: BorderSide(color: context.outlineColor),
      ),
      title: Text(Jalali.fromDateTime(workDay.date).formatCompactDate()),
      subtitle: Text('${workDay.arrival.padLeft().padLeft()}  -  ${workDay.exit.padLeft().toString()}'),
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
