import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'model/kontak.dart';

class FormKontak extends StatefulWidget {
  final Kontak? kontak;

  FormKontak({this.kontak});

  @override
  _FormKontakState createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak> {
  DbHelper db = DbHelper();

  TextEditingController? name;
  TextEditingController? mobileNo;
  TextEditingController? email;
  TextEditingController? company;

  @override
  void initState() {
    name = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.name);
    mobileNo = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.mobileNo);
    email = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.email);
    company = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.company);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Kontak'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: mobileNo,
              decoration: InputDecoration(
                labelText: 'Mobile No',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: email,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: company,
              decoration: InputDecoration(
                labelText: 'Company',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: () {
                upsertKontak();
              },
              child: Text(widget.kontak == null ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> upsertKontak() async {
    if (widget.kontak != null) {
      await db.updateKontak(Kontak(
        id: widget.kontak!.id,
        name: name!.text,
        mobileNo: mobileNo!.text,
        email: email!.text,
        company: company!.text,
      ));
      Navigator.pop(context, 'update');
    } else {
      await db.saveKontak(Kontak(
        name: name!.text,
        mobileNo: mobileNo!.text,
        email: email!.text,
        company: company!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
