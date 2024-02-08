import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nalivator_applicatioin2/main.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';


class GlassIndicator extends StatefulWidget{
  const GlassIndicator({super.key});

  @override
  State<GlassIndicator> createState() => _GlassIndicator();

}

class _GlassIndicator extends State<GlassIndicator> {
  Color _color = Colors.blue;
 // bool isPresed = false;

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
                  log(slider._value.toInt().toString());
                },
                child: const Text(
                  'Налить',
                  style: TextStyle(fontSize: 60),
                ))
          ],
        ));
  }
}
