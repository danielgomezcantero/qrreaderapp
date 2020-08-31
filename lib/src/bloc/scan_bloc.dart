import 'dart:async';

import 'package:qrreaderapp/src/models/scans_model.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    // Obterner Scans de la base de datos
    obtenerScans();
  }
  // Broadcast porque va a ser escuchado desde vario lugares del proyecto
  // tambien es necesario cerrar el controller
  final _scansController = StreamController<List<ScanModel>>.broadcast();

  // metodo para escuchar que datos fluye con el stream
  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose() {
    _scansController?.close();
  }

  agregarScan(ScanModel scan) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  obtenerScans() async {
    _scansController.sink.add(await DBProvider.db.getTodosScans());
  }

  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScanTodos() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
    //_scansController.sink.add([]);
  }
}
