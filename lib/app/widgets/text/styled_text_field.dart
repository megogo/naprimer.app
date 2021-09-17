import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum StyledTextFieldErrorColor { red, white }

class StyledTextField {
  static const TextStyle defaultTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle defaultFilledTextStyle = TextStyle(
    fontSize: 16,
  );

  static const TextStyle defaultHintStyle = TextStyle(
    color: Color.fromARGB(125, 180, 180, 180),
  );

  static const TextStyle defaultLabelTextStyle = TextStyle(
      color: Color.fromARGB(125, 223, 223, 223), fontSize: 16, height: 0);

  static const TextStyle redErrorTextStyle = TextStyle(
    color: Color.fromARGB(255, 255, 64, 64),
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle whiteErrorTextStyle = TextStyle(
    color: Color.fromARGB(255, 140, 140, 140),
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static const textFieldBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide.none,
  );

  static const Color borderSideColor = Color.fromARGB(255, 223, 223, 223);
  static const Color fillColor = Color.fromARGB(255, 25, 25, 25);

  static TextFormField standard({
    TextEditingController? controller,
    String? labelText,
    TextStyle? labelStyle,
    TextStyle? style,
    TextCapitalization? textCapitalization,
    AutovalidateMode? autoValidateMode,
    FormFieldValidator<String>? validator,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    Widget? suffix,
    Widget? suffixIcon,
    bool obscureText = false,
    int maxLines = 1,
    int? minLines,
    int? maxLength,
    bool autoFocus = false,
    StyledTextFieldErrorColor errorColor = StyledTextFieldErrorColor.red,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle ?? defaultLabelTextStyle,
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderSideColor),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderSideColor),
        ),
        errorStyle: errorColor == StyledTextFieldErrorColor.red
            ? redErrorTextStyle
            : whiteErrorTextStyle,
        errorMaxLines: 3,
        suffix: suffix,
        suffixIcon: suffixIcon,
      ),
      style: style ?? defaultTextStyle,
      validator: validator,
      obscureText: obscureText,
      autofocus: autoFocus,
      autovalidateMode: autoValidateMode,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      controller: controller,
      textInputAction: textInputAction,
    );
  }

  static TextFormField filled({
    TextEditingController? controller,
    String? hintText,
    TextStyle? hintStyle,
    TextStyle? style,
    IconData? prefixIcon,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    int maxLines = 1,
    int? minLines,
    int? maxLength,
    FocusNode? focusNode,
    Widget? suffixIcon,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      style: style ?? defaultFilledTextStyle,
      focusNode: focusNode,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle ?? defaultHintStyle,
          filled: true,
          fillColor: fillColor,
          focusedBorder: textFieldBorder,
          border: textFieldBorder,
          suffixIcon: suffixIcon,
          suffix: suffix,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: defaultHintStyle.color, size: 24)
              : null,
          contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
    );
  }
}
