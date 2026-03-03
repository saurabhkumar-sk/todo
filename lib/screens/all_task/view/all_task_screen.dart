import 'package:flutter/material.dart';
import 'package:todo_app/common/custom_appbar.dart';
import 'package:todo_app/common/custom_textform_field.dart';
import 'package:todo_app/core/app_colors/app_colors.dart';
import 'package:todo_app/common/text_class.dart';
import 'package:todo_app/core/app_font_family/app_font_family.dart';
import 'package:todo_app/routes/routes.dart';

class AllTaskScreen extends StatelessWidget {
  const AllTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: TextClass(
            title: "All Todos",
            fontSize: 20,
            fontFamily: AppFontFamily.iBMPlexMonoSemiBold,
            color: AppColors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.profileScreen);
            },
            icon: Icon(Icons.person_outlined, color: AppColors.white, size: 26),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Theme.of(context).colorScheme.onError,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextClass(
                      title: "Add New Task",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 12),
                    CustomTextFormField(
                      hintText: "Title",
                    ),
                    SizedBox(height: 12),
                    CustomTextFormField(
                      hintText: "Description",
                      maxLines: 3,
                      minLines: 1,
                      textInputAction: TextInputAction.newline,
                      textInputType: TextInputType.multiline,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Save"),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add, size: 30),
      ),
    );
  }
}
