import 'package:flutter/material.dart';
import '../../../core/theme/theme_extensions.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const AuthTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
      ),
      validator: validator,
    );
  }
}
