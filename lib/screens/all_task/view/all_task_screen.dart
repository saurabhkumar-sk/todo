import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/custom_appbar.dart';
import 'package:todo_app/common/custom_textform_field.dart';
import 'package:todo_app/common/text_class.dart';
import 'package:todo_app/core/app_font_family/app_font_family.dart';
import 'package:todo_app/routes/routes.dart';
import 'package:todo_app/screens/all_task/controller/all_task_provider.dart';

class AllTaskScreen extends StatelessWidget {
  const AllTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomAppBar(
            isLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: TextClass(
                title: "All Todos",
                fontSize: 20,
                fontFamily: AppFontFamily.iBMPlexMonoSemiBold,
                color: colorScheme.onPrimary,
              ),
            ),
          
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.profileScreen);
                },
                icon: Icon(
                  Icons.person_outlined,
                  color: colorScheme.onPrimary,
                  size: 26,
                ),
              ),
            ],
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: colorScheme.onPrimary,
              unselectedLabelColor: colorScheme.onPrimary.withValues(alpha: 0.7),
              indicatorColor: colorScheme.onPrimary,
              labelStyle: TextStyle(
                fontFamily: AppFontFamily.iBMPlexMonoSemiBold,
                fontSize: 16,
              ),
              tabs: [
                Tab(text: "Due"),
                Tab(text: "Completed"),
              ],
            ),
          ),
        ),
        body:  TabBarView(
          children: [
          todosList(context, isCompleted: false),
          todosList(context, isCompleted: true),
      ],
      ),

        // body: Consumer<AllTaskProvider>(
        //   builder: (context, provider, _) {
        //     if(provider.todos.isEmpty){
        //       return Center(child: TextClass(title: "No Todos"));
        //     }
        //     return ListView.separated(
        //       // reverse: true,
        //       padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        //       itemCount: provider.todos.length,
        //       separatorBuilder: (_, __) => const SizedBox(height: 10),
        //
        //       itemBuilder: (context, index) {
        //         final todo = provider.todos.reversed.toList()[index];
        //         final reversedIndex = provider.todos.length - 1 - index;
        //         return Opacity(
        //           opacity: todo['isCompleted'] == true ? 0.4 : 1,
        //           child: Container(
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(10),
        //               color: colorScheme.surface,
        //               border: Border.all(color: colorScheme.primary),
        //               boxShadow: [
        //                 BoxShadow(
        //                   color: Colors.black.withValues(alpha: .05),
        //                   blurRadius: 4,
        //                   offset: const Offset(0, 2),
        //                 )
        //               ],
        //             ),
        //
        //             child: Padding(
        //               padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
        //
        //               child: Row(
        //                 children: [
        //                   Expanded(
        //                     child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //
        //                         TextClass(
        //                           title: todo['title'] ?? "",
        //                           fontWeight: FontWeight.w600,
        //                           maxLines: 2,
        //                           overflow: TextOverflow.ellipsis,
        //                           color: colorScheme.onSurface,
        //                         ),
        //
        //                         if (todo['description'] != null &&
        //                             todo['description']
        //                                 .toString()
        //                                 .isNotEmpty) ...[
        //                           const SizedBox(height: 4),
        //
        //                           TextClass(
        //                             title: todo['description'],
        //                             fontSize: 12,
        //                             maxLines: 2,
        //                             overflow: TextOverflow.ellipsis,
        //                             color: colorScheme.onSurface
        //                                 .withValues(alpha: .7),
        //                           ),
        //                         ],
        //                       ],
        //                     ),
        //                   ),
        //
        //                   const SizedBox(width: 8),
        //
        //                   InkWell(
        //                     onTap: () {
        //                       provider.toggleCompleted(reversedIndex);
        //                     },
        //
        //                     child: Icon(
        //                       todo['isCompleted'] == true
        //                           ? Icons.check_box_rounded
        //                           : Icons.check_box_outline_blank_outlined,
        //                       size: 22,
        //                       color: colorScheme.primary,
        //                     ),
        //                   ),
        //
        //                   PopupMenuButton<String>(
        //                     offset: Offset(-30, 22),
        //                     padding: EdgeInsets.zero,
        //                     iconSize: 22,
        //                     onSelected: (value) {
        //                       if (value == "edit") {
        //                         addTaskBottomSheet(context, colorScheme, editIndex: reversedIndex);
        //                         provider.titleController.text = provider.todos[reversedIndex]['title'];
        //                         provider.descriptionController.text = provider.todos[reversedIndex]['description'];
        //                       } else if (value == "delete") {
        //                         provider.deleteTodos(reversedIndex);
        //                       }
        //                     },
        //                     itemBuilder: (context) =>  [
        //                       if(todo['isCompleted'] != true)
        //                       PopupMenuItem(
        //                         value: "edit",
        //                         child: Text("Edit"),
        //                       ),
        //                       PopupMenuItem(
        //                         value: "delete",
        //                         child: Text("Delete"),
        //                       ),
        //                     ],
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         );
        //       },
        //     );
        //   },
        // ),
        floatingActionButton: _addBtn(context),
      ),
    );
  }

  Widget todosList(BuildContext context, {required bool isCompleted}) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<AllTaskProvider>(
      builder: (context, provider, _) {
        final todos = provider.todos.where((todo) => todo.isCompleted == isCompleted).toList();

        if (todos.isEmpty) {
          return Center(
            child: TextClass(
              title: isCompleted ? "No Completed Todos" : "No Pending Todos",
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          itemCount: todos.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final todo = todos.reversed.toList()[index];
            final reversedIndex = provider.todos.indexOf(todo);

            return Opacity(
              opacity: todo.isCompleted ? 0.4 : 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorScheme.surface,
                  border: Border.all(color: colorScheme.primary),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextClass(
                              title: todo.title ?? "",
                              fontWeight: FontWeight.w600,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              color: colorScheme.onSurface,
                            ),
                            if (todo.description != null && todo.description.toString().isNotEmpty) ...[
                              const SizedBox(height: 4),
                              TextClass(
                                title: todo.description ?? "",
                                fontSize: 12,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                color: colorScheme.onSurface.withOpacity(.7),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => provider.toggleCompleted(reversedIndex),
                        child: Icon(
                          todo.isCompleted? Icons.check_box_rounded : Icons.check_box_outline_blank_outlined,
                          size: 22,
                          color: colorScheme.primary,
                        ),
                      ),
                      PopupMenuButton<String>(
                        offset: const Offset(-30, 22),
                        padding: EdgeInsets.zero,
                        iconSize: 22,
                        onSelected: (value) {
                          if (value == "edit") {
                            provider.titleController.text = todo.title ?? "";
                            provider.descriptionController.text = todo.description ?? "";
                            addTaskBottomSheet(context, colorScheme, editIndex: reversedIndex);
                          } else if (value == "delete") {
                            provider.deleteTodos(reversedIndex);
                          }
                        },
                        itemBuilder: (context) => [
                          if (!todo.isCompleted)
                            const PopupMenuItem(
                              value: "edit",
                              child: Text("Edit"),
                            ),
                          const PopupMenuItem(
                            value: "delete",
                            child: Text("Delete"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  FloatingActionButton _addBtn(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FloatingActionButton(
      onPressed: () {
        addTaskBottomSheet(context, colorScheme);
      },

      child: const Icon(Icons.add, size: 30),
    );
  }

  Future<dynamic> addTaskBottomSheet(BuildContext context, ColorScheme colorScheme, {int? editIndex}) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: colorScheme.surface,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
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
              builder: (context, provider, _) {
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
                              color: colorScheme.onSurface,
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

                      const SizedBox(height: 12),

                      CustomTextFormField(
                        controller: provider.titleController,
                        hintText: "Title",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter title";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      CustomTextFormField(
                        controller: provider.descriptionController,
                        hintText: "Description",
                        maxLines: 3,
                        minLines: 1,
                        textInputAction: TextInputAction.newline,
                        textInputType: TextInputType.multiline,
                      ),

                      const SizedBox(height: 16),

                      ElevatedButton(
                        onPressed: () {
                          if (provider.formKey.currentState?.validate() ??
                              false) {
                            if(editIndex != null){
                              provider.updateTodos(index: editIndex,
                                  title:   provider.titleController.text,
                                  description: provider.descriptionController.text,
                                  isCompleted:provider.isCompleted,
                              );
                            }else {
                              provider.addTodos(
                                title:provider.titleController.text,
                                description: provider.descriptionController.text,
                                isCompleted:provider.isCompleted,
                              );
                            }

                          }
                        },
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
  }
}