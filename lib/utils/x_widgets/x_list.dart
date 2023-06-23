import 'package:flutter/material.dart';

import '../dimens.dart';

class XList extends StatelessWidget {
  const XList({
    Key? key,
    required this.builder,
    required this.count,
    this.direction = Axis.vertical,
    this.shrinkWrap = false,
    this.separator,
    this.padding,
    this.controller,
    this.separatorSize = Dimens.mPadding,
  }) : super(key: key);
  final int count;
  final Axis direction;
  final Widget? separator;
  final double separatorSize;
  final Widget? Function(BuildContext, int) builder;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final separator = this.separator ??
        (direction == Axis.vertical ? SizedBox(height: separatorSize) : SizedBox(width: separatorSize));
    return ListView.separated(
      scrollDirection: direction,
      shrinkWrap: shrinkWrap,
      padding: padding,
      controller: controller,
      itemBuilder: builder,
      separatorBuilder: (_, __) => separator,
      itemCount: count,
    );
  }
}
