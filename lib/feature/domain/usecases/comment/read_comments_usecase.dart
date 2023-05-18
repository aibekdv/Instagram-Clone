import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class ReadCommentsUseCase {
  final FirebaseRepository repository;

  ReadCommentsUseCase({required this.repository});

  Stream<List<CommentEntity>> call(String postId) {
    return repository.readComments(postId);
  }
}
