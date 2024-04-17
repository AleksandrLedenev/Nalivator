import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nalivator_applicatioin2/main.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Options extends StatefulWidget {

  const Options({super.key});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {

  late BluetoothDevice device;

  late BluetoothCharacteristic? _writeCharacteristic;

  Future<void> _getConnectedDevices() async {
    List<BluetoothDevice> devices = await FlutterBlue.instance.connectedDevices;
    setState(() {
      for (var d in devices) {
        if (d.name == 'HMSoft') {
          device = d;
        }
      }
    });
  }

  void discoverServices() async {
    _getConnectedDevices();
    List<BluetoothService> services = await device.discoverServices();
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.properties.write) {
          _writeCharacteristic = characteristic;
        }
      }
    }
  }

  void _sendMessage(String message) async {
    if (_writeCharacteristic != null) {
      List<int> bytes = utf8.encode(message);
      await _writeCharacteristic?.write(bytes);
    }
  }
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Настройки', style: TextStyle(fontSize: 30)),
          backgroundColor: Colors.green[400],
        ),
        body: ListView(
          children: [
            const Padding(padding: EdgeInsets.only(top: 50)),
            ListTile(
                leading: const Icon(Icons.auto_mode),
                title: const Text(
                  'Автоматический режим',
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
                trailing: Switch(
                  onChanged: (bool? value) {
                    setState(() {
                      autoMode = value!;
                    });
                    discoverServices();
                    int param;
                    if (autoMode) {
                      param = 1;
                    } 
                    else {
                      param = 0;
                    }
                    _sendMessage('A$param\n');
                  },
                  value: autoMode,
                )),
            ListTile(
                leading: const Icon(Icons.loop),
                title: const Text(
                  'Левый режим',
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
                trailing: Switch(
                  onChanged: (bool? value) {
                    setState(() {
                      leftMode = value!;
                    });
                    discoverServices();
                    int param;
                    if (leftMode) {
                      param = 1;
                    } 
                    else {
                      param = 0;
                    }
                    _sendMessage('L$param\n');
                  },
                  value: leftMode,
                )),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.help),
              title: const Text(
                'Помощь',
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
            ),
          ],
        ));
  }
}
