import 'package:class_pulse/bloc/auth/auth_bloc.dart';
import 'package:class_pulse/pages/auth/auth_page.dart';
import 'package:class_pulse/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    BlocProvider(
      create: (context) =>
      AuthBloc(FirebaseAuthService())
        ..add(const AuthEventInitialize()),
      child: MaterialApp(
        title: 'ClassPulse',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const AuthPage(),
      ),
    ),
  );
}