import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:iot_remote/presentation/bloc/bluetooth_device/bluetooth_device_bloc.dart';
import 'package:iot_remote/presentation/widget/bluetooth_scan_widget.dart';

class BluetoohPage extends StatefulWidget {
  const BluetoohPage({super.key});

  @override
  State<BluetoohPage> createState() => _BluetoohPageState();
}

class _BluetoohPageState extends State<BluetoohPage> {
  @override
  void initState() {
    // TODO: implement initState
    stateChangeListener();
    context.read<BluetoothDeviceBloc>().add(InitBluetooth());
    super.initState();
  }

  void stateChangeListener() {
    log("State Change Listener: Start");
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      log("State Change Listener: $state");
      context.read<BluetoothDeviceBloc>().add(StateBluetooth(state));
      print("State isEnabled: ${state.isEnabled}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BluetoothDeviceBloc, BluetoothDeviceState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SwitchListTile(
                  title: const Text('Enable Bluetooth'),
                  value: state is BluetoothDeviceDataReceived
                      ? state.bluetoothState.isEnabled
                      : false,
                  onChanged: (bool value) async {
                    context
                        .read<BluetoothDeviceBloc>()
                        .add(SwitchBluetooth(value));
                  },
                ),
                ListTile(
                  title: const Text("Bluetooth STATUS"),
                  subtitle:
                      Text(state is BluetoothDeviceDataReceived ? "ON" : "OFF"),
                  trailing: ElevatedButton(
                    child: const Text("Settings"),
                    onPressed: () {
                      FlutterBluetoothSerial.instance.openSettings();
                    },
                  ),
                ),
                state is BluetoothDeviceDataReceived
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              "Perangkat Yang Tersimpan",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Wrap(
                            children: state.savedDevices!
                                .map((device) => BluetoothDeviceListEntry(
                                      device: device,
                                      enabled: true,
                                      onTap: () async {
                                        log("Item");
                                        try {
                                          BluetoothConnection connection =
                                              await BluetoothConnection
                                                  .toAddress(device.address);
                                          log('Connected to the device');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content:
                                                Text('Connected to the device'),
                                            backgroundColor: Colors.green,
                                          )); 

                                          connection.input
                                              ?.listen((Uint8List data) {
                                            log('Data incoming: ${ascii.decode(data)}');
                                            connection.output
                                                .add(data); // Sending data

                                            if (ascii
                                                .decode(data)
                                                .contains('!')) {
                                              connection
                                                  .finish(); // Closing connection
                                              log('Disconnecting by local host');
                                            }
                                          }).onDone(() {
                                            log('Disconnected by remote request');
                                          });
                                        } catch (exception) {
                                          log('Cannot connect, exception occured');
                                        }
                                      },
                                    ))
                                .toList(),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              children: [
                                const Text(
                                  "Perangkat Yang Tersedia",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.refresh))
                              ],
                            ),
                          ),
                          Wrap(
                            children: state.availabledevices!
                                .map((device) => BluetoothDeviceListEntry(
                                      device: device.device,
                                      enabled: true,
                                      onTap: () async {
                                        log("Item");
                                        try {
                                          BluetoothConnection connection =
                                              await BluetoothConnection
                                                  .toAddress(
                                                      device.device.address);
                                          log('Connected to the device');

                                          connection.input
                                              ?.listen((Uint8List data) {
                                            log('Data incoming: ${ascii.decode(data)}');
                                            connection.output
                                                .add(data); // Sending data

                                            if (ascii
                                                .decode(data)
                                                .contains('!')) {
                                              connection
                                                  .finish(); // Closing connection
                                              log('Disconnecting by local host');
                                            }
                                          }).onDone(() {
                                            log('Disconnected by remote request');
                                          });
                                        } catch (exception) {
                                          log('Cannot connect, exception occured');
                                        }
                                      },
                                    ))
                                .toList(),
                          )
                        ],
                      )
                    : state is BluetoothDeviceDisabled
                        ? const Center(child: Text("Bluetooth Disabled"))
                        : const Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        },
      ),
    );
  }
}
