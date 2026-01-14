import 'package:class_pulse/bloc/auth/auth_bloc.dart';
import 'package:class_pulse/pages/auth/auth_page.dart';
import 'package:class_pulse/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      // create authentication bloc and add initialize event
      create: (context) =>
          AuthBloc(FirebaseAuthService())..add(AuthEventInitialize()),
      child: MaterialApp(
        title: 'ClassPulse',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: const AuthPage(),
      ),
    ),
  );
}
