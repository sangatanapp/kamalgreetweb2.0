import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kamal_greet_web_2/Utils/widgets/CreationDecorations.dart';

class DynamicTextfield extends StatelessWidget {
  final double? height;
  final TextEditingController? controller;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final GestureTapCallback? onTap;
  final Function(String value)? onSubmit;
  final Function(String value)? onChange;
  final Widget? prefix;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String? value)? validator;
  final Color? fillColor;
  final BorderRadius? borderRadius;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? counterText;
  final String? prefixText;
  final bool? filled;
  final double? width;
  final bool? readOnly;
  final bool? enabled;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const DynamicTextfield({
    Key? key,
    this.height,
    this.controller,
    this.labelText,
    this.maxLines,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.borderRadius,
    this.readOnly,
    this.enabled,
    this.hintText,
    this.keyboardType,
    this.counterText,
    this.prefixText,
    this.filled,
    this.width,
    this.onTap,
    this.onSubmit,
    this.onChange,
    this.inputFormatters,
    this.maxLength,
    this.prefix,
    this.validator,
    this.autovalidateMode,
    this.minLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: validator,
      onTap: onTap,
      minLines: minLines,
      readOnly: readOnly ?? false,
      controller: controller,
      autovalidateMode: autovalidateMode,
      decoration: CreationDecorations().inputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        enabled: enabled,
        suffixIcon: suffixIcon,
        hintText: hintText,
        counterText: counterText,
        prefix: prefix,
        prefixText: prefixText,
      ),
      keyboardType: keyboardType,
    );
  }
}
