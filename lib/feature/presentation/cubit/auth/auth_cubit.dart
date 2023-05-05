import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/feature/domain/usecases/user/get_current_uid_usecase.dart';
import 'package:insta_clone/feature/domain/usecases/user/is_sign_in_usecase.dart';
import 'package:insta_clone/feature/domain/usecases/user/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;

  AuthCubit({
    required this.isSignInUseCase,
    required this.signOutUseCase,
    required this.getCurrentUidUseCase,
  }) : super(AuthInitial());

  Future<void> appStarted(BuildContext context) async {
    try {
      bool isSignIn = await isSignInUseCase();

      if (isSignIn) {
        final uid = await getCurrentUidUseCase();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUseCase();
      emit(Authenticated(uid: uid));
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUseCase();
      emit(UnAuthenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }
}
