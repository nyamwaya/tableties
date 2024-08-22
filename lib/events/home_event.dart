// home_event.dart

import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class CacheUser extends HomeEvent {}

class GetUser extends HomeEvent {}
