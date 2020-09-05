import 'dart:async';

import 'package:qrreaderapp/src/bloc/validators.dart';
import 'package:qrreaderapp/src/models/scans_model.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc with Validators {
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
  Stream<List<ScanModel>> get scansStream =>
      _scansController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scansStreamHttp =>
      _scansController.stream.transform(validarHttp);

  dispose() {
    _scansController?.close();
  }

  obtenerScans() async {
    _scansController.sink.add(await DBProvider.db.getTodosScans());
  }

  agregarScan(ScanModel scan) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
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
