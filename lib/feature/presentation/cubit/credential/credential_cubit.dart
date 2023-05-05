import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insta_clone/feature/domain/entities/user/user_entity.dart';
import 'package:insta_clone/feature/domain/usecases/user/sign_in_usecase.dart';
import 'package:insta_clone/feature/domain/usecases/user/sign_up_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  CredentialCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
  }) : super(CredentialInitial());

  Future<void> signInUser({
    required String email,
    required String password,
  }) async {
    emit(CredentialLoading());
    try {
      await signInUseCase(UserEntity(email: email, password: password));
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signUpUser({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      await signUpUseCase(user);
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}
