import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iot_remote/common/const.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class TemperaturePage extends StatefulWidget {
  TemperaturePage({super.key});

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  final MqttClient client =
      MqttServerClient(Constants.brokerAddress, 'client_id');
  int temperature = 0;
  int humidity = 0;
  bool _isConnected = false;

  @override
  void initState() {
    _connectToBroker();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // _disconnectFromBroker();
  }

  void _connectToBroker() async {
    setState(() {
      _isConnected = false;
    });

    try {
      await client.connect();
      setState(() {
        _isConnected = true;
      });

      client.subscribe(Constants.topicTempHum, MqttQos.atLeastOnce);

      client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
        final response =
            MqttPublishPayload.bytesToStringAsString(message.payload.message);
        final jsonData = jsonDecode(response) as Map<String, dynamic>;
        log(jsonData.toString());
        final temperature = jsonData['temp'] as int;
        final humidity = jsonData['hum'] as int;

        setState(() {
          this.temperature = temperature;
          this.humidity = humidity;
        });
      });
    } catch (e) {
      print('Error connecting to broker: ${e.toString()}');
    }
  }

  void _disconnectFromBroker() async {
    if (_isConnected) {
      client.unsubscribe(Constants.topicTempHum);
      client.onDisconnected = () {
        setState(() {
          _isConnected = false;
        });
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 170,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Temperature",
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      "$temperature °C",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 170,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Humidity",
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      "$humidity %",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
