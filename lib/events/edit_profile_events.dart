import 'package:equatable/equatable.dart';

abstract class EditProfileEvents extends Equatable {
  const EditProfileEvents();

  @override
  List<Object> get props => [];
}

class UpdateProfile extends EditProfileEvents {
  final Map<String, dynamic> profileChanges;

  const UpdateProfile({required this.profileChanges});

  @override
  List<Object> get props => [profileChanges];
}
