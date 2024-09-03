import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final bool isEditMode;
  final ValueChanged<String> onChanged;

  const ProfileField(
      {super.key, required this.label,
      required this.value,
      required this.isEditMode,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          isEditMode
              ? TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter $label',
                  ),
                  onChanged: onChanged,
                  controller: TextEditingController(text: value),
                )
              : Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
