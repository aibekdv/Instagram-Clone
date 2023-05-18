import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class LikeCommentUseCase {
  final FirebaseRepository repository;

  LikeCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.likeComment(comment);
  }
}
