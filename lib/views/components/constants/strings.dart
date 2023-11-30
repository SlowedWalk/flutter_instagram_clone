import 'package:flutter/foundation.dart';

@immutable
class Strings {
  static const allowLikesTitle = 'Allow Likes';
  static const allowLikesDescription =
      'By allowing likes, you will be able to see how many people liked your posts.';
  static const allowLikesStorageKey = 'allow_likes';
  static const allowCommentsTitle = 'allow comments';
  static const allowCommentsDescription =
      'By allowing comments, users will be able to comment on your posts.';
  static const allowCommentsStorageKey = 'allow_comments';

  static const comment = 'comment';
  static const loading = 'Loading...';
  static const people = 'people';
  static const person = 'person';
  static const likedThis = 'liked this';

  static const delete = 'Delete';
  static const areYouSureYouWantToDeleteThis = 'Are you sure you want to delete this?';

  static const logOut = 'Log Out';
  static const areYouSureYouWantTologOut = 'Are you sure you want to log out?';
  static const cancel = 'Cancel';

  const Strings._();
}
