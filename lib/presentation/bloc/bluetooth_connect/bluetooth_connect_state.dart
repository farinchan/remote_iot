part of 'bluetooth_connect_bloc.dart';

@immutable
sealed class BluetoothConnectState {}

final class BluetoothConnectInitial extends BluetoothConnectState {}

final class BluetoothConnectConnected extends BluetoothConnectState {
  final BluetoothDevice device;
  final BluetoothConnection connection;

  BluetoothConnectConnected(this.device, this.connection);
}

final class BluetoothConnectDisconnected extends BluetoothConnectState {
  final String message;

  BluetoothConnectDisconnected({this.message = "Disconnected"});
}
