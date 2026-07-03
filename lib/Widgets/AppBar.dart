import 'package:flutter/material.dart';

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final bool showMore;
  final IconData? moreIcon;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onMorePressed;

  const NewsAppBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.showMore = true,
    this.moreIcon,
    this.onSearchPressed,
    this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 7,
      shadowColor: Colors.black.withOpacity(0.4),
      surfaceTintColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        if (showMore)
          IconButton(
            icon: Icon(moreIcon ?? Icons.more_vert, color: Colors.black),
            onPressed: onMorePressed,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}