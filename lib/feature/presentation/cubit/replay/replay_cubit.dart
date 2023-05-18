import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'replay_state.dart';

class ReplayCubit extends Cubit<ReplayState> {
  ReplayCubit() : super(ReplayInitial());
}
