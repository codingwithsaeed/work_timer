import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:work_timer/db/entities/month.dart';
import 'package:work_timer/utils/dimens.dart';
import 'package:work_timer/utils/extensions.dart';
import 'package:work_timer/utils/x_widgets/x_text.dart';

class MonthListItem extends StatelessWidget {
  final Month month;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const MonthListItem({Key? key, required this.month, this.onTap, this.onDelete, this.onEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsetsDirectional.only(start: Dimens.mPadding),
      tileColor: context.primaryContainerColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.sPadding),
        side: BorderSide(color: context.outlineColor),
      ),
      title: XText(month.name, style: context.titleMedium),
      subtitle: XText(context.l10n.dutyHoursOf(month.dutyHours.toString())),
      leading: Icon(Iconsax.calendar_1, color: context.outlineColor),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(onPressed: onEdit, icon: Icon(Iconsax.edit_2, color: context.secondaryColor)),
          IconButton(onPressed: onDelete, icon: Icon(Iconsax.trash, color: context.errorColor)),
        ],
      ),
    );
  }
}
