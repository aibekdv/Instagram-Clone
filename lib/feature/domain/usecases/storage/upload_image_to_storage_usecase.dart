import 'dart:io';

import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';

class UploadImageToStorageUsecase {
  final FirebaseRepository repository;

  UploadImageToStorageUsecase({required this.repository});

  Future<String> call(File? file, bool isPost, String childName) {
    return repository.uploadImageToStorage(file, isPost, childName);
  }
}
