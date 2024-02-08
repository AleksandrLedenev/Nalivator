import 'package:flutter/material.dart';
import 'package:nalivator_applicatioin2/main.dart';

class Options extends StatefulWidget {

  const Options({super.key});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Настройки'),
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
                  },
                  value: leftMode,
                )),
            ListTile(
              onTap: () {
                
              },
              leading: const Icon(Icons.help),
              title: const Text(
                'Помощь',
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
            ),
            Text('Автоматический режим: $autoMode'),
            Text('Левый режим: $leftMode'),
          ],
        ));
  }
}
