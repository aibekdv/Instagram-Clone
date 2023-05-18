import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class UpdateCommentUseCase {
  final FirebaseRepository repository;

  UpdateCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.updateComment(comment);
  }
}
