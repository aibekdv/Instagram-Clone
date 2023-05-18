import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class DeleteReplayUseCase {
  final FirebaseRepository repository;

  DeleteReplayUseCase({required this.repository});

  Future<void> call(ReplayEntity comment) {
    return repository.deleteReplay(comment);
  }
}
