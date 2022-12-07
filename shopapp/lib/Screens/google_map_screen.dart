import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopapp/Screens/product_overviewScreen.dart';

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({super.key});

  static const routeName = '/google_maps_screen';

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(1.3733, -32.2903);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
           // Navigator.of(context).pop();
           Navigator.of(context).pushReplacementNamed(ProductOverView.routeName);
          },
        ),
        title: const Text('Google Maps'),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}