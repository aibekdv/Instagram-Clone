import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class DeletePostUseCase {
  final FirebaseRepository repository;

  DeletePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.deletePost(post);
  }
}
