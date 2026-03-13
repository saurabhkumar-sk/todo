import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_colors/app_colors.dart';
import 'package:todo_app/screens/login/login_services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GoogleAuthServices(),
      child: Scaffold(
        body: Center(
          child: Consumer<GoogleAuthServices>(
            builder: (context, googleAuthServices, child) {

              return IconButton(
                onPressed: () {
                  googleAuthServices.signInWithGoogle();
                },
                icon: googleAuthServices.isLoading
                    ? const CircularProgressIndicator()
                    : Icon(
                  Icons.facebook,
                  size: 100,
                  color: AppColors.red,
                ),
              );

            },
          ),
        ),
      ),
    );
  }
}