import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/backend/authenticator.dart';
import 'package:instagram_clone/state/auth/models/auth_results.dart';
import 'package:instagram_clone/state/auth/models/auth_state.dart';
import 'package:instagram_clone/state/posts/typedefs/user_id.dart';
import 'package:instagram_clone/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.initial()) {
    if (_authenticator.isLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> logOut() async {
    state = state.copyWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.initial();
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      log("saving user info ...");
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.userId,
    );
  }

  Future<void> saveUserInfo({required UserId userId}) =>
    _userInfoStorage.saveUserInfo(
      userId: userId,
      displayName: _authenticator.displayName,
      email: _authenticator.email,
    );
}
