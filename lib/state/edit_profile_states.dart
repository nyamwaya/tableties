import 'package:equatable/equatable.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object?> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final Map<String, dynamic> updatedFields;

  const EditProfileSuccess({required this.updatedFields});

  @override
  List<Object?> get props => [updatedFields];
}

class EditProfileValidationError extends EditProfileState {
  final Map<String, String> errors;

  const EditProfileValidationError({required this.errors});

  @override
  List<Object?> get props => [errors];
}

class EditProfileNoChanges extends EditProfileState {}

class EditProfileError extends EditProfileState {
  final String message;

  const EditProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}
