import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Connection extends StatefulWidget {
  const Connection({super.key});

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  String _titleText = 'Соединение';
  Color _appBarColor = Colors.cyan;

  List<BluetoothDevice> devicesList = [];
  FlutterBlue flutterBlue = FlutterBlue.instance;

  void _startScanning() {
    flutterBlue.startScan(timeout: const Duration(seconds: 4));
    devicesList.clear();
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (!devicesList.contains(r.device)) {
          setState(() {
            devicesList.add(r.device);
          });
        }
      }
    });
    flutterBlue.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_titleText, style: const TextStyle(fontSize: 30)),
          backgroundColor: _appBarColor,
        ),
        body: Column(
          children: <Widget>[
            if(devicesList.isEmpty)
            const Center(
              child: Text('Ничего не найдено', style: TextStyle(fontSize: 35))),
            Expanded(
              child: ListView.builder(
                itemCount: devicesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(devicesList[index].name),
                    subtitle: Text(devicesList[index].id.toString()),
                    onTap: () {
                      devicesList[index].connect();
                      setState(() {
                        _titleText = 'Подключено';
                        _appBarColor = Colors.green;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: _startScanning, 
            child: const Icon(Icons.search))
            );
  }
}
