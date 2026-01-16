import 'package:class_pulse/bloc/auth/auth_bloc.dart';
import 'package:class_pulse/data/models/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionsListPage extends StatelessWidget {
  const SessionsListPage({super.key, required this.sessions});

  final List<Session> sessions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthEventLogOut());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
