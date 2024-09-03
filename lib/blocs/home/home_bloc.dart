// home_bloc.dart
import 'package:TableTies/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TableTies/events/home_event.dart';
import 'package:TableTies/repo/supabase_repo.dart';
import 'package:TableTies/utils/resource.dart';
import 'package:TableTies/state/home_state.dart';
import 'package:TableTies/utils/user_upabase_json_utils.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SupabaseRepository supabaseRepository;

  HomeBloc({required this.supabaseRepository}) : super(HomeInitial()) {
    on<FetchUserById>(_fetchUserById);
    on<CheckProfileCompletion>(_checkProfileCompletion);
  }

  void _fetchUserById(FetchUserById event, Emitter<HomeState> emit) async {
    try {
      final userId = await returnValidUserId(event.userId);
      final user = await supabaseRepository.getUserById(userId: userId);
      final userModel = user.data;
      // final fixedUser = user.data.toJson();

      // Convert UserSupabase to Map<String, dynamic>
      //final userMap = userModel.toJson();

      // Convert Map to JSON string
      // dont need this. there is a below function that serializes and deserializes user object
      // final fixedUser = jsonEncode(userMap);

      String jsonString = UserSupabaseJsonUtils.userSupabaseToJson(user.data);

      // Save the user to SharedPreferences
      saveUserObject(jsonString);

      emit(HomeSuccess(Resource.success(userModel)));
    } catch (e) {
      emit(HomeFailure(Resource.failure("An error occurred: ${e.toString()}")));
    }
  }

  void _checkProfileCompletion(
      CheckProfileCompletion event, Emitter<HomeState> emit) async {
    try {
      final userId = await returnValidUserId("");
      final result = await supabaseRepository.isProfileComplete(userId: userId);

      switch (result.status) {
        case ResourceStatus.success:
          if (result.data!.isEmpty) {
            emit(HomeProfileComplete());
          } else {
            // maybe rename this to missing profile fields.
            emit(HomeProfileIncomplete(missingFields: result.data!));
          }
          break;
        case ResourceStatus.failure:
          emit(HomeFailure(
              Resource.failure("Profile check failed: ${result.error}")));
          break;
        case ResourceStatus.loading:
          emit(HomeLoading("Checking profile completion"));
          break;
      }
    } catch (e) {
      emit(HomeFailure(Resource.failure(
          "An error occurred while checking profile: ${e.toString()}")));
    }
  }

  Future<String> returnValidUserId(String? userId) async {
    if (userId != null && userId.isNotEmpty) return userId;
    return await getUserId() ?? "";
  }
}
