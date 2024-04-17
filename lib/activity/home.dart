import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_blue/flutter_blue.dart';


class _Slider extends State<Home> {
  double _value = 50;

  void setValue(double value) {
    _value = value;
  }

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      appearance: const CircularSliderAppearance(
        size: 300,
      ),
      min: 10,
      max: 100,
      initialValue: 50,
      onChange: (double value) {
        setValue(value);
      },
      innerWidget: (double value) {
        return Column(
          children: [
            const Padding(padding: EdgeInsets.all(40)),
            Text(
              value.toInt().toString(),
              style: const TextStyle(color: Colors.black, fontSize: 80),
            )
          ],
        );
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _Slider slider = _Slider();

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
          title: const Text('Наливатор', style: TextStyle(fontSize: 30)),
          backgroundColor: Colors.green[400],
        ),
        body: Column(
          children: [
            const Padding(padding: EdgeInsets.all(60)),
            Center(
              child: slider.build(context)
              ),
            ElevatedButton(
                 onPressed: () {
                  discoverServices();
                  _sendMessage('V${slider._value.toInt()}\n');
                  log(slider._value.toString());
                 },
                child: const Text(
                  'Налить',
                  style: TextStyle(fontSize: 80),
                ))
          ],
        ));
  }
}
