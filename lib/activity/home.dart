import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nalivator_applicatioin2/main.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_blue/flutter_blue.dart';


class GlassIndicator extends StatefulWidget{
  const GlassIndicator({super.key});

  @override
  State<GlassIndicator> createState() => _GlassIndicator();

}

class _GlassIndicator extends State<GlassIndicator> {
  Color _color = Colors.blue;  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (!autoMode){
            (_color == Colors.red) ? setColor(Colors.blue) : setColor(Colors.red);
          }
        });
      },
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
          backgroundColor: _color,
          side: const BorderSide(width: 1)),
      child: const Text('         '),
    );
  }

  void setColor(Color color) {
    _color = color;
  }
}


class _Slider extends State<Home> {

  double _value = 50;

  void setValue (double value){
    _value = value;
  }

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      appearance: const CircularSliderAppearance(
        size: 250,
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
              style: const TextStyle(color: Colors.black, fontSize: 60),
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
  
  List<Widget> indList = const [
   GlassIndicator(),
   GlassIndicator(),
   GlassIndicator(),
   GlassIndicator(),
   GlassIndicator()
  ];

  _Slider slider = _Slider();
  
  late BluetoothDevice device;

  late BluetoothCharacteristic _writeCharacteristic;

  Future<void> _getConnectedDevices() async {
    List<BluetoothDevice> devices = await FlutterBlue.instance.connectedDevices;
    setState(() {
      for (var d in devices) {
        print(d.name);
        if (d.name == 'HMSoft') {
          device = d;
        }
      }
    });
  }

  void discoverServices() async {
    _getConnectedDevices();
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      service.characteristics.forEach((characteristic) {
        if (characteristic.properties.write) {
          _writeCharacteristic = characteristic;
        }
      });
    });
  }

  void _sendMessage(String message) async {
    if (_writeCharacteristic != null) {
      List<int> bytes = utf8.encode(message);
      await _writeCharacteristic.write(bytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Наливатор'),
          backgroundColor: Colors.green[400],
        ),
        body: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 70)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: indList,
              ),             
            const Padding(padding: EdgeInsets.only(top: 100)),
            slider.build(context),
            ElevatedButton(
                 onPressed: () {
                  discoverServices();
                  _sendMessage('V${slider._value.toInt()}');
                  log(slider._value.toString());
                 },
                child: const Text(
                  'Налить',
                  style: TextStyle(fontSize: 60),
                ))
          ],
        ));
  }
}
