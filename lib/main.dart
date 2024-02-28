import 'package:flutter/material.dart';
import '/activity/options.dart';
import 'activity/home.dart';
import 'activity/connection.dart';

void main() {
  runApp(const MainApp());
}


  bool autoMode = false;
  bool leftMode = false;

  bool isConnect = true;
 
  


class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentPage = 1;

  static const _colorGrayWindow =  Color(0xFF9DA1AA);
  static const _colorDarkBlue =  Color(0xFF3B83BD);
  

  List<Widget> pageList = [
    const Connection(),
    const Home(),
    const Options(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nalivator Applcation',
      home: Scaffold(
          body: IndexedStack(
            index: _currentPage,
            children: pageList,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentPage,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.contactless), label: "Соединение"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Главная"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Настройки"),
            ],
            onTap: (int intIndex) {
              setState(() {
                _currentPage = intIndex;
              });
            },
            enableFeedback: true,
            iconSize: 40,
            selectedIconTheme: const IconThemeData(color: _colorDarkBlue, size: 35),
            unselectedIconTheme: const IconThemeData(color: _colorGrayWindow, size: 30),
            selectedLabelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
          )),
    );
  }
}
