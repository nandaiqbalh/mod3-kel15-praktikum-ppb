import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  // create state for this page
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // add list untuk menampung Nama dan NIM anggota
  List<Widget> _anggota = <Widget>[
    Text("Nanda Iqbal Hanafi - 21120120130109"),
    Text("Alya Zahra Fatikha - 21120120140056"),
    Text("Anggi Nikmatun Zahra  - 21120120120008"),
    Text("Novita Auliya - 21120120140114"),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('images/logo.png'))),
          ),
          SizedBox(height: 20),
          Text(
            "KELOMPOK 15",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 20),
          Expanded(
              child: ListView.separated(
            itemCount: _anggota.length,
            itemBuilder: (BuildContext context, int index) {
              return _anggota.elementAt(index);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              thickness: 1,
            ),
          ))
        ],
      ),
    );
  }
}
