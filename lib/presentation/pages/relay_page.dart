import 'package:flutter/material.dart';
import 'package:iot_remote/common/const.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class RelayPage extends StatefulWidget {
  const RelayPage({super.key});

  @override
  State<RelayPage> createState() => _RelayPageState();
}

class _RelayPageState extends State<RelayPage> {
  bool relay1 = false;
  bool relay2 = false;
  bool relay3 = false;
  bool relay4 = false;
  bool relay5 = false;
  bool relay6 = false;
  final MqttClient client =
      MqttServerClient(Constants.brokerAddress, 'client_id');
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _connectToBroker();
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
      body: ListView(
        children: [
          SettingTile(
            title: 'Switch 1',
            subtitle: 'mengontrol lampu ruang tamu',
            trailing: Switch(
              value: relay1,
              onChanged: (value) {
                final builder = MqttClientPayloadBuilder();
                if (relay1) {
                  builder.addString('Relay 1 : OFF');
                } else {
                  builder.addString('Relay 1 : ON');
                }
                client.publishMessage(Constants.topicRelay, MqttQos.atLeastOnce,
                    builder.payload!);
                setState(() {
                  relay1 = value;
                });
              },
            ),
          ),
          SettingTile(
            title: 'Switch 2',
            subtitle: 'mengontrol lampu kamar tidur',
            trailing: Switch(
              value: relay2,
              onChanged: (value) {
                final builder = MqttClientPayloadBuilder();
                if (relay2) {
                  builder.addString('Relay 2 : OFF');
                } else {
                  builder.addString('Relay 2 : ON');
                }
                client.publishMessage(Constants.topicRelay, MqttQos.atLeastOnce,
                    builder.payload!);

                setState(() {
                  relay2 = value;
                });
              },
            ),
          ),
          SettingTile(
            title: 'Switch 3',
            subtitle: 'mengoontrol lampu kamar mandi',
            trailing: Switch(
              value: relay3,
              onChanged: (value) {
                final builder = MqttClientPayloadBuilder();
                if (relay3) {
                  builder.addString('Relay 3 : OFF');
                } else {
                  builder.addString('Relay 3 : ON');
                }
                client.publishMessage(Constants.topicRelay, MqttQos.atLeastOnce,
                    builder.payload!);

                setState(() {
                  relay3 = value;
                });
              },
            ),
          ),
          SettingTile(
            title: 'Switch 4',
            subtitle: 'mengoontrol lampu dapur',
            trailing: Switch(
              value: relay4,
              onChanged: (value) {
                final builder = MqttClientPayloadBuilder();
                if (relay4) {
                  builder.addString('Relay 4 : OFF');
                } else {
                  builder.addString('Relay 4 : ON');
                }
                client.publishMessage(Constants.topicRelay, MqttQos.atLeastOnce,
                    builder.payload!);

                setState(() {
                  relay4 = value;
                });
              },
            ),
          ),
          SettingTile(
            title: 'Switch 5',
            subtitle: 'mengoontrol lampu garasi',
            trailing: Switch(
              value: relay5,
              onChanged: (value) {
                final builder = MqttClientPayloadBuilder();
                if (relay5) {
                  builder.addString('Relay 5 : OFF');
                } else {
                  builder.addString('Relay 5 : ON');
                }
                client.publishMessage(Constants.topicRelay, MqttQos.atLeastOnce,
                    builder.payload!);
                setState(() {
                  relay5 = value;
                });
              },
            ),
          ),
          SettingTile(
            title: 'Switch 6',
            subtitle: "mengoontrol lampu teras",
            trailing: Switch(
              value: relay6,
              onChanged: (value) {
                final builder = MqttClientPayloadBuilder();
                if (relay6) {
                  builder.addString('Relay 6 : OFF');
                } else {
                  builder.addString('Relay 6 : ON');
                }
                client.publishMessage(Constants.topicRelay, MqttQos.atLeastOnce,
                    builder.payload!);
                setState(() {
                  relay6 = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const SettingTile({
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
    );
  }
}
