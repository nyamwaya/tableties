import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final String message;

  const HomeLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class HomeError extends HomeState {
  final String error;

  const HomeError(this.error);

  @override
  List<Object> get props => [error];
}
