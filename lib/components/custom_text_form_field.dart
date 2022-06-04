import 'package:flutter/material.dart';
import 'package:communicatiehelper/constants.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({required this.controller, required this.inputLabel});

  final TextEditingController controller;
  final String inputLabel;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: kTextFieldDecoration.copyWith(hintText: inputLabel),
      controller: controller,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'De $inputLabel is verplicht';
        }
        return null;
      },
    );
  }
}
