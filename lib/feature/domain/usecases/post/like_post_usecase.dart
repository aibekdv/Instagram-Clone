import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class LikePostUseCase {
  final FirebaseRepository repository;

  LikePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.likePost(post);
  }
}
