import 'dart:convert';

import 'package:TableTies/data_models/user_profile_model.dart';
import 'package:TableTies/repo/profile_repo.dart';
import 'package:TableTies/utils/utils.dart';
import 'package:TableTies/events/edit_profile_events.dart';
import 'package:TableTies/state/edit_profile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileBloc extends Bloc<EditProfileEvents, EditProfileState> {
  final ProfileREpository profileRepository;

  EditProfileBloc({required this.profileRepository})
      : super(EditProfileInitial()) {
    on<UpdateProfile>(_onUpdateProfile);
  }

  void _onUpdateProfile(
      UpdateProfile event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());

    try {
      final userString = await getUserObject();
      final userJson = jsonDecode(userString!);
      final currentUser = UserProfile.fromJson(userJson);

      final updatedFields = event.profileChanges;

      // Validate fields
      final validationErrors = _validateFields(currentUser, updatedFields);
      if (validationErrors.isNotEmpty) {
        emit(EditProfileValidationError(
          errors: validationErrors,
          submittedData: event.profileChanges, // Include submitted data here
        ));
        return;
      }

      // Check if any fields have actually changed
      final changedFields = _getChangedFields(currentUser, updatedFields);
      if (changedFields.isEmpty) {
        emit(EditProfileNoChanges());
        return;
      }

      // Merge current user data with changed fields
      final mergedData = _mergeUserData(currentUser, changedFields);

      // Sanitize input
      final sanitizedData = _sanitizeData(mergedData);

      // Update the profile
      final result = await profileRepository.updateUser(sanitizedData);
      // save the new user object.
      //   emit(EditProfileSuccess(updatedFields: result));
    } catch (e) {
      emit(EditProfileError(
          message: 'Failed to update profile: ${e.toString()}'));
    }
  }

  Map<String, String> _validateFields(
      UserProfile currentUser, Map<String, dynamic> updatedFields) {
    final errors = <String, String>{};

    void validateField(String field, String? value, String? currentValue,
        {int maxLength = 255}) {
      if (value == null || value.isEmpty) {
        if (currentValue == null || currentValue.isEmpty) {
          errors[field] = '$field is required';
        }
      } else if (value.length > maxLength) {
        errors[field] = '$field must be less than $maxLength characters';
      }
    }

    validateField(
        'firstName', updatedFields['firstName'], currentUser.firstName,
        maxLength: 50);
    validateField('lastName', updatedFields['lastName'], currentUser.lastName,
        maxLength: 50);
    validateField(
        'occupation', updatedFields['occupation'], currentUser.occupation,
        maxLength: 100);
    validateField('bio', updatedFields['bio'], currentUser.bio, maxLength: 500);

    return errors;
  }

  Map<String, dynamic> _getChangedFields(
      UserProfile currentUser, Map<String, dynamic> updatedFields) {
    return updatedFields.map((key, value) {
      if (value != null &&
          value.isNotEmpty &&
          value != _getUserField(currentUser, key)) {
        return MapEntry(key, value);
      }
      return MapEntry(key, null);
    })
      ..removeWhere((key, value) => value == null);
  }

  dynamic _getUserField(UserProfile user, String field) {
    switch (field) {
      case 'firstName':
        return user.firstName;
      case 'lastName':
        return user.lastName;
      case 'occupation':
        return user.occupation;
      case 'bio':
        return user.bio;
      // Add other fields as needed
      default:
        return null;
    }
  }

  Map<String, dynamic> _mergeUserData(
      UserProfile currentUser, Map<String, dynamic> changedFields) {
    final mergedData = {
      'firstName': currentUser.firstName,
      'lastName': currentUser.lastName,
      'occupation': currentUser.occupation,
      'bio': currentUser.bio,
      // Add other fields as needed
    };
    changedFields.forEach((key, value) {
      mergedData[key] = value;
    });
    return mergedData;
  }

  Map<String, dynamic> _sanitizeData(Map<String, dynamic> data) {
    return data.map((key, value) {
      if (value is String) {
        // Basic sanitization: trim whitespace and remove any HTML tags
        return MapEntry(key, value.trim().replaceAll(RegExp(r'<[^>]*>'), ''));
      }
      return MapEntry(key, value);
    });
  }
}
