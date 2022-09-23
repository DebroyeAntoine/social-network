import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_network/presentation/sign_in.dart';
import 'package:social_network/repository/firebase_post_repository.dart';
import 'package:social_network/repository/post_repository.dart';

import 'bloc/auth_bloc/auth_bloc.dart';
import 'data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final postRepository = FireBasePostRepository();
  runApp(MyApp(postRepository: postRepository));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.postRepository}) : super(key: key);

  final PostRepository postRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: postRepository),
          RepositoryProvider(
            create: (context) => AuthRepository(),
          ),
        ],
        child: BlocProvider(
          create: (context) => AuthBloc(
            authRepository: RepositoryProvider.of<AuthRepository>(context),
          ),
          child: const MaterialApp(home: SignIn()),
        ));
  }
}
