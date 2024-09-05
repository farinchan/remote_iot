import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:meta/meta.dart';

part 'bluetooth_connect_event.dart';
part 'bluetooth_connect_state.dart';

class BluetoothConnectBloc
    extends Bloc<BluetoothConnectEvent, BluetoothConnectState> {
  late BluetoothConnection connection;
  late BluetoothDevice device;

  BluetoothConnectBloc() : super(BluetoothConnectInitial()) {
    on<ConnectingBluetooth>((event, emit) async {
      try {
        var connection =
            await BluetoothConnection.toAddress(event.device.address);
        this.connection = connection;
        device = event.device;
        if (connection.isConnected) {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
            content: Text('Connected to ${event.device.name}'),
            backgroundColor: Colors.green,
          ));
          emit(BluetoothConnectConnected(device, connection));
          log("Connected to ${device.name}");
        }

        // connection.input?.listen((Uint8List data) {
        //   log('Data incoming: ${ascii.decode(data)}');
        //   connection.output.add(data); // Sending data

        //   if (ascii.decode(data).contains('!')) {
        //     connection.finish(); // Closing connection
        //     log('Disconnecting by local host');
        //     connection.dispose();
        //     emit(BluetoothConnectDisconnected(
        //         message: "Disconnecting by local host"));
        //   }
        // }).onDone(() {
        //   log('Disconnected by remote request');
        //   connection.dispose();
        //   emit(BluetoothConnectDisconnected(
        //       message: "Disconnected by remote request"));
        // });
      } catch (exception) {
        log('Cannot connect, exception occured');
        connection.dispose();
        emit(BluetoothConnectDisconnected(
            message: "Cannot connect, exception occured"));
      }
    });
    on<DisconnectBluetooth>((event, emit) async {
      connection.dispose();
      emit(BluetoothConnectDisconnected());
    });

    on<SendData>((event, emit) async {
      connection.output.allSent.then((value) {
        connection.output.add(utf8.encode(event.data));
      });
    });
  }
}
