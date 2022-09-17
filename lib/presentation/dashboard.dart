import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/bloc/post_bloc.dart';
import 'package:social_network/presentation/sign_in.dart';
import 'package:social_network/repository/firebase_post_repository.dart';
import 'package:social_network/repository/post_repository.dart';
import '../widgets/post.dart';

import '../bloc/bloc/auth_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Getting the user from the FirebaseAuth Instance
    final user = FirebaseAuth.instance.currentUser!;
    return BlocProvider(
        create: (BuildContext context) =>
            PostBloc(postRepository: context.read<PostRepository>()),
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UnAuthenticated) {
                // Navigate to the sign in screen when the user Signs Out
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SignIn()),
                      (route) => false,
                );
              }
            },
          ),
          BlocListener<PostBloc, PostState>(
        listenWhen: (previous, current) =>
              previous.status != current.status &&
                  current.status == PostStatus.success,
              listener: (context, state) => Navigator.of(context).pop(),
          )
        ],
        //child: Builder( builder: (context) =>
          child: Column(
                  children: [
                    Builder(
                        builder: (context) => ElevatedButton(
                            onPressed: () => BlocProvider.of<PostBloc>(context)
                                .add(const PostSubmitted()),
                            child: const Icon(Icons.add))),
                    Expanded(child: _postsListView()),
                  ],

                  //)
      ))

        /*child: */
      //),
    ));
  }


Widget _postView(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _postAuthorRow(),
      _postImage(),
      _postCaption(),
      //_postCommentsButton(),
    ],
  );
}

Widget _postCaption() {
  return const Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 4,
    ),
    child: Text(
        'Test'),
  );
}

Widget _postImage() {
  return AspectRatio(
    aspectRatio: 1,
    child: Image(
      fit: BoxFit.cover,
      image: Image.asset('assets/images/tmp.jpeg').image,

    ),
  );
}


Widget _postAuthorRow() {
  const double avatarDiameter = 44;
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          width: avatarDiameter,
          height: avatarDiameter,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(avatarDiameter / 2),
            child: Image(
              image: Image.asset('assets/images/tmp.jpeg').image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Text(
        'User Test',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      )
    ],
  );
}

  Widget _postsListView() {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return _postView();
        });
  }
}