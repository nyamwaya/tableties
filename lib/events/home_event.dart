import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class InitializeHome extends HomeEvent {
  final String message;

  const InitializeHome(this.message);

  @override
  List<Object> get props => [message];
}
