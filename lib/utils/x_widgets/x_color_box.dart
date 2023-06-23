import 'package:flutter/material.dart';
import '../extensions.dart';
import '../dimens.dart';

import 'x_container.dart';

class XColorBox extends StatelessWidget {
  const XColorBox({
    super.key,
    this.onTap,
    required this.color,
    this.isSelected = false,
  });
  final VoidCallback? onTap;
  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return XContainer(
      onTap: onTap,
      color: color,
      borderColor: isSelected ? context.backgroundColor : Colors.transparent,
      borderWidth: 5,
      borderRadius: Dimens.sPadding,
      child:
          isSelected ? Icon(Icons.check, color: context.onPrimaryColor).center() : const SizedBox(),
    );
  }
}
