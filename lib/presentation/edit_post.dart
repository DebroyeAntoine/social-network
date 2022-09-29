
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
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.accessibility),
                hintText: 'What\'s name of your activty today ?',
                labelText: 'Title of your activity *',
              ),
              onChanged: (title) {
                context.read<PostBloc>().add(PostTitleChanged(title: title));
              },
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                DropdownButton<String>(
                  items: sports.isNotEmpty
                      ? sports.map((test) {
                    return DropdownMenuItem(value: test, child: Text(test));
                  }).toList()
                      : const [],
                  value: sport,
                  hint: const Text("Choisissez votre sport"),
                  onChanged: (sport) {
                    context.read<PostBloc>().add(PostSportChanged(sport: sport));
                  },
                ),
                const SizedBox(width: 25),
                const Text("Distance :"),
                const SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.end,
                    /*decoration: const InputDecoration(
                      labelText: 'Distance',
                    ),*/
                    keyboardType: TextInputType.number,
                    onChanged: (distance) {
                      context.read<PostBloc>().add(PostDistanceChanged(distance: double.parse(distance)));
                    },
                  ),
                ),
                const SizedBox(width: 5),
                const Text("kms"),
                const SizedBox(width: 30),
              ],
            ),
          ])
        );
  }
}