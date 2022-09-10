import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/auth_bloc.dart';

class ProfileView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  "hello"),
              ElevatedButton(
                child: const Text('Sign Out'),
                onPressed: () {
                  // Signing out the user
                  context.read<AuthBloc>().add(SignOutRequested());
                },
              ),
            ]
        )
    )
    );
  }
}