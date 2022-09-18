import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/bloc/post_bloc.dart';
import 'package:social_network/repository/post_repository.dart';

import '../repository/models/post.dart';

class EditPostPage extends StatelessWidget {
  const EditPostPage({super.key});

  static Route<void> route({Post? initialPost}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => PostBloc(
          postRepository: context.read<PostRepository>(),
          //initialTodo: initialTodo,
        ),
        child: const EditPostPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const EditPostView();
  }
}

class EditPostView extends StatelessWidget {
  const EditPostView

  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Post"),
      ),
    );
  }
}