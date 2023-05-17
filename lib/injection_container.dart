import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:insta_clone/feature/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:insta_clone/feature/data/data_sources/remote_data_source/remote_data_source_impl.dart';
import 'package:insta_clone/feature/data/repositories/firebase_repository_impl.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';
import 'package:insta_clone/feature/domain/usecases/usecases.dart';
import 'package:insta_clone/feature/presentation/cubit/cubit.dart';
import 'package:insta_clone/feature/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(
    () => AuthCubit(
      isSignInUseCase: sl(),
      signOutUseCase: sl(),
      getCurrentUidUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => UserCubit(
      getUsersUseCase: sl(),
      updateUserUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => CredentialCubit(
      signInUseCase: sl(),
      signUpUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => GetSingleUserCubit(getSingleUserUseCase: sl()),
  );

  // Usecases
  sl.registerLazySingleton(() => SignInUseCase(repository: sl()));
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl()));
  sl.registerLazySingleton(() => SignOutUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentUidUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => IsSignInUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUsersUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => UploadImageToStorageUsecase(repository: sl()));

  // Repository
  sl.registerLazySingleton<FirebaseRepository>(
    () => FirebaseRepositoryImpl(remoteDataSource: sl()),
  );

  //  Remote Data Source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
    () => FirebaseRemoteDataSourceImpl(
      firestore: sl(),
      firebaseAuth: sl(),
      firebaseStorage: sl(),
    ),
  );

  // Externals
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseStorage);
}
