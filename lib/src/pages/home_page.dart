import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/models/scans_model.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: [
          IconButton(icon: Icon(Icons.delete_forever), onPressed: () {})
        ],
      ),
      body: callPage(currentIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanQr,
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _crearBottomNavigationBar(),
    );
  }

  _scanQr() async {
    dynamic futureString;
    //Strisng futureString;
    // final _flashOnController = TextEditingController(text: "Flash on");
    // final _flashOffController = TextEditingController(text: "Flash off");
    // final _cancelController = TextEditingController(text: "Cancel");

    futureString = 'htts://fernando-herrera.com';
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

      DBProvider.db.nuevoScan(scan);
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
