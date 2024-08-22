import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TableTies/events/home_event.dart';
import 'package:TableTies/state/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<InitializeHome>(_onInitializeHome);
  }

  void _onInitializeHome(InitializeHome event, Emitter<HomeState> emit) {
    try {
      emit(HomeLoaded(event.message));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
