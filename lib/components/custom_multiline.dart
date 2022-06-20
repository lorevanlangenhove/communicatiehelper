import 'package:flutter/material.dart';
import 'package:communicatiehelper/components/constants.dart';

class CustomMultiline extends StatelessWidget {
  CustomMultiline({required this.controller, required this.inputLabel});

  final TextEditingController controller;
  final String inputLabel;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: kTextFieldDecoration.copyWith(
          hintText: inputLabel,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 50, horizontal: 20)),
      controller: controller,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'De $inputLabel is verplicht';
        }
        return null;
      },
    );
  }
}
