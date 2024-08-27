// home_event.dart

import 'package:TableTies/data_models/user_supabase.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchUserById extends HomeEvent {
  final String userId;

  const FetchUserById({required this.userId});

  @override
  List<Object> get props => [userId];
}
