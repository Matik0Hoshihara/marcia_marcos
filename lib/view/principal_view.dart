import 'package:flutter/material.dart';
import '../core/app_routes.dart'; 

class PrincipalView extends StatelessWidget {
  const PrincipalView({super.key});

  
  final List<Map<String, String>> paises = const [
    {'nome': 'Japão', 'bandeira': '🇯🇵', 'rota': AppRoutes.japao},
    {'nome': 'Portugal', 'bandeira': '🇵🇹', 'rota': AppRoutes.portugal},
    {'nome': 'Espanha', 'bandeira': '🇪🇸', 'rota': AppRoutes.espanha},
    {'nome': 'Brasil', 'bandeira': '🇧🇷', 'rota': AppRoutes.brasil},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Viagens'),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Sair',
          onPressed: () {
            
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_outline),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.sugestoes),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.perfil),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.sobre),
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
            childAspectRatio: 0.9,
          ),
          itemCount: paises.length,
          itemBuilder: (context, index) {
            final p = paises[index];
            return Card(
              elevation: 3,
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, p['rota']!),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(p['bandeira']!, style: const TextStyle(fontSize: 45)),
                      const SizedBox(height: 12),
                      Text(
                        p['nome']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Align(
                        alignment: Alignment.center,
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