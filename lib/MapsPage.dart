import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as perm_handler;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  GoogleMapController? _controller;
  Location _location = Location();
  LatLng? _userLocation;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com'));
      if (result.statusCode != 200) {
        setState(() {
          _isConnected = false;
        });
        _showNoInternetDialog();
      }
    } catch (e) {
      print('Error checking internet connection: $e');
      setState(() {
        _isConnected = false;
      });
      _showNoInternetDialog();
    }
  }

  Future<void> _checkLocationPermission() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          _showLocationSettingsDialog();
          return;
        }
      }

      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          _showLocationSettingsDialog();
          return;
        }
      }

      await _getUserLocation();
    } catch (e) {
      print('Error checking location permission: $e');
      _showLocationSettingsDialog();
    }
  }

  Future<void> _getUserLocation() async {
    try {
      var locationData = await _location.getLocation();
      if (locationData.latitude != null && locationData.longitude != null) {
        setState(() {
          _userLocation = LatLng(locationData.latitude!, locationData.longitude!);
        });

        if (_controller != null) {
          _controller!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: _userLocation!,
                zoom: 15,
              ),
            ),
          );
        }
      } else {
        print('Error: Location data is null');
      }
    } catch (e) {
      print('Error getting user location: $e');
      _showLocationSettingsDialog();
    }
  }

  void _showLocationSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Местоположение отключено'),
        content: Text('Пожалуйста, включите местоположение в настройках.'),
        actions: [
          TextButton(
            onPressed: () {
              perm_handler.openAppSettings();
              Navigator.of(context).pop();
            },
            child: Text('Открыть настройки'),
          ),
        ],
      ),
    );
  }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Нет подключения к Интернету'),
        content: Text('Пожалуйста, проверьте ваше подключение к Интернету.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('ОК'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Карта'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _controller = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(34.0479, 100.6197),
              zoom: 1,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),
          Positioned(
            bottom: 100,
            right: 5,
            child: FloatingActionButton(
              onPressed: () {
                if (_isConnected) {
                  _checkLocationPermission();
                } else {
                  _showNoInternetDialog();
                }
              },
              backgroundColor: Colors.white,
              child: Icon(Icons.my_location, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
