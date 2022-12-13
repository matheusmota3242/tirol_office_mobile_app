import 'package:flutter/material.dart';

class Fields {
  static Widget getTextFormField(
      TextEditingController controller, String fieldName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fieldName,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
        const SizedBox(height: 12.0),
        TextFormField(
          decoration: const InputDecoration(
            filled: true,
            counterStyle: TextStyle(color: Colors.red),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) =>
              value!.trim().isEmpty ? "Campo obrigatório" : null,
          controller: controller,
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  static Widget getTextFormWithMultipleLinesField(
      TextEditingController controller, String fieldName, int numberOfLines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fieldName,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
        const SizedBox(height: 12.0),
        TextFormField(
          maxLines: numberOfLines,
          decoration: const InputDecoration(
            filled: true,
            counterStyle: TextStyle(color: Colors.red),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) =>
              value!.trim().isEmpty ? "Campo obrigatório" : null,
          controller: controller,
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  static Widget getNumberFormField(
      TextEditingController controller, String fieldName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Número",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
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
}
