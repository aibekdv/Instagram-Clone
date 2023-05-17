import 'dart:io';

import 'package:insta_clone/feature/domain/entities/user/user_entity.dart';

abstract class FirebaseRepository {
  // Credential user
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();

  // user
  Stream<List<UserEntity>> getUsers(UserEntity user);
  Stream<List<UserEntity>> getSingleUser(String uid);
  Future<String> getCurrentUid();
  Future<void> createUser(UserEntity user);
  Future<void> updateUser(UserEntity user);

  // Cloud storage
  Future<String> uploadImageToStorage(
    File? file,
    bool isPost,
    String childName,
  );
}
