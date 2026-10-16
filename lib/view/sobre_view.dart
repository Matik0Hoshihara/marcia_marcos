import 'package:flutter/material.dart';

class SobreView extends StatelessWidget {
  const SobreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o App'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.flight_takeoff, size: 80, color: Colors.blue),
            const SizedBox(height: 24),
            const Text(
              'App de Viagens',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Versão 1.0.0\n\nAplicação desenvolvida para gerir e planejar as suas aventuras pelo mundo em 2026.\n\nDesenvolvido por: Márcia Matiko Hoshihara e Marcos Paulo Misuki',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 32),
            const Text(
              'Informações Acadêmicas',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              '• Disciplina: Programação de Dispositivos Móveis\n• Instituição: FATEC Ribeirão Preto\n• Professor: Rodrigo de Oliveira Plotze',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}