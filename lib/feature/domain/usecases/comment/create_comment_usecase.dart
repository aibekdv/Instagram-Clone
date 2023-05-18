import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class CreateCommentUseCase {
  final FirebaseRepository repository;

  CreateCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.createComment(comment);
  }
}
