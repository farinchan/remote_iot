import 'package:iot_remote/common/const.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttDataSource {
  void connect() {
    final MqttClient client =
        MqttServerClient(Constants.brokerAddress, 'client_id');

    client.connect();
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      print('Successfully connected to the MQTT broker');
    } else {
      print('Failed to connect to the MQTT broker');
    }
    client.onConnected = () {
      print('Connected to broker');
    };
    client.onDisconnected = () {
      print('Disconnected from broker');
    };
  }
}
