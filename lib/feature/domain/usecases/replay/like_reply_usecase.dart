import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class LikeReplayUseCase {
  final FirebaseRepository repository;

  LikeReplayUseCase({required this.repository});

  Future<void> call(ReplayEntity comment) {
    return repository.likeReplay(comment);
  }
}
