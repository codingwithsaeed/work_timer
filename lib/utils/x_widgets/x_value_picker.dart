import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../extensions.dart';
import '../dimens.dart';
import 'x_text.dart';

class XValuePicker<T> extends StatelessWidget {
  final List<T> values;
  final bool loop;
  final T? currentValue;
  final void Function(T) onChange;

  const XValuePicker({
    super.key,
    required this.onChange,
    required this.values,
    this.currentValue,
    this.loop = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.2.sh,
      child: CupertinoPicker(
        onSelectedItemChanged: (value) => onChange(values[value]),
        looping: loop,
        itemExtent: 35.h,
        scrollController: FixedExtentScrollController(
          initialItem: values.indexWhere((element) => element == currentValue),
        ),
        backgroundColor: context.primaryContainerColor,
        selectionOverlay: Container(
          width: double.infinity,
          height: 35.h,
          decoration: BoxDecoration(
            color: context.secondaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(Dimens.sPadding),
            border: Border.all(color: context.secondaryColor),
          ),
        ),
        children: values
            .map((item) => XText(
                  '$item',
                  style: context.titleMedium,
                ).center())
            .toList(),
      ),
    );
  }
}
