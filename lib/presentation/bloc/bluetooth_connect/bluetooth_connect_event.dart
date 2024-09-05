part of 'bluetooth_connect_bloc.dart';

@immutable
sealed class BluetoothConnectEvent {}

class ConnectingBluetooth extends BluetoothConnectEvent {
  final BuildContext context;
  final BluetoothDevice device;

  ConnectingBluetooth(this.context, this.device);
}

class DisconnectBluetooth extends BluetoothConnectEvent {}

class SendData extends BluetoothConnectEvent {
  final String data;

  SendData(this.data);
}
