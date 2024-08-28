// profile_interests_section.dart
import 'package:TableTies/data_models/interests_model.dart';
import 'package:TableTies/data_models/user_profile_model.dart';
import 'package:flutter/material.dart';

class ProfileInterestsSection extends StatelessWidget {
  final List<Interest> userInterests;
  final bool isEditing;
  final List<String> selectedInterests;
  final bool showLimitError;
  final Function(List<String>, bool) updateInterests;

  ProfileInterestsSection({
    required this.userInterests,
    required this.isEditing,
    required this.selectedInterests,
    required this.showLimitError,
    required this.updateInterests,
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> chipColors = [
      Color(0xFFFFFFFF), // White for Travel
      Color(0xFFFFF4D6), // Light yellow for Big Foodie
      Color(0xFFD6F5FF), // Light blue for Photography
      Color(0xFFFFE6FF), // Light pink for Bollywood Movie
      Color(0xFFE6E6FF), // Light purple for Sharukh Khan
    ];
    // Sample interest categories and interests (replace with your actual data)
    final Map<String, List<String>> interestCategories = {
      'Outdoor': ['Hiking', 'Running', 'Camping', 'Biking', 'Swimming'],
      'Creative': ['Painting', 'Photography', 'Writing', 'Music', 'DIY'],
      'Tech': ['Coding', 'Gaming', 'AI', 'VR', 'Gadgets'],
    };

    // State to track selected interests and show error message
    List<String> selectedInterests = userInterests.map((e) => e.name).toList();
    bool showLimitError = false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interests',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),

        // Conditionally render the list of interests or the existing chips
        if (isEditing)
          Column(
            children: [
              ...interestCategories.entries.map((entry) {
                String category = entry.key;
                List<String> interests = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: interests.map((interest) {
                        bool isSelected = selectedInterests.contains(interest);
                        return ChoiceChip(
                          label: Text(interest),
                          selected: isSelected,
                          onSelected: (newValue) {
                            if (newValue) {
                              if (selectedInterests.length < 5) {
                                List<String> updatedInterests =
                                    List.from(selectedInterests)..add(interest);

                                updateInterests(updatedInterests, false);
                                showLimitError =
                                    false; // Reset error if selection is valid
                              } else {
                                updateInterests(selectedInterests, true);
                              }
                            } else {
                              List<String> updatedInterests =
                                  List.from(selectedInterests)
                                    ..remove(interest);
                              updateInterests(updatedInterests, false);
                            }
                          },
                          selectedColor: Colors.orange.withOpacity(0.2),
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.orange : Colors.black,
                          ),
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: isSelected ? Colors.orange : Colors.black,
                              width: 1.5,
                            ),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        );
                      }).toList(),
                    )
                  ],
                );
              }).toList(),
              if (showLimitError)
                Text(
                  'You can only select up to 5 interests.',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          )
        else
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: userInterests.asMap().entries.map((entry) {
              int index = entry.key;
              Interest interest = entry.value;
              return Chip(
                label: Text(
                  interest.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                backgroundColor: chipColors[index % chipColors.length],
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 1.5, // Slightly thicker border
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              );
            }).toList(),
          ),
      ],
    );
  }
}
