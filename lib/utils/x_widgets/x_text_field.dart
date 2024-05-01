import 'package:flutter/material.dart';
import '../dimens.dart';
import '../extensions.dart';

class XTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool obscureText;
  final String errorText;
  final bool autoFocus;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool isMultiline;
  final int? maxLength;
  final int minLines;
  final bool enabled;
  final Color? borderColor;
  final TextDirection? direction;
  final TextDirection? hintDirection;
  final TextAlign? textAlign;
  final String? prefixText;
  final String? suffixText;
  final TextStyle? prefixStyle;
  final TextStyle? suffixStyle;

  const XTextField({
    super.key,
    required this.label,
    this.icon,
    this.onChanged,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.isMultiline = false,
    this.inputAction = TextInputAction.done,
    this.errorText = '',
    this.maxLength,
    this.inputType,
    this.autoFocus = false,
    this.minLines = 1,
    this.enabled = true,
    this.prefixText,
    this.suffixText,
    this.textAlign,
    this.hintDirection,
    this.borderColor,
    this.direction,
    this.prefixStyle,
    this.suffixStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      minLines: minLines,
      maxLength: maxLength,
      maxLines: isMultiline ? minLines : 1,
      textAlign: textAlign ?? TextAlign.start,
      autofocus: autoFocus,
      controller: controller,
      keyboardType: inputType,
      textInputAction: inputAction,
      onChanged: onChanged,
      obscureText: obscureText,
      enabled: enabled,
      textDirection: direction,
      style: context.titleMedium
          .copyWith(color: enabled ? context.primaryColor : context.onBackgroundColor),
      decoration: InputDecoration(
        hintTextDirection: hintDirection,
        floatingLabelStyle: context.bodyMedium.copyWith(color: context.primaryColor),
        contentPadding: const EdgeInsets.all(Dimens.sPadding + Dimens.xsPadding),
        counterText: '',
        hintStyle: context.bodyMedium,
        labelStyle: context.bodyMedium.copyWith(color: context.scrimColor),
        prefixText: prefixText,
        suffixText: suffixText,
        prefixStyle: prefixStyle,
        suffixStyle: suffixStyle,
        errorText: errorText.isEmpty ? null : errorText,
        isDense: true,
        labelText: label,
        alignLabelWithHint: true,
        suffixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: context.outlineColor),
          borderRadius: BorderRadius.circular(Dimens.sPadding),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: context.outlineColor),
          borderRadius: BorderRadius.circular(Dimens.sPadding),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: context.outlineColor),
          borderRadius: BorderRadius.circular(Dimens.sPadding),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: context.outlineColor),
          borderRadius: BorderRadius.circular(Dimens.sPadding),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: context.outlineColor),
          borderRadius: BorderRadius.circular(Dimens.sPadding),
        ),
      ),
    );
  }
}
