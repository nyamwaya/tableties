import 'package:flutter/material.dart';

class InterestsChips extends StatelessWidget {
  final List<String> interests;
  final bool isEditMode;
  final ValueChanged<List<String>> onInterestChanged;

  const InterestsChips(
      {super.key, required this.interests,
      required this.isEditMode,
      required this.onInterestChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Interests', style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8.0,
            children: interests.map((interest) {
              return isEditMode
                  ? ChoiceChip(
                      label: Text(interest),
                      selected: true,
                      onSelected: (selected) {
                        // Handle chip selection/deselection
                      },
                    )
                  : Chip(label: Text(interest));
            }).toList(),
          ),
        ],
      ),
    );
  }
}
