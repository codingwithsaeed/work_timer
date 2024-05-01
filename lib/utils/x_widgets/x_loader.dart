import 'package:flutter/material.dart';

import 'x_loading.dart';

class XLoader extends StatelessWidget {
  final bool isLoading;
  final Color? loadingColor;
  final Widget child;
  const XLoader({
    super.key,
    this.isLoading = false,
    this.loadingColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading ? XLoading(color: loadingColor) : child;
  }
}
