part of 'relay_bloc.dart';

@immutable
sealed class RelayState {}

final class RelayInitial extends RelayState {}

final class RelayLoading extends RelayState {}


final class RelaySwitched1 extends RelayState {
  final bool valueSwitch;

  RelaySwitched1(this.valueSwitch );
}

