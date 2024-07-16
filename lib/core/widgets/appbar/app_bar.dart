import 'package:flutter/material.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? action;
  final Color? backgroundColor;
  final bool hideBack;
  final VoidCallback? onPressed;

  const BasicAppbar(
      {this.title,
      this.hideBack = false,
      this.action,
      this.backgroundColor,
      this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: title ?? const Text(''),
      actions: action,
      leading: hideBack
          ? null
          : IconButton(
              onPressed: () {
                if (onPressed != null) {
                  onPressed!();
                } else {
                  Navigator.pop(context);
                }
              },
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.04),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                  color: Colors.black,
                ),
              ),
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
