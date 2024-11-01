import 'package:flutter/material.dart';
import 'package:chat_app/core/themes/styles.dart';

class DefaultDormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String? Function(String?) validate;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final IconData? prefixIcon;
  final bool? obscureText;
  final IconData? suffixIcon;
  final VoidCallback? suffixPressed;
  final String? label;
  final String? hint;
  final bool? hasBorders;
  final bool? autofocus;
  final Color? filledColor;

  const DefaultDormField(
      {super.key,
      required this.controller,
      required this.type,
      required this.validate,
      this.label,
      this.hint,
      this.onTap,
      this.onEditingComplete,
      this.prefixIcon,
      this.obscureText,
      this.suffixIcon,
      this.suffixPressed,
      this.hasBorders,
      this.autofocus,
      this.filledColor});

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: obscureText ?? false,
      cursorColor: Theme.of(context).primaryColor,
      textAlign: TextAlign.start,
      validator: validate,
      onEditingComplete: onEditingComplete,
      onTap: onTap,
      autofocus: autofocus ?? false,
      focusNode: focusNode,
      style: Fonts.font14.copyWith(color: Theme.of(context).primaryColorDark),
      decoration: InputDecoration(
        filled: true,
        fillColor: filledColor ?? Colors.transparent,
        labelText: label,
        labelStyle: Fonts.font14.copyWith(color: Colors.grey.shade600),
        hintText: hint,
        hintStyle: Fonts.font14.copyWith(color: Colors.grey.shade600),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon,color: focusNode.hasFocus?Theme.of(context).primaryColor:Theme.of(context).primaryColorDark) : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon,color:focusNode.hasFocus?Theme.of(context).primaryColor:Theme.of(context).primaryColorDark),
                onPressed: suffixPressed,
              )
            : null,
        border: hasBorders ?? true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              )
            : null,
        enabledBorder: hasBorders ?? true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorDark,
                ),
              )
            : null,
        focusedBorder: hasBorders ?? true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
              )
            : null,
      ),
    );
  }
}
