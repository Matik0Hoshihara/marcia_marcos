import 'package:flutter/material.dart';

class PaisDetalheView extends StatelessWidget {
  final String nomePais;
  final String bandeira;
  final String moeda;
  final String locaisTuristicos;
  final String lingua;

  const PaisDetalheView({
    super.key,
    required this.nomePais,
    required this.bandeira,
    required this.moeda,
    required this.locaisTuristicos,
    required this.lingua,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$bandeira $nomePais'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.attach_money, color: Colors.green),
                title: const Text('Moeda'),
                subtitle: Text(moeda),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.place, color: Colors.red),
                title: const Text('Locais Turísticos'),
                subtitle: Text(locaisTuristicos),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.menu_book, color: Colors.blue),
                title: const Text('Dicionário (Língua)'),
                subtitle: Text(lingua),
              ),
            ),
          ],
        ),
      ),
    );
  }
}