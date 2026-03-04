import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/custom_appbar.dart';
import 'package:todo_app/common/custom_textform_field.dart';
import 'package:todo_app/core/app_colors/app_colors.dart';
import 'package:todo_app/common/text_class.dart';
import 'package:todo_app/core/app_font_family/app_font_family.dart';
import 'package:todo_app/routes/routes.dart';
import 'package:todo_app/screens/all_task/controller/all_task_provider.dart';

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
      body: Consumer<AllTaskProvider>(
        builder: (context,provider,_) {
          return ListView.separated(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 12),
            shrinkWrap: true,
            itemCount: provider.todos.length,
            itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.onError,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 2, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextClass(
                            title: provider.todos[index]['title'] ?? "",
                            fontWeight: FontWeight.w600,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          if (provider.todos[index]['description'] != null &&
                              provider.todos[index]['description'].toString().isNotEmpty) ...[
                            const SizedBox(height: 4),
                            TextClass(
                              title: provider.todos[index]['description'],
                              fontSize: 12,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    InkWell(
                      onTap: () {
                        provider.setIsCompleted(true);
                      },
                      child: Icon(
                        provider.todos[index]['isCompleted'] == true
                            ? Icons.check_box_rounded
                            : Icons.check_box_outline_blank_outlined,
                        size: 22,
                      ),
                    ),

                    const SizedBox(width: 4),

                    PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      iconSize: 22,
                      onSelected: (value) {
                        if (value == "edit") {
                          print("Edit clicked");
                        } else if (value == "delete") {
                          provider.deleteTodos(index);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: "edit",
                          child: Text("Edit"),
                        ),
                        PopupMenuItem(
                          value: "delete",
                          child: Text("Delete"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
            //   ListTile(
            //   minTileHeight: 30,
            //   tileColor: AppColors.red,
            //   title: TextClass(title: provider.todos[index]['title']),
            //   subtitle: TextClass(title: provider.todos[index]['description'] ?? "",color: AppColors.white),
            // );
          },
          separatorBuilder:(context, index) {
            return SizedBox(height: 10);
            },
          );
        }
      ),
      floatingActionButton: addBtn(context),
    );
  }

  FloatingActionButton addBtn(BuildContext context) {
    return FloatingActionButton(
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
              child: Consumer<AllTaskProvider>(
                builder: (context,provider,_) {
                  return Form(
                    key: provider.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextClass(
                                title: "Add New Task",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Checkbox(
                              value: provider.isCompleted,
                              onChanged: (value) {
                                provider.setIsCompleted(value ?? false);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        CustomTextFormField(
                          controller: provider.titleController,
                          hintText: "Title",
                          validator: (value) {
                            if(provider.titleController.text.isEmpty){
                              return "Please enter title";
                            }
                          },
                        ),
                        SizedBox(height: 12),
                        CustomTextFormField(
                          controller: provider.descriptionController,
                          hintText: "Description",
                          maxLines: 3,
                          minLines: 1,
                          textInputAction: TextInputAction.newline,
                          textInputType: TextInputType.multiline,
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if(provider.formKey.currentState?.validate() ?? false){
                              provider.addTodos(title: provider.titleController.text, isCompleted: provider.isCompleted,description: provider.descriptionController.text);
                            }else{
                              provider.formKey.currentState?.validate();
                            }
                          },
                          child: Text("Save"),
                        ),
                      ],
                    ),
                  );
                }
              ),
            );
          },
        );
      },
      child: Icon(Icons.add, size: 30),
    );
  }
}
