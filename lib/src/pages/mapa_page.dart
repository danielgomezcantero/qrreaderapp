import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderapp/src/models/scans_model.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final map = new MapController();

  String tipoMapa = 'satellite';

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
              onPressed: () {
                map.move(scan.getLatLng(), 15.0);
              })
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15,
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan),
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
          'id': 'mapbox.$tipoMapa'
          //'id': 'mapbox.mapbox-streets-v8 , satellite, '
        });
  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(markers: [
      Marker(
        width: 100.0,
        height: 100.0,
        point: scan.getLatLng(),
        builder: (context) => Container(
          child: Icon(Icons.location_on,
              size: 45.0, color: Theme.of(context).primaryColor),
        ),
      )
    ]);
  }

  Widget _crearBotonFlotante(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.repeat),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          if (tipoMapa == 'satellite') {
            tipoMapa = 'mapbox-streets-v8';
          } else {
            tipoMapa = 'satellite';
          }
          setState(() {});
        });
  }
}
