import 'package:TableTies/screens/profile/profile_content.dart';
import 'package:flutter/material.dart';
import 'package:choice/choice.dart';
import 'package:TableTies/data_models/interests_model.dart';

class ProfileInterestsSection extends StatelessWidget {
  final List<Interest> userInterests;
  final List<AllInterests> allInterests;
  final bool isEditing;
  final Function(List<String>) onInterestsUpdated;

  ProfileInterestsSection({
    required this.userInterests,
    required this.allInterests,
    required this.isEditing,
    required this.onInterestsUpdated,
  });

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      return _buildEditableInterests(context);
    } else {
      return _buildDisplayInterests(context);
    }
  }

  Widget _buildEditableInterests(BuildContext context) {
    // This list will store the user's current selections
    final List<String> currentFormSelections = <String>[];

    final allInterestsNames =
        allInterests.map((interest) => interest.name).toList();

    // This list will store the user's current selections
    final List<String> persistentUserInterests = [];

    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(
        children: [
          FormField<List<String>>(
            autovalidateMode: AutovalidateMode.always,
            initialValue: persistentUserInterests,
            onSaved: (value) => onInterestsUpdated(persistentUserInterests),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please select at least 5 interests';
              }
              if (value!.length != 5) {
                return "Exactly 5 interests must be selected";
              }
              return null;
            },
            builder: (formState) {
              return Column(
                children: [
                  InlineChoice<String>(
                    multiple: true,
                    clearable: true,
                    value: formState.value ?? [],
                    onChanged: (val) {
                      formState.didChange(val);
                      persistentUserInterests.clear();
                      persistentUserInterests.addAll(val);
                    },
                    itemCount: allInterestsNames.length,
                    itemBuilder: (selection, i) {
                      return ChoiceChip(
                        selected: selection.selected(allInterestsNames[i]),
                        onSelected: selection.onSelected(allInterestsNames[i]),
                        label: Text(allInterestsNames[i]),
                      );
                    },
                    listBuilder: ChoiceList.createWrapped(
                      spacing: 10,
                      runSpacing: 10,
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      formState.errorText ??
                          '${formState.value!.length}/5 selected',
                      style: TextStyle(
                        color: formState.hasError
                            ? Colors.redAccent
                            : Colors.green,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDisplayInterests(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: userInterests.map((interest) {
        return Chip(
          label: Text(interest.name),
        );
      }).toList(),
    );
  }
}
