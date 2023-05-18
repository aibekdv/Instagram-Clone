import 'dart:io';

import 'package:insta_clone/feature/domain/entities/entities.dart';

abstract class FirebaseRemoteDataSource {
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

  // Post
  Future<void> createPost(PostEntity post);
  Stream<List<PostEntity>> readPosts(PostEntity post);
  Future<void> updatePost(PostEntity post);
  Future<void> deletePost(PostEntity post);
  Future<void> likePost(PostEntity post);

  // COMMENT
  Future<void> createComment(CommentEntity comment);
  Stream<List<CommentEntity>> readComments(String postId);
  Future<void> updateComment(CommentEntity comment);
  Future<void> deleteComment(CommentEntity comment);
  Future<void> likeComment(CommentEntity comment);

  // REPLY
  Future<void> createReplay(ReplayEntity replay);
  Stream<List<ReplayEntity>> readReplays(ReplayEntity replay);
  Future<void> updateReplay(ReplayEntity replay);
  Future<void> deleteReplay(ReplayEntity replay);
  Future<void> likeReplay(ReplayEntity replay);
}
