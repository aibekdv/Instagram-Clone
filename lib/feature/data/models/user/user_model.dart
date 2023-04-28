import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/feature/domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.uid,
    super.username,
    super.name,
    super.bio,
    super.website,
    super.email,
    super.profileUrl,
    super.followers,
    super.following,
    super.totalFollowing,
    super.totalFollowers,
    super.totalPosts,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      bio: snapshot['bio'],
      email: snapshot['email'],
      followers: List.from(snap.get('followers')),
      following: List.from(snap.get("following")),
      name: snapshot['name'],
      profileUrl: snapshot['profileUrl'],
      totalFollowers: snapshot['totalFollowers'],
      totalFollowing: snapshot['totalFollowing'],
      totalPosts: snapshot['totalPosts'],
      uid: snapshot['uid'],
      website: snapshot['website'],
      username: snapshot['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "bio": bio,
      "email": email,
      "followers": followers,
      "following": following,
      "name": name,
      "profileUrl": profileUrl,
      "totalFollowers": totalFollowers,
      "totalFollowing": totalFollowing,
      "totalPosts": totalPosts,
      "website": website,
      "username": username,
    };
  }
}
