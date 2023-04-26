import 'package:insta_clone/feature/domain/entities/user/user_entity.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class UpdateUserUseCase {
  final FirebaseRepository repository;

  UpdateUserUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.updateUser(user);
  }
}
