import 'package:flutter/material.dart';
import 'package:work_timer/utils/extensions.dart';

class ContentLoader<T extends Iterable> extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final T data;
  final String? emptyText;
  const ContentLoader({
    super.key,
    required this.child,
    required this.isLoading,
    required this.data,
    this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : data.isEmpty
            ? Center(child: Text(emptyText ?? context.l10n.noData))
            : child;
  }
}
