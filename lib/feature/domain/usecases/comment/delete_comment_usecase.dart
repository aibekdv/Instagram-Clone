import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class DeleteCommentUseCase {
  final FirebaseRepository repository;

  DeleteCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.deleteComment(comment);
  }
}
