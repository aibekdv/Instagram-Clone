import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class CreatePostUseCase {
  final FirebaseRepository repository;

  CreatePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.createPost(post);
  }
}
