import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app_font_family/app_font_family.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.alignment,
    this.height,
    this.width,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.enabled,
    this.onChanged,
    this.onTapOutside,
    this.onTap,
    this.readOnly = false,
    this.borderRadius,
    this.inputFormatters,
    this.minLines,
    this.errorStyle,
  });

  final Alignment? alignment;
  final double? width;
  final double? height;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? textStyle;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final int? minLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final BorderRadius? borderRadius;
  final FormFieldValidator<String>? validator;
  final bool? enabled;
  final Function(String value)? onChanged;
  final TapRegionCallback? onTapOutside;
  final Function()? onTap;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? errorStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Theme-aware defaults
    final defaultFillColor =
        fillColor ?? (isDark ? theme.colorScheme.surfaceVariant : theme.colorScheme.surface);
    final defaultBorderColor =
    borderDecoration != null
        ? (borderDecoration as OutlineInputBorder).borderSide.color
        : (isDark ? Colors.white24 : Colors.black26);
    final defaultHintStyle =
        hintStyle ?? TextStyle(
          color: theme.colorScheme.onSurface.withAlpha(60),
          fontFamily: AppFontFamily.iBMPlexMonoMedium,
          fontSize: 14
        );
    final defaultErrorStyle =
        errorStyle ?? TextStyle(
            color: theme.colorScheme.error,
            fontFamily: AppFontFamily.iBMPlexMonoMedium,
            fontSize: 14
        );

    return alignment != null
        ? Align(alignment: alignment!, child: textFormFieldWidget(defaultFillColor, defaultBorderColor, defaultHintStyle, defaultErrorStyle))
        : textFormFieldWidget(defaultFillColor, defaultBorderColor, defaultHintStyle, defaultErrorStyle);
  }

  Widget textFormFieldWidget(
      Color fillColor,
      Color borderColor,
      TextStyle hintStyle,
      TextStyle errorStyle,
      ) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          return TextFormField(
            controller: controller,
            focusNode: focusNode,
            autofocus: autofocus ?? false,
            style: textStyle ?? TextStyle(
                color: theme.colorScheme.onSurface,
                fontFamily: AppFontFamily.iBMPlexMonoMedium,
                fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            obscureText: obscureText ?? false,
            textInputAction: textInputAction,
            keyboardType: textInputType,
            maxLines: maxLines ?? 1,
            minLines: minLines ?? 1,
            onChanged: onChanged,
            onTap: onTap,
            onTapOutside: onTapOutside ?? (event) => FocusManager.instance.primaryFocus?.unfocus(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            inputFormatters: inputFormatters,
            readOnly: readOnly,
            enabled: enabled ?? true,
            decoration: InputDecoration(
              hintText: hintText ?? "",
              hintStyle: hintStyle,
              errorStyle: errorStyle,
              errorMaxLines: 2,
              prefixIcon: prefix,
              prefixIconConstraints: prefixConstraints ?? const BoxConstraints(minWidth: 30),
              suffixIcon: suffix,
              suffixIconConstraints: suffixConstraints,
              isDense: true,
              contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              fillColor: fillColor,
              filled: filled ?? true,
              border: borderDecoration ??
                  OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                    borderRadius: borderRadius ?? BorderRadius.circular(15),
                  ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
                borderRadius: borderRadius ?? BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
                borderRadius: borderRadius ?? BorderRadius.circular(15),
              ),
            ),
          );
        },
      ),
    );
  }
}