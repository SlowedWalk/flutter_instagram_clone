import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/firebase_options.dart';
import 'package:instagram_clone/state/auth/models/auth_results.dart';
import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone/state/auth/providers/is_loading_provider.dart';
import 'package:instagram_clone/views/components/loading/loading_screen.dart';
import 'package:instagram_clone/views/components/login/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
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
        home: Consumer(builder: (context, ref, child) {
          ref.listen<bool>(isLoadingProvider, (_, isLoading) {
            if (isLoading) {
              LoadingScreen.instance().show(context: context);
            } else {
              LoadingScreen.instance().hide();
            }
          });

          final isLoggedIn =
              ref.watch(authStateProvider).result == AuthResult.success;
          return isLoggedIn ? const MainView() : const LoginView();
        }));
  }
}

// for when the user is logged in
class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main View'),
      ),
      body: Consumer(builder: (_, ref, child) {
        final isLoading = ref.watch(authStateProvider).isLoading;
        return isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(currentUser!.photoURL!)),
                  ),
                ),
                Text(currentUser.email!),
                Text(currentUser.displayName ?? ""),
                MaterialButton(
                  onPressed: () async {
                    await ref.read(authStateProvider.notifier).logOut();
                  },
                  color: Colors.red,
                  child: const Text("Sign Out"),
                )
              ],
            ),
          );
        }
      )
    );
  }
}

// // for when the user is not logged in
// class LoginView extends ConsumerWidget {
//   const LoginView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login View'),
//       ),
//       body: Center(
//         child: SizedBox(
//           height: 60,
//           child: SignInButton(
//             Buttons.google,
//             text: "Google",
//             onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
//           ),
//         ),
//       ),
//     );
//   }
// }

// https://hitech-instagram-clone.firebaseapp.com/__/auth/handler
// import com.facebook.FacebookSdk;
// import com.facebook.appevents.AppEventsLogger;