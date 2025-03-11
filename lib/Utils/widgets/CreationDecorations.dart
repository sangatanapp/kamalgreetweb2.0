import 'package:flutter/material.dart';
import 'package:kamal_greet_web_2/Utils/values/AppConstants.dart';

class CreationDecorations {
  OutlineInputBorder textFieldOutline() {
    return OutlineInputBorder(
      borderRadius: AppConstants.borderRadius,
      borderSide: AppConstants.borderSide,
    );
  }

  InputDecoration inputDecoration({
    String? labelText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? hintText,
    String? counterText,
    Widget? prefix,
    String? prefixText,
    bool? enabled,
  }) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: hintText,
      counterText: counterText,
      prefix: prefix,
      prefixText: prefixText,
      fillColor: Colors.white,
      focusColor: Colors.white,
      filled: true,
      hoverColor: Colors.white,
      enabled: enabled ?? true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      enabledBorder: CreationDecorations().textFieldOutline(),
      border: CreationDecorations().textFieldOutline(),
      errorBorder: CreationDecorations().textFieldOutline(),
      disabledBorder:CreationDecorations().textFieldOutline(),
    );
  }


}
