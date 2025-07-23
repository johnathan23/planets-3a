import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:planets_3A/app/theme/app_colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppbar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return AppBar(
        backgroundColor: Colors.transparent,
        title: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: kBlack)),
        centerTitle: true,
        leading: IconButton(onPressed: () => context.pop(), icon: Icon(Symbols.arrow_back_rounded, color: kBlack)),
      );
    } else {
      return AppBar(backgroundColor: Colors.transparent);
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
