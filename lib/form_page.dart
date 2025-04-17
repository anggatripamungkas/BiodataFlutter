import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nama = TextEditingController();
  final _nim = TextEditingController();
  final _fakultas = TextEditingController();
  final _alamat = TextEditingController();
  final _hp = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      Directory dir = await getApplicationDocumentsDirectory();
      String newPath = p.join(dir.path, p.basename(picked.path));
      await File(picked.path).copy(newPath);
      setState(() => _image = File(newPath));
    }
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('nama', _nama.text);
      await prefs.setString('nim', _nim.text);
      await prefs.setString('fakultas', _fakultas.text);
      await prefs.setString('alamat', _alamat.text);
      await prefs.setString('hp', _hp.text);
      if (_image != null) {
        await prefs.setString('foto', _image!.path);
      }
    }
  }

  void _goToDisplayPage() {
    Navigator.pushNamed(context, '/display');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Data Diri", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nama,
                decoration: const InputDecoration(labelText: "Nama"),
                validator: (value) => value!.isEmpty ? "Nama wajib diisi" : null,
              ),
              TextFormField(
                controller: _nim,
                decoration: const InputDecoration(labelText: "NIM"),
                validator: (value) => value!.isEmpty ? "NIM wajib diisi" : null,
              ),
              TextFormField(
                controller: _fakultas,
                decoration: const InputDecoration(labelText: "Fakultas / Prodi"),
                validator: (value) => value!.isEmpty ? "Fakultas wajib diisi" : null,
              ),
              TextFormField(
                controller: _alamat,
                decoration: const InputDecoration(labelText: "Alamat"),
                validator: (value) => value!.isEmpty ? "Alamat wajib diisi" : null,
              ),
              TextFormField(
                controller: _hp,
                decoration: const InputDecoration(labelText: "No HP"),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? "Nomor HP wajib diisi" : null,
              ),
              const SizedBox(height: 20),

              /// Tombol pilih foto kecil di sebelah kiri
              Row(
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo, size: 18, color: Colors.white),
                    label: const Text(
                      "Pilih Foto",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                  const SizedBox(width: 16),
                  /// Foto kecil di sebelah kanan tombol
                  _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(_image!, height: 80, width: 80, fit: BoxFit.cover),
                        )
                      : const Icon(Icons.person, size: 80),
                ],
              ),

              const SizedBox(height: 30),

              /// Tombol Simpan dan Lihat dipisah
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[800],
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _saveData,
                      child: const Text("Simpan", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[600],
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _goToDisplayPage,
                      child: const Text("Lihat", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
