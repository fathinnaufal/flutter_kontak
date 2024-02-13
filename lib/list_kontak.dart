import 'package:flutter/material.dart';
import 'form_kontak.dart';
import 'database/db_helper.dart';
import 'model/kontak.dart';

class ListKontakPage extends StatefulWidget {
  const ListKontakPage({Key? key}) : super(key: key);

  @override
  _ListKontakPageState createState() => _ListKontakPageState();
}

class _ListKontakPageState extends State<ListKontakPage> {
  List<Kontak> listKontak = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    _getAllKontak();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kontak App"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: listKontak.length,
        itemBuilder: (context, index) {
          Kontak kontak = listKontak[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('${kontak.name}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email: ${kontak.email}"),
                  Text("Phone: ${kontak.mobileNo}"),
                  Text("Company: ${kontak.company}"),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      _openFormEdit(kontak);
                    },
                    icon: Icon(Icons.edit),
                    color: Colors.blue,
                  ),
                  IconButton(
                    onPressed: () {
                      _confirmDeleteKontak(kontak, index);
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openFormCreate();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Future<void> _getAllKontak() async {
    var list = await db.getAllKontak();
    setState(() {
      listKontak.clear();
      list!.forEach((kontak) {
        listKontak.add(Kontak.fromMap(kontak));
      });
    });
  }

  Future<void> _confirmDeleteKontak(Kontak kontak, int position) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to delete ${kontak.name}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteKontak(kontak, position);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteKontak(Kontak kontak, int position) async {
    await db.deleteKontak(kontak.id!);
    setState(() {
      listKontak.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormKontak()),
    );
    if (result == 'save') {
      await _getAllKontak();
    }
  }

  Future<void> _openFormEdit(Kontak kontak) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormKontak(kontak: kontak)),
    );
    if (result == 'update') {
      await _getAllKontak();
    }
  }
}
