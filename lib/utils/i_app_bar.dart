import 'package:flutter/material.dart';
import 'package:work_timer/utils/extensions.dart';

class IAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasBack;
  final Widget? leading;
  final List<Widget>? actions;
  const IAppBar({
    super.key,
    required this.title,
    this.hasBack = true,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: hasBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => context.pop(),
            )
          : leading,
      automaticallyImplyLeading: false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
