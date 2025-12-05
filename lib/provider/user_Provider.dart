import 'package:flutter_riverpod/legacy.dart';
import 'package:makarr/appLogger.dart';
import 'package:makarr/data/user_Data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider extends StateNotifier<UserData?> {
  UserProvider() : super(null);
  Future<void> fetchUserInfo(String id) async {
    if (state != null) return;
    try {
      AppLogger.i("fetching user data...", className: runtimeType.toString());
      final doc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(id)
          .get();
      if (!doc.exists) {
        AppLogger.w(
          "this doc dose not exiest",
          className: runtimeType.toString(),
        );
        state = null;
      }
      UserData().setUsersfromMap(doc.data()!);
      state = UserData();
      AppLogger.i("userdata is featched");
    } on FirebaseException catch (e) {
      AppLogger.e(
        "${e.message.toString()}  ,${e.code}",
        className: runtimeType.toString(),
      );
    }
  }

  void clearState() {
    state = null;
    AppLogger.i("Sign out state is empty");
  }
}

final userProvider = StateNotifierProvider<UserProvider, UserData?>(
  (ref) => UserProvider(),
);
