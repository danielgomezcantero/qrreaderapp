import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scan_bloc.dart';
import 'package:qrreaderapp/src/models/scans_model.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: [
          IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                scansBloc.borrarScanTodos();
              })
        ],
      ),
      body: callPage(currentIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scanQr(context),
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _crearBottomNavigationBar(),
    );
  }

  _scanQr(BuildContext context) async {
    dynamic futureString;
    //Strisng futureString;
    // final _flashOnController = TextEditingController(text: "Flash on");
    // final _flashOffController = TextEditingController(text: "Flash off");
    // final _cancelController = TextEditingController(text: "Cancel");

    futureString = 'https://fernando-herrera.com/';
    // try {
    //   futureString = await BarcodeScanner.scan(
    //       //     options: const ScanOptions(
    //       //   useCamera: -1,
    //       // )
    //       );
    // } catch (e) {
    //   futureString = e.toString();
    // }
    // print('Future string: ${futureString.rawContent}');

    if (futureString != null) {
      print('Tenemos info');
      final scan = ScanModel(valor: futureString);
      //DBProvider.db.nuevoScan(scan);
      scansBloc.agregarScan(scan);

      final scan2 = ScanModel(valor: 'geo:-25.412202,-57.538757');
      //DBProvider.db.nuevoScan(scan);
      scansBloc.agregarScan(scan2);

      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.abrirScan(context, scan);
        });
      } else {
        utils.abrirScan(context, scan);
      }
    }
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Mapas')),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5), title: Text('Direcciones')),
      ],
    );
  }

  Widget callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
