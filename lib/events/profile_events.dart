import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class DisplayUserFromMemory extends ProfileEvent {
  const DisplayUserFromMemory();

  @override
  List<Object> get props => [];
}

class BuildUserInterests extends ProfileEvent {
  final String userId;

  const BuildUserInterests({required this.userId});

  @override
  List<Object> get props => [userId];
}

class LoadUserProfile extends ProfileEvent {
  const LoadUserProfile();
}
