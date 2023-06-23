import 'package:flutter/material.dart';
import '../extensions.dart';
import 'x_loader.dart';
import 'x_text.dart';

class XListLoader extends StatelessWidget {
  final bool isLoading;
  final bool isEmpty;
  final String emptyTitle;
  final Color? loadingColor;
  final Widget list;

  const XListLoader({
    Key? key,
    required this.isLoading,
    required this.isEmpty,
    required this.emptyTitle,
    required this.list,
    this.loadingColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return XLoader(
      loadingColor: loadingColor,
      isLoading: isLoading,
      child: isEmpty ? XText(emptyTitle).center() : list,
    );
  }
}
