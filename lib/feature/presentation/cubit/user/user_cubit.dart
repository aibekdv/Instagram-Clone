import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insta_clone/feature/domain/entities/user/user_entity.dart';
import 'package:insta_clone/feature/domain/usecases/user/get_users_usecase.dart';
import 'package:insta_clone/feature/domain/usecases/user/update_user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUsersUseCase getUsersUseCase;
  final UpdateUserUseCase updateUserUseCase;

  UserCubit({
    required this.getUsersUseCase,
    required this.updateUserUseCase,
  }) : super(UserInitial());

  Future<void> getUsers({required UserEntity user}) async {
    emit(UserLoading());
    try {
      final streamResponse = getUsersUseCase(user);
      streamResponse.listen(
        (users) {
          emit(UserLoaded(users: users));
        },
      );
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> updateUser({required UserEntity user}) async {
    try {
      await updateUserUseCase(user);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
