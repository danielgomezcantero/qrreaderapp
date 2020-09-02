import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderapp/src/models/scans_model.dart';

class MapaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.my_location,
                color: Colors.white,
              ),
              onPressed: null)
        ],
      ),
      body: _crearFlutterMap(scan),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15,
      ),
      layers: [
        _crearMapa(),
      ],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1IjoiZGFtYXhnb21leiIsImEiOiJja2VsZHI0eXUwOTJ1MnRvOXVuc3EweTgyIn0.04b7QGB5OipKiMIw80lXbQ',
          'id': 'mapbox.satellite'
          //'id': 'mapbox.mapbox-streets-v8'
        });
  }
}
