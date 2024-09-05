import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPicker extends StatefulWidget {
  final Function(LatLng) onLocationPicked;

  MapPicker({required this.onLocationPicked});

  @override
  _MapPickerState createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  late GoogleMapController _mapController;
  LatLng _selectedLocation = LatLng(37.7749, -122.4194); // Default location
  bool _initialLocationSet = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _selectedLocation = LatLng(position.latitude, position.longitude);
        _initialLocationSet = true;
        _mapController.animateCamera(
          CameraUpdate.newLatLng(_selectedLocation),
        );
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_initialLocationSet) {
      _mapController.animateCamera(
        CameraUpdate.newLatLng(_selectedLocation),
      );
    }
  }

  void _onTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
    widget.onLocationPicked(_selectedLocation);
    _mapController.animateCamera(
      CameraUpdate.newLatLng(_selectedLocation),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _selectedLocation,
          zoom: 12.0,
        ),
        onTap: _onTap,
        markers: {
          Marker(
            markerId: MarkerId('selected-location'),
            position: _selectedLocation,
          ),
        },
      ),
    );
  }
}
