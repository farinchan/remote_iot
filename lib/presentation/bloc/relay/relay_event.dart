part of 'relay_bloc.dart';

@immutable
sealed class RelayEvent {}

final class RelayStarted extends RelayEvent {}

class RelaySwitching1 extends RelayEvent {
  final bool value;

  RelaySwitching1(this.value);
}

class RelaySwitching2 extends RelayEvent {
  final bool value;

  RelaySwitching2(this.value);
}

class RelaySwitching3 extends RelayEvent {
  final bool value;

  RelaySwitching3(this.value);
}

class RelaySwitching4 extends RelayEvent {
  final bool value;

  RelaySwitching4(this.value);
}

class RelaySwitching5 extends RelayEvent {
  final bool value;

  RelaySwitching5(this.value);
}

class RelaySwitching6 extends RelayEvent {
  final bool value;

  RelaySwitching6(this.value);
}
