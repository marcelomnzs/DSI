import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationPage extends StatefulWidget {
  final LatLng initialPosition;

  const SelectLocationPage({Key? key, required this.initialPosition}) : super(key: key);

  @override
  _SelectLocationPageState createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  late LatLng _selectedPosition;

  @override
  void initState() {
    super.initState();
    _selectedPosition = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolher Localização'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context, _selectedPosition);
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _selectedPosition,
          zoom: 15.0,
        ),
        onTap: (LatLng position) {
          setState(() {
            _selectedPosition = position;
          });
        },
        markers: {
          Marker(
            markerId: MarkerId('selected_location'),
            position: _selectedPosition,
            draggable: true,
            onDragEnd: (LatLng newPosition) {
              setState(() {
                _selectedPosition = newPosition;
              });
            },
          ),
        },
      ),
    );
  }
}
