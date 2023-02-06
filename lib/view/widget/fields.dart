import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class Fields {
  static Widget getTextFormField(
      TextEditingController controller, String fieldName, bool required) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: fieldName,
        labelStyle: MyTheme.labelStyle,
        filled: true,
        prefixIcon: const Icon(Icons.message),
        counterStyle: const TextStyle(color: Colors.red),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) => defaultValidation(value!, required),
      controller: controller,
    );
  }

  static Widget getTextFormWithMultipleLinesField(
      TextEditingController controller,
      String fieldName,
      int numberOfLines,
      bool required) {
    return TextFormField(
      maxLines: numberOfLines,
      decoration: InputDecoration(
        labelText: fieldName,
        labelStyle: MyTheme.labelStyle,
        filled: true,
        prefixIcon: const Icon(Icons.message),
        counterStyle: const TextStyle(color: Colors.red),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) => defaultValidation(value!, required),
      controller: controller,
    );
  }

  static Widget getNumberFormField(
      TextEditingController controller, String fieldName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fieldName,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
        const SizedBox(height: 12.0),
        TextFormField(
          controller: controller,
          validator: (value) =>
              value!.trim().isEmpty ? "Campo obrigatório" : null,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            filled: true,
            counterStyle: TextStyle(color: Colors.red),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  static defaultValidation(String value, bool required) {
    if (required) {
      return value.trim().isEmpty ? "Campo obrigatório" : null;
    } else {
      return null;
    }
  }
}
