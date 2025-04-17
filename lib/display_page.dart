import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  String? nama, nim, fakultas, alamat, hp, fotoPath;

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama') ?? '-';
      nim = prefs.getString('nim') ?? '-';
      fakultas = prefs.getString('fakultas') ?? '-';
      alamat = prefs.getString('alamat') ?? '-';
      hp = prefs.getString('hp') ?? '-';
      fotoPath = prefs.getString('foto');
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Diri",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown[700],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (fotoPath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(File(fotoPath!), height: 200, fit: BoxFit.cover),
              )
            else
              const Icon(Icons.person, size: 150, color: Colors.grey),
            const SizedBox(height: 10),
            Text("Nama: $nama", style: const TextStyle(fontSize: 16, color: Colors.black)),
            Text("NIM: $nim", style: const TextStyle(fontSize: 16, color: Colors.black)),
            Text("Fakultas / Prodi: $fakultas", style: const TextStyle(fontSize: 16, color: Colors.black)),
            Text("Alamat: $alamat", style: const TextStyle(fontSize: 16, color: Colors.black)),
            Text("No HP: $hp", style: const TextStyle(fontSize: 16, color: Colors.black)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[800],
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text("Kembali", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
