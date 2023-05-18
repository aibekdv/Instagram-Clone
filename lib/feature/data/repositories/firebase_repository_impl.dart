import 'dart:io';

import 'package:insta_clone/feature/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createUser(UserEntity user) async =>
      remoteDataSource.createUser(user);

  @override
  Future<String> getCurrentUid() async => remoteDataSource.getCurrentUid();

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) =>
      remoteDataSource.getSingleUser(uid);

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) =>
      remoteDataSource.getUsers(user);

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signIn(UserEntity user) async => remoteDataSource.signIn(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) async => remoteDataSource.signUp(user);

  @override
  Future<void> updateUser(UserEntity user) async =>
      remoteDataSource.updateUser(user);

  // Cloud storage
  @override
  Future<String> uploadImageToStorage(
    File? file,
    bool isPost,
    String childName,
  ) async =>
      remoteDataSource.uploadImageToStorage(file, isPost, childName);

  // Post
  @override
  Future<void> createPost(PostEntity post) async =>
      await remoteDataSource.createPost(post);

  @override
  Future<void> deletePost(PostEntity post) async =>
      await remoteDataSource.deletePost(post);

  @override
  Future<void> likePost(PostEntity post) async =>
      await remoteDataSource.likePost(post);

  @override
  Stream<List<PostEntity>> readPosts(PostEntity post) =>
      remoteDataSource.readPosts(post);

  @override
  Future<void> updatePost(PostEntity post) async =>
      await remoteDataSource.updatePost(post);

  // COMMENTS
  @override
  Future<void> createComment(CommentEntity comment) async =>
      await remoteDataSource.createComment(comment);

  @override
  Future<void> deleteComment(CommentEntity comment) async =>
      await remoteDataSource.deleteComment(comment);

  @override
  Future<void> likeComment(CommentEntity comment) async =>
      await remoteDataSource.likeComment(comment);

  @override
  Stream<List<CommentEntity>> readComments(String postId) =>
      remoteDataSource.readComments(postId);

  @override
  Future<void> updateComment(CommentEntity comment) async =>
      await remoteDataSource.updateComment(comment);

  // REPLIES
  @override
  Future<void> createReplay(ReplayEntity replay) async =>
      await remoteDataSource.createReplay(replay);

  @override
  Future<void> deleteReplay(ReplayEntity replay) async =>
      await remoteDataSource.deleteReplay(replay);

  @override
  Future<void> likeReplay(ReplayEntity replay) async =>
      await remoteDataSource.likeReplay(replay);

  @override
  Stream<List<ReplayEntity>> readReplays(ReplayEntity replay) =>
      remoteDataSource.readReplays(replay);

  @override
  Future<void> updateReplay(ReplayEntity replay) async =>
      await remoteDataSource.updateReplay(replay);
}
