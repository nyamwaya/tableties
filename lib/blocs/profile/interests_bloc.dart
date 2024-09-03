import 'package:TableTies/events/interests_event.dart';
import 'package:TableTies/state/interests_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterestsBloc extends Bloc<InterestsEvent, InterestsState> {
  InterestsBloc({required List<String> initialInterests})
      : super(InterestsState(selectedInterests: initialInterests)) {
    on<AddInterest>(_onAddInterest);
    on<RemoveInterest>(_onRemoveInterest);
  }

  void _onAddInterest(AddInterest event, Emitter<InterestsState> emit) {
    if (state.selectedInterests.length < 5 &&
        !state.selectedInterests.contains(event.interest)) {
      final updatedInterests = [...state.selectedInterests, event.interest];
      emit(state.copyWith(
          selectedInterests: updatedInterests, errorMessage: null));
    } else if (state.selectedInterests.length >= 5) {
      emit(state.copyWith(
          errorMessage: 'You can only select up to 5 interests.'));
    }
  }

  void _onRemoveInterest(RemoveInterest event, Emitter<InterestsState> emit) {
    final updatedInterests =
        state.selectedInterests.where((i) => i != event.interest).toList();
    emit(state.copyWith(
        selectedInterests: updatedInterests, errorMessage: null));
  }
}
