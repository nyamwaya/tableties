import 'package:TableTies/app.dart';
import 'package:TableTies/blocs/signup/sign_up_bloc.dart';
import 'package:TableTies/repo/sign_up_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(BlocProvider(
    create: (context) => SignUpBloc(repository: SignUpRepository()),
    child: TableTiesApp(),
  ));
}
