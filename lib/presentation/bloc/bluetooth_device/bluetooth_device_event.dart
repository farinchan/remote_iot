part of 'bluetooth_device_bloc.dart';

@immutable
sealed class BluetoothDeviceEvent {}

class SwitchBluetooth extends BluetoothDeviceEvent {
  final bool value;

  SwitchBluetooth(this.value);
}

class InitBluetooth extends BluetoothDeviceEvent {}

class StateBluetooth extends BluetoothDeviceEvent {
  final BluetoothState state;

  StateBluetooth(this.state);
}

class DiscoverBluetooth extends BluetoothDeviceEvent {}

