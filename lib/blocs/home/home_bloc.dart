// home_bloc.dart
import 'package:TableTies/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TableTies/events/home_event.dart';
import 'package:TableTies/repo/supabase_repo.dart';
import 'package:TableTies/utils/resource.dart';
import 'package:TableTies/state/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SupabaseRepository supabaseRepository;

  HomeBloc({required this.supabaseRepository}) : super(HomeInitial()) {
    on<FetchUserById>(_fetchUserById);
  }

  void _fetchUserById(FetchUserById event, Emitter<HomeState> emit) async {
    try {
      final userId = await returnValidUserId(event.userId);
      final user = await supabaseRepository.getUserById(userId: userId);
      emit(HomeSuccess(Resource.success(user)));
    } catch (e) {
      emit(HomeFailure(Resource.failure("An error occurred: ${e.toString()}")));
    }
  }

  Future<String> returnValidUserId(String userId) async {
    if (userId.isNotEmpty) return userId;
    return await getUserId() ?? "";
  }

  void _cacheUser(String user) {
    saveUserObject(user);
  }
}
