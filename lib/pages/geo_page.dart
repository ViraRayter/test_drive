import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeoPage extends StatefulWidget   {
  @override
  _GeoPageState createState() => _GeoPageState();
}

class _GeoPageState extends State<GeoPage>  {
  double latitude = 0.0; // Исходные координаты
  double longitude = 0.0;

  String address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Геокоординаты"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Координаты",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Широта: $latitude\nДолгота: $longitude",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "Aдрес:",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              address,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                getCurrentLocation();
                getAddressFromCoordinates();
              },
              child: Text("Найти адрес"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
    } catch (e) {
      print("Error getting current location: $e");
    }
  }

  Future<void> getAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark firstPlacemark = placemarks.first;

        setState(() {
          address = """
            Страна: ${firstPlacemark.country}
            Область: ${firstPlacemark.administrativeArea}
            Населенный пункт: ${firstPlacemark.locality}
            Регион: ${firstPlacemark.subLocality}
            Улица: ${firstPlacemark.thoroughfare}
            Дом: ${firstPlacemark.subThoroughfare}
            Почтовый код: ${firstPlacemark.postalCode}
            Код региона: ${firstPlacemark.isoCountryCode}
          """;
        });
      } else {
        setState(() {
          address = "No placemarks found";
        });
      }
    } catch (e) {
      setState(() {
        address = "Error: $e";
      });
    }
  }
}