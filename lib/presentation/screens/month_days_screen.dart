import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:work_timer/db/entities/time.dart';
import 'package:work_timer/presentation/screens/dialogs/create_day_dialog.dart';
import 'package:work_timer/utils/content_loader.dart';
import 'package:work_timer/utils/i_app_bar.dart';
import 'package:work_timer/utils/routes.dart';
import 'package:work_timer/utils/x_widgets/x_container.dart';
import 'package:work_timer/utils/x_widgets/x_text.dart';
import 'package:work_timer/utils/x_widgets/x_text_button.dart';
import '../../utils/dialog_utils.dart';
import '../../utils/extensions.dart';
import '../../db/entities/work_day.dart';
import '../../utils/dimens.dart';
import '../stores/work_store.dart';

class MonthDaysScreen extends StatefulWidget {
  const MonthDaysScreen({super.key});

  @override
  State<MonthDaysScreen> createState() => _MonthDaysScreenState();
}

class _MonthDaysScreenState extends State<MonthDaysScreen> {
  late WorkStore store;

  @override
  void initState() {
    super.initState();
    store = context.read<WorkStore>()..getWorkDays();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        appBar: IAppBar(title: store.currentMonth!.name),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showCreateOrUpdateDayDialog(),
          child: const Icon(Icons.add),
        ),
        body: ContentLoader(
          isLoading: store.isLoading,
          emptyText: context.l10n.noWorkDays,
          data: store.workDays,
          child: Observer(builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Observer(builder: (_) {
                  return Container(
                    padding: const EdgeInsets.only(top: Dimens.sPadding),
                    margin: const EdgeInsets.symmetric(horizontal: Dimens.sPadding),
                    decoration: BoxDecoration(
                      color: context.backgroundColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(Dimens.sPadding),
                        bottomRight: Radius.circular(Dimens.sPadding),
                      ),
                    ),
                    child: XContainer(
                      onTap: () => context.pushNamed(Routes.monthDetails),
                      color: context.primaryColor.withOpacity(0.1),
                      borderColor: context.primaryColor.withOpacity(0.2),
                      borderRadius: Dimens.sPadding,
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
                            progressColor: store.progressColor.withOpacity(0.9),
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
                    ),
                  );
                }),
                // XText(
                //   context.l10n.days,
                //   style: context.titleMedium,
                //   color: context.onPrimaryContainerColor.withOpacity(0.7),
                // ).marginDirectionalOnly(top: Dimens.sPadding, start: Dimens.mPadding),
                ListView.separated(
                  padding: EdgeInsets.fromLTRB(
                    Dimens.sPadding,
                    Dimens.sPadding,
                    Dimens.sPadding,
                    68.h,
                  ),
                  itemCount: store.sortedByDate.length,
                  shrinkWrap: true,
                  separatorBuilder: (_, index) => const SizedBox(height: Dimens.sPadding),
                  itemBuilder: (_, index) {
                    final workDay = store.sortedByDate[index];
                    return WorkDayItem(
                      workDay: workDay,
                      onDelete: () => _showDeleteDialog(workDay),
                      onEdit: () => _showCreateOrUpdateDayDialog(workDay),
                    );
                  },
                ).expand(),
              ],
            );
          }),
        ),
      );
    });
  }

  void _showDeleteDialog(WorkDay day) async {
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
    if (result != null && result) store.deleteWorkDay(day);
  }

  void _showCreateOrUpdateDayDialog([WorkDay? day]) {
    DialogUtils.showXModalBottomSheetPage(context, content: CreateDayDialog(day: day));
  }
}

class WorkDayItem extends StatelessWidget {
  final WorkDay workDay;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  const WorkDayItem({super.key, required this.workDay, this.onDelete, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsetsDirectional.only(start: Dimens.mPadding),
      tileColor: workDay.type.color.withOpacity(0.03),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.sPadding),
        side: BorderSide(color: workDay.type.color.withOpacity(0.3)),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          XText(
            Jalali.fromDateTime(workDay.date).weekDay.weekday(context),
            style: context.titleMedium,
            align: TextAlign.start,
          ).expand(flex: context.isFarsi ? 2 : 1),
          const Gap(Dimens.sPadding),
          XText(
            Jalali.fromDateTime(workDay.date).myFormat,
            style: context.titleMedium,
            direction: TextDirection.ltr,
            align: context.isFarsi ? TextAlign.end : TextAlign.start,
          ).expand(flex: context.isFarsi ? 5 : 1),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          XText(
            workDay.type.text(context),
            color: workDay.type.color.withOpacity(0.8),
            style: context.bodySmall,
            align: TextAlign.center,
          ).expand(),
          const Gap(Dimens.sPadding),
          XText(context.l10n.from, style: context.bodySmall),
          const Gap(Dimens.xsPadding),
          XText(
            workDay.arrival.padLeft().toString(),
            direction: TextDirection.ltr,
            style: context.bodySmall,
            align: TextAlign.center,
          ).expand(),
          XText(context.l10n.to, style: context.bodySmall),
          const Gap(Dimens.xsPadding),
          XText(
            workDay.exit.padLeft().toString(),
            direction: TextDirection.ltr,
            style: context.bodySmall,
            align: TextAlign.center,
          ).expand(),
          //context.isFarsi ? const Spacer() : const SizedBox()
        ],
      ),
      leading: Icon(Iconsax.clock, color: workDay.type.color.withOpacity(0.5)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: onEdit, icon: Icon(Iconsax.edit_2, color: context.secondaryColor)),
          IconButton(onPressed: onDelete, icon: Icon(Iconsax.trash, color: context.errorColor))
        ],
      ),
    );
  }
}
