
import 'package:flutter/cupertino.dart';
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
    return BlocBuilder<PostBloc, PostState>(
  builder: (context, state) {
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
            const SizedBox(height: 30),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'How was your activity ?',
                labelText: 'Description',
              ),
              onChanged: (description) {
                context.read<PostBloc>().add(PostDescriptionChanged(description: description));
              },
            ),
            const SizedBox(height: 30),
            Text("Durée: " + (context
                          .read<PostBloc>()
                          .state
                          .duration
                          ?.inHours
                          .toString() ??
                      '00') +
                  'h:' +
                  (context
                          .read<PostBloc>()
                          .state
                          .duration
                          ?.inMinutes
                          .remainder(60)
                          .toString() ??
                      '00') +
                  'm:' +
                  (context
                          .read<PostBloc>()
                          .state
                          .duration
                          ?.inSeconds
                          .remainder(60)
                          .toString() ??
                      '00') +
                  's:'),
              TextButton(
              child: const Text('Durée'),
              onPressed: () {
                showMyDialog(context);
              },
            ),
     ElevatedButton(
    onPressed: () {
      context.read<PostBloc>().add(PostSubmitted());
    },
    child: const Text("Valider"),
     ),
          ])
        );
  },
);
  }

  void showMyDialog(BuildContext context) {
    final bloc = context.read<PostBloc>();
    showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return BlocProvider<PostBloc>.value(
              value: bloc,
              child: AlertDialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 20),
                content: SizedBox(
                    width: 200,
                    height: 200,
                    child: CupertinoTimerPicker(
                        onTimerDurationChanged: (Duration duration) {
                          bloc.add(PostDurationChanged(duration: duration));
                    })),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              ));
        });
  }
}