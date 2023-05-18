import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class UpdateReplayUseCase {
  final FirebaseRepository repository;

  UpdateReplayUseCase({required this.repository});

  Future<void> call(ReplayEntity comment) {
    return repository.updateReplay(comment);
  }
}
