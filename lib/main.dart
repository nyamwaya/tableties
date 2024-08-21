import 'package:TableTies/app.dart';
import 'package:TableTies/blocs/login/login_bloc.dart';
import 'package:TableTies/blocs/signup/sign_up_bloc.dart';
import 'package:TableTies/repo/supabase_repo.dart';
import 'package:TableTies/services/dio_client.dart';
import 'package:TableTies/repo/login_repo.dart';
import 'package:TableTies/repo/sign_up_repo.dart';
import 'package:TableTies/services/preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Shared Preferences
  await SharedPreferences.getInstance();

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // Global variable for accessing Supabase client
  final supabase = Supabase.instance.client;

  // Create SupabaseRepository
  final supabaseRepository = SupabaseRepository(Supabase.instance.client);

  // Initialize the singleton DioClient
  final client = DioClient();

  // Create repositories with the singleton DioClient
  final loginRepository = LoginRepository(client: client);
  final singupRepository = SignUpRepository(client: client);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (context) => LoginBloc(
              repository: loginRepository,
              supabaseRepository: supabaseRepository)),
      BlocProvider(
          create: (context) => SignUpBloc(
                repository: singupRepository,
                supabaseRepository: supabaseRepository,
              )),
    ],
    child: TableTiesApp(),
  ));
}
