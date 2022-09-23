
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/bloc/post_bloc/post_bloc.dart';
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
        )..add(const NewPostLoaded()),
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
    final sports = context.select((PostBloc bloc) => bloc.state.sports);
    final sport = context.select((PostBloc bloc) => bloc.state.sport);
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Post"),
      ),
      body: DropdownButton<String>(
        items: sports.isNotEmpty
            ? sports.map((test) {
          return DropdownMenuItem(value: test, child: Text(test));
        }).toList()
            : const [],
        value: sport,
        onChanged: (sport) {
          context.read<PostBloc>().add(PostSportChanged(sport: sport));
        },
      ),
    );
  }
}