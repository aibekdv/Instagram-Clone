import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class ReadPostsUseCase {
  final FirebaseRepository repository;

  ReadPostsUseCase({required this.repository});

  Stream<List<PostEntity>> call(PostEntity post) {
    return repository.readPosts(post);
  }
}
