import 'package:flutter/material.dart';
import 'pages/camera_page.dart';
import 'pages/geo_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
int _currentIndex = 0; // Индекс текущей выбранной кнопки

final List<Widget> _pages = [
  GeoPage(),CameraPage()
];

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Приложение'),
    ),
    body: _pages[_currentIndex], // Отображаем текущий экран на основе индекса
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index; // Обновляем индекс при выборе кнопки
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.add_location),
          label: 'Геолокация',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera),
          label: 'Камера',
        ),
      ],
    ),
  );
}
}