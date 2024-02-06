import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:sensors/sensors.dart';


class CameraPage extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late File _image;
  List<double> _accelerometerValues = [0, 0, 0];


  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;

      // Сделать снимок
      final XFile picture = await _controller.takePicture();

      // Сохранить снимок в галерею
      await GallerySaver.saveImage(picture.path);

      setState(() {
        _image = File(picture.path);
      });
    } catch (e) {
      print("Ошибка при съемке: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = [event.x, event.y, event.z];
      });
    });

    // Получите список доступных камер
    availableCameras().then((cameras) {
      // Выберите камеру (обычно выбирается задняя камера)
      _controller = CameraController(cameras[0], ResolutionPreset.medium);

      // Инициализация контроллера камеры
      _initializeControllerFuture = _controller.initialize();
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Освободите ресурсы контроллера камеры при завершении
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Камера'),
      ),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Если инициализация завершена, отобразите видеопоток камеры
            return CameraPreview(_controller);
          } else {
            // В противном случае отобразите индикатор загрузки
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (10 - _accelerometerValues[1] < 3) ? () {_takePicture(); print('yes');} : null,
        //onPressed: _takePicture,
        child: Icon(Icons.camera),
      ),
    );
  }
}
