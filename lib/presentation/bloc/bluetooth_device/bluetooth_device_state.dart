part of 'bluetooth_device_bloc.dart';

@immutable
sealed class BluetoothDeviceState {}

final class BluetoothDeviceInitial extends BluetoothDeviceState {}

final class BluetoothDeviceDisabled extends BluetoothDeviceState {}

final class BluetoothDeviceDataReceived extends BluetoothDeviceState {
  final BluetoothState bluetoothState;
  final List<BluetoothDevice>? savedDevices;
  final List<BluetoothDiscoveryResult>? availabledevices;

  BluetoothDeviceDataReceived(
      this.bluetoothState, this.savedDevices, this.availabledevices);
}
