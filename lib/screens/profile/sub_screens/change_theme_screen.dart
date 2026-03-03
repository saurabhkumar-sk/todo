import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/custom_appbar.dart';
import 'package:todo_app/common/text_class.dart';
import 'package:todo_app/core/app_colors/app_colors.dart';
import 'package:todo_app/core/app_font_family/app_font_family.dart';

import '../../../theme/theme_provider.dart';


class ChangeThemeScreen extends StatelessWidget {
  const ChangeThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: TextClass(title: "Theme Settings",color: AppColors.white)),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          final selectedIndex = themeProvider.selectedThemeIndex;
          List<bool> isSelected = List.generate(3, (index) => index == selectedIndex);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextClass(title: "Choose Theme",
                  fontSize: 18,
                  fontFamily: AppFontFamily.iBMPlexMonoBold,
                ),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final buttonWidth = constraints.maxWidth / 3.1;
                    return ToggleButtons(
                      borderRadius: BorderRadius.circular(8),
                      fillColor:Theme.of(context).brightness == Brightness.dark ? AppColors.lightBlack :  Theme.of(context).colorScheme.primary.withAlpha(80),
                      selectedColor:Theme.of(context).brightness == Brightness.dark ? AppColors.white : Theme.of(context).colorScheme.onPrimary,
                      color: Theme.of(context).colorScheme.onSurface,
                      isSelected: isSelected,
                      onPressed: (index) {
                        ThemeMode mode;
                        if (index == 0) {
                          mode = ThemeMode.light;
                        } else if (index == 1) {
                          mode = ThemeMode.dark;
                        } else {
                          mode = ThemeMode.system;
                        }
                        themeProvider.setTheme(mode);
                      },
                      children: [
                        SizedBox(
                          width: buttonWidth,
                          child: const Center(child: TextClass(title: "Light", color: null)),
                        ),
                        SizedBox(
                          width: buttonWidth,
                          child: const Center(child: TextClass(title: "Dark", color: null)),
                        ),
                        SizedBox(
                          width: buttonWidth,
                          child: const Center(child: TextClass(title: "System", color: null)),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
