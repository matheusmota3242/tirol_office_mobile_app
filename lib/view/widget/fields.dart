import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class Fields {
  static Widget getTextFormField(
      TextEditingController controller, String fieldName, bool required) {
    return TextFormField(
      autofocus: true,
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

  static Widget getAddressTextFormField(
      TextEditingController controller, String fieldName, bool required) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: fieldName,
        labelStyle: MyTheme.labelStyle,
        filled: true,
        prefixIcon: const Icon(Icons.location_on),
        counterStyle: const TextStyle(color: Colors.red),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) => defaultValidation(value!, required),
      controller: controller,
    );
  }

  static Widget getEmailTextFormField(
      TextEditingController controller, String fieldName, bool required) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: fieldName,
        labelStyle: MyTheme.labelStyle,
        filled: true,
        prefixIcon: const Icon(Icons.email),
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
      TextEditingController controller, String fieldName, bool required) {
    return TextFormField(
      controller: controller,
      validator: (value) => defaultValidation(value!, required),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: fieldName,
        labelStyle: MyTheme.labelStyle,
        filled: true,
        counterStyle: const TextStyle(color: Colors.red),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  static Widget getPhoneNumberFormField(
      TextEditingController controller, String fieldName, bool required) {
    return TextFormField(
      controller: controller,
      validator: (value) => defaultValidation(value!, required),
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: fieldName,
        labelStyle: MyTheme.labelStyle,
        prefixIcon: const Icon(Icons.phone),
        filled: true,
        counterStyle: const TextStyle(color: Colors.red),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  static Widget getAddressNumberFormField(
      TextEditingController controller, String fieldName, bool required) {
    return TextFormField(
      controller: controller,
      validator: (value) => defaultValidation(value!, required),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: fieldName,
        labelStyle: MyTheme.labelStyle,
        prefixIcon: const Icon(Icons.pin),
        filled: true,
        counterStyle: const TextStyle(color: Colors.red),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
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
