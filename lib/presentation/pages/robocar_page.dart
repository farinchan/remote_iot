import 'package:flutter/material.dart';
import 'package:iot_remote/presentation/bloc/bluetooth_connect/bluetooth_connect_bloc.dart';
import 'package:iot_remote/presentation/bloc/bluetooth_device/bluetooth_device_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:iot_remote/presentation/bloc/voice_recognition/voice_recognition_bloc.dart';

class RobocarPage extends StatelessWidget {
  const RobocarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: BlocConsumer<BluetoothConnectBloc, BluetoothConnectState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Card(
                  //         shadowColor: Colors.blue,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(20),
                  //         ),
                  //         child: Container(
                  //           alignment: Alignment.center,
                  //           height: 80,
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(5.0),
                  //             child: Image.asset("assets/images/orbit.png"),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          shadowColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                              height: 50,
                              child: TextButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.bluetooth),
                                  label: Text(
                                    state is BluetoothConnectConnected
                                        ? state.device.name ?? "Uknown"
                                        : "Not Connected",
                                  ))),
                        ),
                      ),
                      Card(
                        shadowColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          height: 50,
                          width: 50,
                          child: const Icon(Icons.bluetooth_connected),
                        ),
                      ),
                    ],
                  ),
                  state is BluetoothConnectConnected
                      ? Column(
                          children: [
                            Card(
                              shadowColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                            onTapDown: (details) {
                                              context
                                                  .read<BluetoothConnectBloc>()
                                                  .add(SendData("L"));
                                            },
                                            onTapUp: (details) {
                                              context
                                                  .read<BluetoothConnectBloc>()
                                                  .add(SendData("S"));
                                            },
                                            child: Image.asset(
                                                "assets/icons/arrow_left.png",
                                                width: 70)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTapDown: (details) {
                                            context
                                                .read<BluetoothConnectBloc>()
                                                .add(SendData("F"));
                                          },
                                          onTapUp: (details) {
                                            context
                                                .read<BluetoothConnectBloc>()
                                                .add(SendData("S"));
                                          },
                                          child: Image.asset(
                                            "assets/icons/arrow_up.png",
                                            width: 70,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(12),
                                          child: InkWell(
                                            onTapDown: (details) {
                                              context
                                                  .read<BluetoothConnectBloc>()
                                                  .add(SendData("S"));
                                            },
                                            child: Image.asset(
                                              "assets/icons/stop.png",
                                              width: 70,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTapDown: (details) {
                                            context
                                                .read<BluetoothConnectBloc>()
                                                .add(SendData("B"));
                                          },
                                          onTapUp: (details) {
                                            context
                                                .read<BluetoothConnectBloc>()
                                                .add(SendData("S"));
                                          },
                                          child: Image.asset(
                                              "assets/icons/arrow_down.png",
                                              width: 70),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTapDown: (details) {
                                            context
                                                .read<BluetoothConnectBloc>()
                                                .add(SendData("R"));
                                          },
                                          onTapUp: (details) {
                                            context
                                                .read<BluetoothConnectBloc>()
                                                .add(SendData("S"));
                                          },
                                          child: Image.asset(
                                            "assets/icons/arrow_right.png",
                                            width: 70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            BlocConsumer<VoiceRecognitionBloc,
                                VoiceRecognitionState>(
                              listener: (context, state) {
                                // TODO: implement listener
                                if (state is VoiceRecognitionDataReceived) {
                                  if (state.text.toLowerCase() == "maju") {
                                    context
                                        .read<BluetoothConnectBloc>()
                                        .add(SendData("F"));
                                  } else if (state.text.toLowerCase() ==
                                      "mundur") {
                                    context
                                        .read<BluetoothConnectBloc>()
                                        .add(SendData("B"));
                                  } else if (state.text.toLowerCase() ==
                                      "belok kiri") {
                                    context
                                        .read<BluetoothConnectBloc>()
                                        .add(SendData("L"));
                                  } else if (state.text.toLowerCase() ==
                                      "belok kanan") {
                                    context
                                        .read<BluetoothConnectBloc>()
                                        .add(SendData("R"));
                                  } else if (state.text.toLowerCase() ==
                                      "berhenti") {
                                    context
                                        .read<BluetoothConnectBloc>()
                                        .add(SendData("S"));
                                  }
                                }
                              },
                              builder: (context, state) {
                                return Card(
                                  shadowColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 25),
                                    child: Column(
                                      children: [
                                        const Text(
                                            "Tekan dan Tahan lalu Ucapkan Perintah",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 12),
                                        GestureDetector(
                                          onTapDown: (details) async {
                                            context
                                                .read<VoiceRecognitionBloc>()
                                                .add(StartVoiceRecognition());
                                          },
                                          onTapUp: (details) {
                                            context
                                                .read<VoiceRecognitionBloc>()
                                                .add(StopVoiceRecognition());
                                          },
                                          child: AvatarGlow(
                                            glowColor: Colors.red,
                                            child: Material(
                                              // Replace this child with your own
                                              elevation: 8.0,
                                              shape: const CircleBorder(),
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundColor:
                                                    Colors.grey[100],
                                                child: Image.asset(
                                                    state
                                                            is VoiceRecognitionDataReceived
                                                        ? state.isListening ==
                                                                true
                                                            ? "assets/icons/mic.png"
                                                            : "assets/icons/mic_mute.png"
                                                        : "assets/icons/mic.png",
                                                    width: 50),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        state is VoiceRecognitionError
                                            ? Text(state.message,
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold))
                                            : Container(),
                                        const SizedBox(height: 3),
                                        Container(
                                          width: 250,
                                          padding: const EdgeInsets.all(6),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 2),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(12))),
                                          child: Text(
                                              state is VoiceRecognitionDataReceived
                                                  ? state.text
                                                  : "",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        )
                      : Container(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
