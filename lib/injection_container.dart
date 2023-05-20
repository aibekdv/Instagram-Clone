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
  // AUTH CUBIT
  sl.registerFactory(() => AuthCubit(
        isSignInUseCase: sl(),
        signOutUseCase: sl(),
        getCurrentUidUseCase: sl(),
      ));

  // USER CUBIT
  sl.registerFactory(() => UserCubit(
        getUsersUseCase: sl(),
        updateUserUseCase: sl(),
      ));

  // CREDENTIAL CUBIT
  sl.registerFactory(() => CredentialCubit(
        signInUseCase: sl(),
        signUpUseCase: sl(),
      ));

  // GET_SINGLE_USER CUBIT
  sl.registerFactory(() => GetSingleUserCubit(getSingleUserUseCase: sl()));

  // POST CUBIT
  sl.registerFactory(() => PostCubit(
        createPostUseCase: sl(),
        deletePostUseCase: sl(),
        updatePostUseCase: sl(),
        readPostsUseCase: sl(),
        likePostUseCase: sl(),
      ));

  // USER USECASES
  sl.registerLazySingleton(() => SignInUseCase(repository: sl()));
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl()));
  sl.registerLazySingleton(() => SignOutUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentUidUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => IsSignInUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUsersUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl()));

  // CLOUD STORAGE USECASE
  sl.registerLazySingleton(() => UploadImageToStorageUsecase(repository: sl()));

  // POST USECASES
  sl.registerLazySingleton(() => CreatePostUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(repository: sl()));
  sl.registerLazySingleton(() => LikePostUseCase(repository: sl()));
  sl.registerLazySingleton(() => ReadPostsUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repository: sl()));

  // COMMENT USECASES
  sl.registerLazySingleton(() => CreateCommentUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteCommentUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateCommentUseCase(repository: sl()));
  sl.registerLazySingleton(() => LikeCommentUseCase(repository: sl()));
  sl.registerLazySingleton(() => ReadCommentsUseCase(repository: sl()));

  // REPLY USECASES
  sl.registerLazySingleton(() => CreateReplayUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteReplayUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateReplayUseCase(repository: sl()));
  sl.registerLazySingleton(() => LikeReplayUseCase(repository: sl()));
  sl.registerLazySingleton(() => ReadReplaysUseCase(repository: sl()));

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
