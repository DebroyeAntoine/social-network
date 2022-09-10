import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_network/presentation/sign_in.dart';

import 'bloc/bloc/auth_bloc.dart';
import 'data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: const MaterialApp(
            home: SignIn()
        ),
      ),
    );
  }
}

