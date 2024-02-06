import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class GyroscopePage extends StatefulWidget {
  @override
  _GyroscopePageState createState() => _GyroscopePageState();
}

class _GyroscopePageState extends State<GyroscopePage> {
  List<double> _accelerometerValues = [0, 0, 0];

  @override
  void initState() {
    super.initState();
    // Начать получать данные с гироскопа
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = [event.x, event.y, event.z];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Гироскоп'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Значения гироскопа:'),
            Text('X: ${_accelerometerValues[0]}'),
            Text('Y: ${_accelerometerValues[1]}'),
            Text('Z: ${_accelerometerValues[2]}'),
          ],
        ),
      ),
    );
  }

}