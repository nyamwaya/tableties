// home_event.dart

import 'package:TableTies/data_models/user_supabase.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class CacheUser extends HomeEvent {
  CacheUser(UserSupabase user);
}

class FetchUserById extends HomeEvent {}
