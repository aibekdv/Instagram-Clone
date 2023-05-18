import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class ReadReplaysUseCase {
  final FirebaseRepository repository;

  ReadReplaysUseCase({required this.repository});

  Stream<List<ReplayEntity>> call(ReplayEntity replay) {
    return repository.readReplays(replay);
  }
}
