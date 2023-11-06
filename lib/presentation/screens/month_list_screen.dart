import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:work_timer/presentation/screens/widgets/month_list_item.dart';
import 'package:work_timer/utils/content_loader.dart';
import 'package:work_timer/utils/i_app_bar.dart';
import 'package:work_timer/utils/x_widgets/x_text_button.dart';
import '../../utils/dialog_utils.dart';
import '../../utils/extensions.dart';
import '../../utils/dimens.dart';
import '../../utils/routes.dart';
import '../../db/entities/month.dart';
import '../stores/work_store.dart';
import 'dialogs/create_month_dialog.dart';

class MonthListScreen extends StatefulWidget {
  const MonthListScreen({Key? key}) : super(key: key);

  @override
  State<MonthListScreen> createState() => _MonthListScreenState();
}

class _MonthListScreenState extends State<MonthListScreen> {
  late WorkStore store;
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
    store = context.read<WorkStore>()..getMonths();
    final disposer = context.setupErrorReaction(store.errorStore);
    if (disposer != null) _disposers.add(disposer);
  }

  @override
  void dispose() {
    for (final disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IAppBar(
        title: context.l10n.appName,
        hasBack: false,
        leading: IconButton(
          onPressed: () => context.pushNamed(Routes.about),
          icon: const Icon(Iconsax.info_circle4),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.setting),
            onPressed: () => context.pushNamed(Routes.appSettings),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showMonthUpsertDialog(),
        child: const Icon(Icons.add),
      ),
      body: Observer(builder: (_) {
        return ContentLoader(
          isLoading: store.isLoading,
          emptyText: context.l10n.noMonth,
          data: store.months,
          child: ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(height: Dimens.sPadding),
            padding: EdgeInsets.fromLTRB(Dimens.sPadding, Dimens.sPadding, Dimens.sPadding, 68.h),
            itemBuilder: (_, index) {
              final month = store.months[index];
              return MonthListItem(
                month: month,
                onTap: () {
                  store.setCurrentMonth(month);
                  context.pushNamed(Routes.monthDays);
                },
                onDelete: () => _showMonthDeleteDialog(month),
                onEdit: () => _showMonthUpsertDialog(month),
              );
            },
            itemCount: store.months.length,
          ),
        );
      }),
    );
  }

  void _showMonthUpsertDialog([Month? month]) =>
      DialogUtils.showXModalBottomSheetPage(context, content: CreateMonthDialog(month: month));

  void _showMonthDeleteDialog(Month month) async {
    final result = await DialogUtils.showXBottomSheet<bool?>(
      context,
      title: context.l10n.deleteMonth,
      content: context.l10n.doYouWantToDelete(month.name),
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
    if (result != null && result) store.deleteMonth(month);
  }
}
