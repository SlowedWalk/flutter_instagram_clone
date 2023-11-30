import 'dart:async';

import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/constants/firebase_field_name.dart';
import 'package:instagram_clone/state/posts/typedefs/user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/state/user_info/model/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async {
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        // we already have the user info, so we don't need to save it again
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email ?? '',
        });
        return true;
      }

      // we don't have the user info, so we need to save it
      final payload = UserInfoPayload(
          userId: userId, displayName: displayName, email: email);

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    }
  }
}
