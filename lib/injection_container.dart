import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:insta_clone/feature/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:insta_clone/feature/data/data_sources/remote_data_source/remote_data_source_impl.dart';
import 'package:insta_clone/feature/data/repositories/firebase_repository_impl.dart';
import 'package:insta_clone/feature/domain/repositories/firebase_repository.dart';
import 'package:insta_clone/feature/domain/usecases/user/user.dart';
import 'package:insta_clone/feature/presentation/cubit/cubit.dart';
import 'package:insta_clone/feature/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(
    () => AuthCubit(
      isSignInUseCase: sl.call(),
      signOutUseCase: sl.call(),
      getCurrentUidUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => UserCubit(
      getUsersUseCase: sl.call(),
      updateUserUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => CredentialCubit(
      signInUseCase: sl.call(),
      signUpUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => GetSingleUserCubit(getSingleUserUseCase: sl.call()),
  );

  // Usecases
  sl.registerLazySingleton(() => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => CreateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl.call()));

  // Repository
  sl.registerLazySingleton<FirebaseRepository>(
    () => FirebaseRepositoryImpl(remoteDataSource: sl.call()),
  );

  //  Remote Data Source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
    () => FirebaseRemoteDataSourceImpl(
      firestore: sl.call(),
      firebaseAuth: sl.call(),
    ),
  );

  // Externals
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseFirestore);
}
