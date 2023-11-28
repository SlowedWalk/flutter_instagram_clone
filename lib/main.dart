import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;

import 'package:instagram_clone/firebase_options.dart';
import 'package:instagram_clone/state/auth/backend/authenticator.dart';

extension Log on Object {
  void log() => debugPrint(toString());
}

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Clone'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              final result = await Authenticator().loginWithGoogle();
              result.log();
            },
            child: const Text('Sign in with Google'),
          ),
          TextButton(
            onPressed: () async {
              final result = await Authenticator().loginWithFacebook();
              result.log();
            },
            child: const Text('Sign in with Facebook'),
          ),
        ],
      ),
    );
  }
}

// https://hitech-instagram-clone.firebaseapp.com/__/auth/handler
// import com.facebook.FacebookSdk;
// import com.facebook.appevents.AppEventsLogger;