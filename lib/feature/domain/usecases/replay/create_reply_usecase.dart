import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class CreateReplayUseCase {
  final FirebaseRepository repository;

  CreateReplayUseCase({required this.repository});

  Future<void> call(ReplayEntity comment) {
    return repository.createReplay(comment);
  }
}
