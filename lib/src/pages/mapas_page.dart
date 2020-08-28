import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/models/scans_model.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class MapasPage extends StatefulWidget {
  @override
  _MapasPageState createState() => _MapasPageState();
}

class _MapasPageState extends State<MapasPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DBProvider.db.getTodosScans(),
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        final scans = snapshot.data;
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) =>
                    DBProvider.db.deleteScan(scans[index].id),
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
