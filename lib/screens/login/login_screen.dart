import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/custom_appbar.dart';
import 'package:todo_app/common/text_class.dart';
import 'package:todo_app/core/app_colors/app_colors.dart';
import 'package:todo_app/routes/routes.dart';
import 'package:todo_app/screens/login/login_services.dart';

import '../../main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ChangeNotifierProvider(
      create: (_) => GoogleAuthServices(),
      child: Scaffold(
        // appBar: CustomAppBar(
        //   isLeading: false,
        //   title: TextClass(
        //     title: "Login",
        //     fontSize: 18,
        //     fontWeight: FontWeight.w600,
        //     color: colorScheme.onPrimary,
        //   ),
        // ),

        body: SafeArea(
          child: Consumer<GoogleAuthServices>(
            builder: (context, auth, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    /// 🔝 Skip
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: ()async {
                          final box = Hive.box(loginBoxKey);
                          await box.put("isLoggedIn", "skip");
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.allTaskScreen,
                          );
                        },
                        child: TextClass(
                          title: "Skip",
                          fontSize: 14,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),

                    /// 🎯 Center Content
                    Column(
                      children: [

                        /// Icon
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.task_alt,
                            size: 60,
                            color: colorScheme.primary,
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// Title
                        const TextClass(
                          title: "Welcome Back",
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),

                        const SizedBox(height: 8),

                        /// Subtitle
                        const TextClass(
                          title: "Login to manage your tasks",
                          fontSize: 14,
                          color: AppColors.lightBlack,
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 30),

                        /// 🔐 Google Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: auth.isLoading
                                ? null
                                : () async {
                              await auth.signInWithGoogle();
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            child: auth.isLoading
                                ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.login, color: Colors.white),
                                SizedBox(width: 10),
                                TextClass(
                                  title: "Continue with Google",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// 🔽 Bottom
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: TextClass(
                        title:
                        "By continuing, you agree to our Terms & Privacy Policy",
                        textAlign: TextAlign.center,
                        fontSize: 12,
                        color: AppColors.black54,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}