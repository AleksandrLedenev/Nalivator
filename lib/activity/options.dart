import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  const Options({super.key});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {

  bool _autoMode = false;
  bool _leftMode = false;

  bool getAutoMode() {
    return _autoMode;
  }

  bool getLeftMode() {
    return _leftMode;
  }

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
                      _autoMode = value!;
                    });
                  },
                  value: _autoMode,
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
                      _leftMode = value!;
                    });
                  },
                  value: _leftMode,
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
            Text('Автоматический режим: $_autoMode'),
            Text('Левый режим: $_leftMode'),
          ],
        ));
  }
}
