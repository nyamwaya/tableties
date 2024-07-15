import 'package:TableTies/app.dart';
import 'package:TableTies/blocs/login/login_bloc.dart';
import 'package:TableTies/blocs/signup/sign_up_bloc.dart';
import 'package:TableTies/services/dio_client.dart';
import 'package:TableTies/repo/login_repo.dart';
import 'package:TableTies/repo/sign_up_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  // Initialize the singleton DioClient
  final client = DioClient();

  // Create repositories with the singleton DioClient
  final loginRepository = LoginRepository(client: client);
  final singupRepository = SignUpRepository(client: client);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => LoginBloc(repository: loginRepository)),
      BlocProvider(
          create: (context) => SignUpBloc(repository: singupRepository))
    ],
    child: TableTiesApp(),
  ));
}
