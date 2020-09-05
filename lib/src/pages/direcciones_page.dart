import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scan_bloc.dart';
import 'package:qrreaderapp/src/models/scans_model.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class DireccionesPage extends StatefulWidget {
  @override
  _DireccionesPageState createState() => _DireccionesPageState();
}

class _DireccionesPageState extends State<DireccionesPage> {
  final scanBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {
    scanBloc.obtenerScans();
    return StreamBuilder(
      stream: scanBloc.scansStreamHttp,
      //  utiizado con FutureBuilder DBProvider.db.getTodosScans(),
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        final scans = snapshot.data;
        if (snapshot.hasData) {
          if (scans.length == 0) {
            return Center(
              child: Text('No hay información'),
            );
          }

          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) =>
                    scanBloc.borrarScan(scans[index].id),

                // utiizado con FutureBuilder DBProvider.db.deleteScan(),
                background: Container(
                  color: Colors.red,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.cloud_queue,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(scans[index].valor),
                  subtitle: Text('Id: ${scans[index].id}'),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    if (scans[index].tipo != null) {
                      utils.abrirScan(context, scans[index]);
                    }
                    setState(() {});
                  },
                ),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
