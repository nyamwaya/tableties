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
