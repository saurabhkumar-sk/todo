import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_colors/app_colors.dart';

import '../theme/theme_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final bool isLeading;
  final double? leadingWidth;
  final bool? centerTitle;
  final bool isActions;
  final double? toolbarHeight;
  final double? appbarRightPadding;
  final bool? isPop;
  final Color? backgroundClr;
  final Function()? leadingOnTap;

  const CustomAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.isLeading = true,
    this.leadingWidth,
    this.centerTitle,
    this.isActions = false,
    this.toolbarHeight,
    this.appbarRightPadding,
    this.backgroundClr,
    this.isPop = true,
    this.leadingOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final activeThemeMode = themeProvider.themeMode;

    bool isDark;
    switch (activeThemeMode) {
      case ThemeMode.light:
        isDark = false;
        break;
      case ThemeMode.dark:
        isDark = true;
        break;
      case ThemeMode.system:
      isDark = Theme.of(context).brightness == Brightness.dark;
    }

    final theme = Theme.of(context);
    final bgColor = backgroundClr ?? theme.appBarTheme.backgroundColor ?? (isDark ? AppColors.black54 : AppColors.purple);
    final shadowColor = isDark ? Colors.white.withAlpha(10) : Colors.black.withAlpha(10);
    return AppBar(
      backgroundColor: bgColor,
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading: false,
      leading: isLeading
          ? leading ??
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: leadingOnTap ??
                    () {
                  if (isPop == true) Navigator.pop(context);
                },
            child: Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.only(left: 1),
              decoration: BoxDecoration(
                color: bgColor,
                boxShadow: [
                  BoxShadow(color: shadowColor, blurRadius: 0.004)
                ],
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 3.5),
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          )
          : null,
      titleSpacing: 0,
      centerTitle: centerTitle,
      title: title,
      leadingWidth: leadingWidth ?? 40,
      toolbarHeight: toolbarHeight ?? 90,
      actions: actions, /*??
          (isActions
              ? [
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: bgColor.withOpacity(0.09),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: iconColor,
                  ),
                ),
              ),
            ),
          ]
              : []),*/
      surfaceTintColor: theme.colorScheme.background,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(65);
}