part of 'replay_cubit.dart';

abstract class ReplayState extends Equatable {
  const ReplayState();

  @override
  List<Object> get props => [];
}

class ReplayInitial extends ReplayState {}
