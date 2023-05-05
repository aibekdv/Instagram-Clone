import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insta_clone/feature/domain/entities/user/user_entity.dart';
import 'package:insta_clone/feature/domain/usecases/user/user.dart';

part 'get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  final GetSingleUserUseCase getSingleUserUseCase;

  GetSingleUserCubit({required this.getSingleUserUseCase})
      : super(GetSingleUserInitial());

  Future<void> getSingleUser({required String uid}) async {
    emit(GetSingleUserLoding());
    try {
      final streamResponse = getSingleUserUseCase(uid);
      streamResponse.listen(
        (users) {
          emit(GetSingleUserLoaded(user: users.first));
        },
      );
    } on SocketException catch (_) {
      emit(GetSingleUserFailure());
    } catch (_) {
      emit(GetSingleUserFailure());
    }
  }
}
