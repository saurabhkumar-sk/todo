import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/common/text_class.dart';
import 'package:todo_app/core/app_font_family/app_font_family.dart';

class AllTaskScreen extends StatelessWidget{
 const AllTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.black,
      title: TextClass(title: "All Todos",fontSize: 20,fontFamily: AppFontFamily.iBMPlexMonoSemiBold,color: AppColors.white),
     ),
   );
  }
}