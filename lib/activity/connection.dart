import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:nalivator_applicatioin2/controllers/bluetooth.dart';


class Connection extends StatefulWidget {
  const Connection({super.key});

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Соединение'),
          backgroundColor: Colors.green[400],
        ),
      body: GetBuilder<BleController>(
        init: BleController(),
        builder: (controller) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15,),
                StreamBuilder<List<ScanResult>>(
                    stream: controller.scanResults,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final data = snapshot.data![index];
                              return Card(
                                elevation: 2,
                                child: ListTile(
                                  title: Text(data.device.name),
                                  subtitle: Text(data.device.id.id),
                                  trailing: Text(data.rssi.toString()),
                                ),
                              );
                            });
                      }else{
                          return const Text("No Device Found");
                      }
                    }),
                ElevatedButton(
                  onPressed: () =>controller.scanDevices(), 
                  child: const Text(
                    "Scan",
                    style: TextStyle(fontSize: 60))
                  ),
                const SizedBox( height: 15,),
              ],
            ),
          );
        },
      ),
    );
}
}
  



