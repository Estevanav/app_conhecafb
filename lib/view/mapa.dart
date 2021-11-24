import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class ScreenMap extends StatefulWidget {
  @override
  _ScreenMapState createState() => _ScreenMapState();
}

class _ScreenMapState extends State<ScreenMap> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(0, 0),
    zoom: 5,
  );
  //LatLng(-20.810869, -49.379131)

  double bottomPaddingOfMap = 0.0;
  LatLng posicao = LatLng(0, 0);

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  late Position currentPosition;

  var geoLocator = Geolocator();

  void locatedPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    posicao = latLatPosition;

    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 19);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void position() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    setState(() {
      _marker.add(
        Marker(
          markerId: MarkerId('Aqui'),
          infoWindow: InfoWindow(title: 'Você está aqui'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: latLatPosition,
        ),
      );
    });
  }

  Set<Marker> _marker = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encontre o local do seu ponto turístico'),
        backgroundColor: Colors.lightGreen[900],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialCameraPosition,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controllerGoogleMap.complete(controller);
          newGoogleMapController = controller;

          locatedPosition();
          position();
        },
        markers: _marker,
        onTap: (latLng) {
          setState(() {
            _marker.add(
              Marker(
                markerId: MarkerId('Local'),
                infoWindow: InfoWindow(title: 'Local de Interesse'),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen),
                position: latLng,
              ),
            );
          });
          posicao = latLng;
        },
      ),
    );
  }
}
