import 'package:TableTies/utils/resource.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {
  final String? user;
  const ProfileInitial([this.user]);

  @override
  List<Object> get props => [user ?? ''];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String user;
  const ProfileLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}
