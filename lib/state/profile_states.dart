import 'package:TableTies/data_models/user_profile_model.dart';
import 'package:TableTies/utils/resource.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  final UserProfile? userProfile; // Add userProfile as a field

  const ProfileState({this.userProfile}); // Add named parameter in constructor

  @override
  List<Object?> get props => [userProfile];
}

class ProfileInitial extends ProfileState {
  final String? user;
  const ProfileInitial([this.user]);

  @override
  List<Object> get props => [user ?? ''];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  @override
  final UserProfile userProfile;
  const ProfileLoaded(this.userProfile)
      : super(userProfile: userProfile); // Pass as named argument

  @override
  List<Object?> get props => [userProfile];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}
