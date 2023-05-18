import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:insta_clone/common/firebase_consts.dart';
import 'package:insta_clone/feature/data/models/models.dart';
import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:uuid/uuid.dart';

import 'remote_data_source.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  FirebaseRemoteDataSourceImpl({
    required this.firebaseStorage,
    required this.firestore,
    required this.firebaseAuth,
  });

  // USER
  Future<void> createUserWithImage(UserEntity user, String profileUrl) async {
    final userCollection = firestore.collection(FirebaseConsts.users);

    final uid = await getCurrentUid();

    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        uid: uid,
        name: user.name,
        email: user.email,
        bio: user.bio,
        following: user.following,
        website: user.website,
        profileUrl: profileUrl,
        username: user.username,
        totalFollowers: user.totalFollowers,
        followers: user.followers,
        totalFollowing: user.totalFollowing,
        totalPosts: user.totalPosts,
      ).toJson();

      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((error) {
      toast("Some error occur");
    });
  }

  @override
  Future<void> createUser(UserEntity user) async {
    final userCollection = firestore.collection(FirebaseConsts.users);
    final uid = await getCurrentUid();

    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        uid: uid,
        bio: user.bio,
        email: user.email,
        followers: user.followers,
        following: user.following,
        name: user.name,
        profileUrl: user.profileUrl,
        totalFollowers: user.totalFollowers,
        totalFollowing: user.totalFollowing,
        totalPosts: user.totalPosts,
        username: user.username,
        website: user.website,
      ).toJson();

      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((onError) {
      toast(onError.toString());
    });
  }

  @override
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final userCollection = firestore
        .collection(FirebaseConsts.users)
        .where("uid", isEqualTo: uid)
        .limit(1);

    return userCollection.snapshots().map(
          (querySnapshot) =>
              querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList(),
        );
  }

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) {
    final userCollection = firestore.collection(FirebaseConsts.users);

    return userCollection.snapshots().map(
          (querySnapshot) =>
              querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList(),
        );
  }

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity user) async {
    try {
      if (user.email!.isNotEmpty || user.password!.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: user.email!, password: user.password!);
      } else {
        print("Field can't be empty");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toast("User not found");
      } else if (e.code == 'wrong-password') {
        toast("Ivalid email or password");
      }
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> signUp(UserEntity user) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!)
          .then((currentUser) async {
        if (currentUser.user?.uid != null) {
          if (user.imageFile != null) {
            await uploadImageToStorage(user.imageFile, false, "profileImages")
                .then((profileUrl) {
              createUserWithImage(user, profileUrl);
            });
          } else {
            createUserWithImage(user, "");
          }
        }
      });
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        toast("email is already taken");
      } else {
        toast("something went wrong");
      }
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final userCollection = firestore.collection(FirebaseConsts.users);
    Map<String, dynamic> userInformation = {};

    if (user.bio != '' && user.bio != null) {
      userInformation['bio'] = user.bio;
    }

    if (user.name != '' && user.name != null) {
      userInformation['name'] = user.name;
    }

    if (user.profileUrl != '' && user.profileUrl != null) {
      userInformation['profileUrl'] = user.profileUrl;
    }

    if (user.totalFollowers != null) {
      userInformation['totalFollowers'] = user.totalFollowers;
    }

    if (user.totalFollowing != null) {
      userInformation['totalFollowing'] = user.totalFollowing;
    }

    if (user.totalPosts != null) {
      userInformation['totalPosts'] = user.totalPosts;
    }

    if (user.website != '' && user.website != null) {
      userInformation['website'] = user.website;
    }

    userCollection.doc(user.uid).update(userInformation);
  }

  @override
  Future<String> uploadImageToStorage(
    File? file,
    bool isPost,
    String childName,
  ) async {
    Reference ref = firebaseStorage
        .ref()
        .child(childName)
        .child(firebaseAuth.currentUser!.uid);

    if (isPost) {
      String id = Uuid().v1();
      ref = ref.child(id);
    }

    final uploadTask = await ref.putFile(file!);

    return await uploadTask.ref.getDownloadURL();
  }

  // POST
  @override
  Future<void> createPost(PostEntity post) async {
    final postCollection = firestore.collection(FirebaseConsts.posts);

    final newPost = PostModel(
      username: post.username,
      createAt: post.createAt,
      creatorUid: post.creatorUid,
      description: post.description,
      likes: [],
      postId: post.postId,
      postImageUrl: post.postImageUrl,
      totalComments: 0,
      totalLikes: 0,
      userProfileUrl: post.userProfileUrl,
    ).toJson();

    try {
      final postDocRef = await postCollection.doc(post.postId).get();

      if (!postDocRef.exists) {
        postCollection.doc(post.postId).set(newPost);
      } else {
        postCollection.doc(post.postId).update(newPost);
      }
    } catch (e) {
      print("some error: $e");
    }
  }

  @override
  Future<void> deletePost(PostEntity post) async {
    final postCollection = firestore.collection(FirebaseConsts.posts);

    try {
      await postCollection.doc(post.postId).delete();
    } catch (e) {
      print("some error: $e");
    }
  }

  @override
  Future<void> likePost(PostEntity post) async {
    final postCollection = firestore.collection(FirebaseConsts.posts);
    final currentUid = await getCurrentUid();
    final postRef = await postCollection.doc(post.postId).get();

    if (postRef.exists) {
      List likes = postRef.get('likes');
      final totalLikes = postRef.get('totalLikes');

      if (likes.contains(currentUid)) {
        postCollection.doc(post.postId).update({
          "likes": FieldValue.arrayRemove([currentUid]),
          "totalLikes": totalLikes - 1,
        });
      } else {
        postCollection.doc(post.postId).update({
          "likes": FieldValue.arrayUnion([currentUid]),
          "totalLikes": totalLikes + 1,
        });
      }
    }
  }

  @override
  Stream<List<PostEntity>> readPosts(PostEntity post) {
    final postCollection = firestore.collection(FirebaseConsts.posts).orderBy(
          "createAt",
          descending: true,
        );

    return postCollection.snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map(
                (e) => PostModel.fromSnapshot(e),
              )
              .toList(),
        );
  }

  @override
  Future<void> updatePost(PostEntity post) async {
    final postCollection = firestore.collection(FirebaseConsts.posts);

    Map<String, dynamic> postInfo = {};

    if (post.description != null && post.description != '') {
      postInfo['description'] = post.description;
    }
    if (post.postImageUrl != null && post.postImageUrl != '') {
      postInfo['postImageUrl'] = post.postImageUrl;
    }

    postCollection.doc(post.postId).update(postInfo);
  }

  // COMMENTS
  @override
  Future<void> createComment(CommentEntity comment) {
    // TODO: implement createComment
    throw UnimplementedError();
  }

  @override
  Future<void> deleteComment(CommentEntity comment) {
    // TODO: implement deleteComment
    throw UnimplementedError();
  }

  @override
  Future<void> likeComment(CommentEntity comment) {
    // TODO: implement likeComment
    throw UnimplementedError();
  }

  @override
  Stream<List<CommentEntity>> readComments(String postId) {
    // TODO: implement readComments
    throw UnimplementedError();
  }

  @override
  Future<void> updateComment(CommentEntity comment) {
    // TODO: implement updateComment
    throw UnimplementedError();
  }

  // REPLIES
  @override
  Future<void> createReplay(ReplayEntity replay) {
    // TODO: implement createReplay
    throw UnimplementedError();
  }

  @override
  Future<void> deleteReplay(ReplayEntity replay) {
    // TODO: implement deleteReplay
    throw UnimplementedError();
  }

  @override
  Future<void> likeReplay(ReplayEntity replay) {
    // TODO: implement likeReplay
    throw UnimplementedError();
  }

  @override
  Stream<List<ReplayEntity>> readReplays(ReplayEntity replay) {
    // TODO: implement readReplays
    throw UnimplementedError();
  }

  @override
  Future<void> updateReplay(ReplayEntity replay) {
    // TODO: implement updateReplay
    throw UnimplementedError();
  }
}
