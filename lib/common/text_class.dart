import 'package:flutter/material.dart';
import 'package:todo_app/core/app_colors/app_colors.dart';
import 'package:todo_app/core/app_font_family/app_font_family.dart';

class TextClass extends StatelessWidget {
  final String title;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final double letterSpacing;
  final double wordSpacing;
  final TextDecoration decoration;
  final TextOverflow overflow;
  final FontStyle fontStyle;
  final TextAlign textAlign;
  final int? maxLines;
  final String? fontFamily;

  const TextClass({
    super.key,
    required this.title,
    this.color,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w500,
    this.height = 1.5,
    this.letterSpacing = 0.5,
    this.wordSpacing = 0.5,
    this.decoration = TextDecoration.none,
    this.overflow = TextOverflow.visible,
    this.fontStyle = FontStyle.normal,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        color: color ?? Theme.of(context).colorScheme.onSurface,
        fontFamily: fontFamily ?? AppFontFamily.iBMPlexMonoMedium,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
        fontStyle: fontStyle,
      ),
    );
  }
}