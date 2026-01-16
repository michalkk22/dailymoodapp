import 'package:class_pulse/bloc/auth/auth_bloc.dart';
import 'package:class_pulse/pages/auth/login_pages.dart';
import 'package:class_pulse/pages/auth/set_user_data_page.dart';
import 'package:class_pulse/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return HomePage();
        } else if (state is AuthStateNeedUserData) {
          return SetUserDataPage(user: state.user);
        } else {
          return LoginPage();
        }
      },
      listener: (BuildContext context, AuthState state) {
        if (state is AuthStateLoggedOut) {
          if (state.e != null) {
            // TODO: add error dialog here
            print(state.e);
          }
        }
      },
    );
  }
}
