import 'package:flutter/material.dart';

class PrincipalView extends StatelessWidget {
  const PrincipalView({super.key});

  final List<Map<String, String>> paises = const [
    {'nome': 'Japão', 'bandeira': '🇯🇵', 'rota': '/japao'},
    {'nome': 'Portugal', 'bandeira': '🇵🇹', 'rota': '/portugal'},
    {'nome': 'Espanha', 'bandeira': '🇪🇸', 'rota': '/espanha'},
    {'nome': 'Brasil', 'bandeira': '🇧🇷', 'rota': '/brasil'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Viagens para 2026'),
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_outline),
            onPressed: () => Navigator.pushNamed(context, '/sugestoes'),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/perfil'),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.pushNamed(context, '/sobre'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: paises.length,
          itemBuilder: (context, index) {
            final p = paises[index];
            return Card(
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, p['rota']!),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(p['bandeira']!, style: const TextStyle(fontSize: 40)),
                      const SizedBox(height: 8),
                      Text(p['nome']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(Icons.arrow_forward, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}