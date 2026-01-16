import 'package:class_pulse/bloc/auth/auth_bloc.dart';
import 'package:class_pulse/bloc/responses/mock_sessions_repo.dart';
import 'package:class_pulse/bloc/sessions/sessions_bloc.dart';
import 'package:class_pulse/pages/home/sessions_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionsBloc(MockSessionsRepo()),
      child: BlocBuilder<SessionsBloc, SessionsState>(
        builder: (context, state) {
          final user = context.read<AuthBloc>().user;
          print(user);
          if (state is SessionStateLoaded) {
            return SessionsListPage(sessions: state.sessions);
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
