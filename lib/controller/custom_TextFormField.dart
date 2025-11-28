import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  const CustomTextformfield({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.inputType,
    required this.validator,
  });
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType inputType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      autocorrect: false,
      validator: validator,
      onTap: inputType == TextInputType.datetime
          ? () async {
              final DateTime? date = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                initialDate: DateTime(2000),
              );
              if (date != null) {
                controller.text = "${date.day}/${date.month}/${date.year}";
              }
            }
          : null,
    );
  }
}
