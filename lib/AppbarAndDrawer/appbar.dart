// custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:kidictionary/Options/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback toggleLanguage;
  const CustomAppBar({required this.toggleLanguage, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: const Icon(
            Icons.translate,
            color: AppColors.appbarIcon,
            size: 25,
          ),
          onPressed: toggleLanguage, // Butona basıldığında callback çağrılır
        ),
      ],
      centerTitle: true,
      title: const Text(
        "Ki'Dictionary",
        style: TextStyle(
          color: AppColors.appbarText,
          fontSize: 30,
          fontWeight: FontWeight.w800,
        ),
      ),
      backgroundColor: AppColors.appbarBg,
      iconTheme: const IconThemeData(
        color: AppColors.appbarIcon,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
