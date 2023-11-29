import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_clone/state/auth/constants/constants.dart';
import 'package:instagram_clone/state/auth/models/auth_results.dart';
import 'package:instagram_clone/state/posts/typedefs/user_id.dart';

class Authenticator {
  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isLoggedIn => userId != null;
  String get displayName => FirebaseAuth.instance.currentUser?.displayName ?? '';
  String? get email => FirebaseAuth.instance.currentUser?.email;

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  Future<void> signInWithGoogle() async {
    final googleAuthProvider = GoogleAuthProvider();
    await FirebaseAuth.instance.signInWithPopup(googleAuthProvider);
  }

  Future<AuthResult> loginWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken?.token;
    log("Facebook token: $token");
    if (token == null) {
      return AuthResult.aborted;
    }

    final credential = FacebookAuthProvider.credential(token);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;
      if (e.code == Constants.accountExistsWithDifferentCredentials &&
          email != null &&
          credential != null
      ) {
        final providers = await FirebaseAuth.instance
            .fetchSignInMethodsForEmail(email);
        if (providers.contains(Constants.googleCom)) {
          await loginWithGoogle();
          FirebaseAuth.instance.currentUser?.linkWithCredential(
              credential
          );
        }
        return AuthResult.success;
      }
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithGoogle() async {
    final googleSignIn = GoogleSignIn(
      scopes: [
        Constants.emailScope,
        'https://www.googleapis.com/auth/userinfo.profile'
        ],
    );

    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }
    final googleAuth = await signInAccount.authentication;
    final oauthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

}