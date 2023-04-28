import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? username;
  final String? name;
  final String? bio;
  final String? website;
  final String? email;
  final String? profileUrl;
  final List? followers;
  final List? following;
  final num? totalFollowing;
  final num? totalFollowers;
  final num? totalPosts;

// will not going to store in DB
  final String? otherUid;
  final String? password;

  const UserEntity({
    this.uid,
    this.username,
    this.name,
    this.bio,
    this.website,
    this.email,
    this.profileUrl,
    this.followers,
    this.following,
    this.totalFollowing,
    this.totalFollowers,
    this.otherUid,
    this.password,
    this.totalPosts,
  });

  @override
  List<Object?> get props => [
        uid,
        username,
        name,
        bio,
        website,
        email,
        profileUrl,
        followers,
        following,
        totalFollowing,
        totalFollowers,
        otherUid,
        password,
        totalPosts,
      ];
}
