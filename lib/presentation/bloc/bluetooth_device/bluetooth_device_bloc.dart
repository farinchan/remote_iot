import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:meta/meta.dart';

part 'bluetooth_device_event.dart';
part 'bluetooth_device_state.dart';

class BluetoothDeviceBloc
    extends Bloc<BluetoothDeviceEvent, BluetoothDeviceState> {
  BluetoothState bluetoothState = BluetoothState.UNKNOWN;

  List<BluetoothDevice> savedDevices = <BluetoothDevice>[];

  List<BluetoothDiscoveryResult> availabledevices =
      List<BluetoothDiscoveryResult>.empty(growable: true);

  BluetoothDeviceBloc() : super(BluetoothDeviceInitial()) {
    on<SwitchBluetooth>((event, emit) async {
      if (event.value) {
        var switchBluetooth =
            await FlutterBluetoothSerial.instance.requestEnable();
        if (switchBluetooth != null && switchBluetooth) {
          add(InitBluetooth());
        }
      } else {
        var switchBluetooth =
            await FlutterBluetoothSerial.instance.requestDisable();
        if (switchBluetooth != null && switchBluetooth) {
          log("Bluetooth Disabled: $switchBluetooth");
          savedDevices.clear();
          FlutterBluetoothSerial.instance.cancelDiscovery();
          availabledevices.clear();
          emit(BluetoothDeviceDisabled());
        }
      }
      var status = await FlutterBluetoothSerial.instance.state;
      bluetoothState = status;
      log("Bluetooth State: $bluetoothState");
    });

    on<StateBluetooth>((event, emit) async {
      bluetoothState = event.state;
      if (bluetoothState.isEnabled) {
        add(InitBluetooth());
      } else {
        savedDevices.clear();
        availabledevices.clear();
        emit(BluetoothDeviceDisabled());
      }
    });

    on<DiscoverBluetooth>((event, emit) async {
      availabledevices.clear();
      add(InitBluetooth());
    });

    on<InitBluetooth>((event, emit) async {
      var status = await FlutterBluetoothSerial.instance.state;
      bluetoothState = status;
      if (bluetoothState.isEnabled) {
        var bounded = await FlutterBluetoothSerial.instance.getBondedDevices();
        savedDevices = bounded;
        var discovery = FlutterBluetoothSerial.instance.startDiscovery();
        discovery.listen((event) {
          availabledevices.add(event);
          emit(BluetoothDeviceDataReceived(
              bluetoothState, savedDevices, availabledevices));
        });
        emit(BluetoothDeviceDataReceived(
            bluetoothState, savedDevices, availabledevices));
      } else {
        savedDevices.clear();
        availabledevices.clear();
        emit(BluetoothDeviceDisabled());
      }
    });
  }
}
