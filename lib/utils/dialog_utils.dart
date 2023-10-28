import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'x_widgets/x_text_button.dart';
import 'extensions.dart';
import 'dimens.dart';

abstract final class DialogUtils {
  const DialogUtils._();

  static Future<void> showXDialog(
    BuildContext context, {
    required String title,
    List<Widget>? actions,
    String? content,
    Widget? contentWidget,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(Dimens.sPadding).only(top: Dimens.zero),
        //insetPadding: const EdgeInsets.symmetric(horizontal: Dimens.padding),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: Dimens.sPadding,
          vertical: Dimens.zero,
        ),
        backgroundColor: context.primaryContainerColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.sPadding),
        ),
        title: Row(
          children: [
            const SizedBox(width: Dimens.sPadding),
            Text(title, style: context.titleSmall.copyWith(overflow: TextOverflow.ellipsis)).expand()
          ],
        ),
        content: Expanded(
          child: contentWidget ??
              Text(
                content ?? '',
                style: context.bodyMedium.copyWith(color: context.onSurfaceVarientColor, height: 2),
              ),
        ),
        actions: actions,
      ),
    );
  }

  static Future<void> showXBottomSheet(
    BuildContext context, {
    required String title,
    List<Widget>? actions,
    bool showCancelButton = true,
    String? cancelActionText,
    String? content,
    Widget? contentWidget,
    bool isDissmissable = true,
  }) async {
    await showModalBottomSheet(
      isDismissible: isDissmissable,
      isScrollControlled: true,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimens.sPadding),
          topRight: Radius.circular(Dimens.sPadding),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          margin: context.mediaQuery.viewInsets,
          padding: const EdgeInsets.all(Dimens.sPadding).only(top: Dimens.zero),
          decoration: BoxDecoration(
              color: context.primaryContainerColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimens.sPadding),
                topRight: Radius.circular(Dimens.sPadding),
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: Dimens.sPadding),
              Row(
                children: [
                  const Spacer(),
                  Container(
                    width: 60.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: context.scrimColor,
                      borderRadius: BorderRadius.circular(Dimens.mPadding),
                    ),
                  ),
                  const Spacer()
                ],
              ),
              const SizedBox(height: Dimens.sPadding),
              Text(
                title,
                style: context.titleMedium.copyWith(overflow: TextOverflow.ellipsis),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimens.mPadding),
              contentWidget ??
                  Text(
                    content ?? '',
                    style: context.bodyMedium.copyWith(height: 2),
                    textAlign: TextAlign.start,
                  ),
              const SizedBox(height: Dimens.mPadding),
              Column(children: actions ?? []),
              if (showCancelButton) ...[
                const SizedBox(height: Dimens.sPadding),
                XTextButton(
                  color: context.primaryContainerColor,
                  borderColor: context.outlineColor,
                  onTap: () => context.pop(),
                  text: cancelActionText ?? 'Cancel',
                  textColor: context.onPrimaryContainerColor,
                ),
              ]
            ],
          ),
        );
      },
    );
  }

  static Future<T?> showXModalBottomSheetPage<T>(
    BuildContext context, {
    required Widget content,
    bool isDissmissable = true,
  }) async {
    return await showModalBottomSheet<T>(
      isDismissible: isDissmissable,
      isScrollControlled: isDissmissable,
      enableDrag: isDissmissable,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimens.mPadding),
          topRight: Radius.circular(Dimens.mPadding),
        ),
      ),
      context: context,
      builder: (context) {
        final MediaQueryData mediaQueryData = context.mediaQuery;
        return Padding(
          padding: mediaQueryData.viewInsets,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: 0.9.sh,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimens.mPadding),
                topRight: Radius.circular(Dimens.mPadding),
              ),
              color: context.primaryContainerColor,
            ),
            child: IntrinsicHeight(
                child: Column(
              children: [
                const SizedBox(height: Dimens.sPadding),
                Container(
                  width: 60.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: context.onSurfaceVarientColor,
                    borderRadius: BorderRadius.circular(Dimens.mPadding),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(Dimens.mPadding),
                  child: content,
                )),
              ],
            )),
          ),
        );
      },
    );
  }

  static Future<DateTime?> showDatePicker(BuildContext context) async {
    Jalali? picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali(1402, 4),
      lastDate: Jalali(1402, 12),
    );

    if (picked != null) return picked.toDateTime();
    return null;
  }
}
