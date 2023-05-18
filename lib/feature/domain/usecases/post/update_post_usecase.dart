import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class UpdatePostUseCase {
  final FirebaseRepository repository;

  UpdatePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.updatePost(post);
  }
}
