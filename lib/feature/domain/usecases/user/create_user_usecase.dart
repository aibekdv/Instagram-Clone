import 'package:insta_clone/feature/domain/entities/user/user_entity.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class CreateUserUseCase {
  final FirebaseRepository repository;

  CreateUserUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.createUser(user);
  }
}
