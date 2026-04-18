import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/custom_appbar.dart';
import 'package:todo_app/common/text_class.dart';
import 'package:todo_app/core/app_colors/app_colors.dart';
import 'package:todo_app/routes/routes.dart';
import '../../main.dart';
import '../../theme/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: TextClass(title: "Profile",color: AppColors.white)),
      body:ListView.separated(
          itemCount: 2,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        itemBuilder: (context, index) {
        return Consumer<ThemeProvider>(
          builder: (context,themeProvider,_) {
            bool isDark;
            switch(themeProvider.themeMode){
              case ThemeMode.light :
                isDark = false;
                break;
              case ThemeMode.dark :
                isDark = true;
              case ThemeMode.system :
                isDark = Theme.of(context).brightness == Brightness.dark;
                break;
            }

            return ListTile(
                onTap: () async {
                  final box = Hive.box(loginBoxKey);
                  final loginType = box.get("isLoggedIn");

                  if (index == 1) {
                    if (loginType == "google") {
                      await FirebaseAuth.instance.signOut();
                      debugPrint("Skip user logout");
                    }
                    await box.clear();
                    Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
                }
                },
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
              tileColor: isDark ? AppColors.lightBlack.withAlpha(80) : AppColors.purple.withAlpha(50),
              title: TextClass(title:
              index == 0 ?"Theme Settings" : "Log Out",fontSize: 16),
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              trailing: Icon(index == 0 ?Icons.arrow_forward_ios_rounded : Icons.logout_rounded,size: 20),
            );
          }
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 14),
      ),
    );
  }
}
