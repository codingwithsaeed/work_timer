import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../utils/dialog_utils.dart';
import '../../utils/extensions.dart';
import '../../utils/dimens.dart';
import '../../utils/routes.dart';
import '../../db/entities/month.dart';
import '../../utils/x_widgets/x_text.dart';
import '../stores/work_store.dart';
import 'dialogs/create_month_dialog.dart';

class MonthListScreen extends StatelessWidget {
  const MonthListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = context.read<WorkStore>()..getMonths();
    return Observer(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('WorkDays App'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await DialogUtils.showXModalBottomSheetPage<Month?>(
              context,
              content: const CreateMonthDialog(),
            );
            if (result != null) store.insertMonth(result);
          },
          child: const Icon(Icons.add),
        ),
        body: store.isLoading
            ? const Center(child: CircularProgressIndicator())
            : store.months.isEmpty
                ? const Center(child: Text('No months'))
                : GridView.builder(
                    padding: const EdgeInsets.all(Dimens.mPadding),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: Dimens.mPadding,
                      crossAxisSpacing: Dimens.mPadding,
                    ),
                    itemBuilder: (_, index) {
                      final month = store.months[index];
                      return MonthItem(
                        name: month.name,
                        onTap: () {
                          store.setCurrentMonth(month);
                          context.pushNamed(Routes.monthDays);
                        },
                      );
                    },
                    itemCount: store.months.length,
                  ),
      );
    });
  }
}

class MonthItem extends StatelessWidget {
  final String name;
  final VoidCallback? onTap;
  const MonthItem({Key? key, required this.name, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.primaryContainerColor,
          borderRadius: BorderRadius.circular(Dimens.sPadding),
          border: Border.all(color: context.outlineColor),
        ),
        padding: const EdgeInsets.all(Dimens.mPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.calendar_month_rounded,
                size: Dimens.xlIconSize + Dimens.mIconSize, color: context.primaryColor),
            const SizedBox(height: Dimens.sPadding),
            XText(name, align: TextAlign.center, style: context.titleMedium),
          ],
        ),
      ),
    );
  }
}
