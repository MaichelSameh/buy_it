import 'package:flutter/material.dart';

import '../const/const_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  CustomTextField({
    required this.hint,
    required this.icon,
    required this.obscureText,
    required this.controller,
    required this.validator,
    this.keyboardType = TextInputType.text,
  });
  final OutlineInputBorder _textFieldBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(20),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        validator: validator,
        cursorColor: KMainColor,
        decoration: InputDecoration(
          hintText: hint,
          fillColor: KSecondaryColor,
          enabledBorder: _textFieldBorder,
          focusedBorder: _textFieldBorder,
          errorBorder: _textFieldBorder.copyWith(
            borderSide: BorderSide(color: Colors.red),
          ),
          filled: true,
          prefixIcon: Icon(icon, color: KMainColor),
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
      ),
    );
  }
}
