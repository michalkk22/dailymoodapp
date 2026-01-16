import 'dart:async';

import 'package:class_pulse/bloc/auth/auth_bloc.dart';
import 'package:class_pulse/data/repositories/firebase_users_repository.dart';
import 'package:class_pulse/pages/auth/auth_page.dart';
import 'package:class_pulse/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  // 1) Flutter Fehler IM UI anzeigen (sonst weißer Screen)
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      color: const Color(0xFFF0F4F8),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Text(
            'APP ERROR:\n\n${details.exception}\n\n${details.stack}',
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ),
      ),
    );
  };

  // 2) Alle async Fehler abfangen
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    runApp(
      BlocProvider(
        create: (context) =>
            AuthBloc(FirebaseAuthService(), FirebaseUsersRepository())
              ..add(const AuthEventInitialize()),
        child: MaterialApp(
          title: 'ClassPulse',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFF0F4F8),
          ),
          home: const AuthPage(),
        ),
      ),
    );
  }, (error, stack) {
    // erscheint im Terminal + wird über ErrorWidget sichtbar
    // ignore: avoid_print
    print('ZONED ERROR: $error');
    // ignore: avoid_print
    print(stack);
  });
}
