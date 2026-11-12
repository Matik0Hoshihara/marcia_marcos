import 'package:flutter/material.dart';
import '../core/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
 
class PrincipalView extends StatelessWidget {
  const PrincipalView({super.key});
 
 final List < Map < String , String > > paises = const [
    {'nome': 'Japão', 'bandeira': '🇯🇵', 'rota': AppRoutes.japao},
    {'nome': 'Portugal', 'bandeira': '🇵🇹', 'rota': AppRoutes.portugal},
    {'nome': 'Espanha', 'bandeira': '🇪🇸', 'rota': AppRoutes.espanha},
    {'nome': 'Brasil', 'bandeira': '🇧🇷', 'rota': AppRoutes.brasil},
  ];
 
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
              tooltip: 'Perfil',
              onPressed: () => Navigator.pushNamed(context, AppRoutes.perfil),
            ),
            IconButton(
              icon: const Icon(Icons.info_outline),
              tooltip: 'Sobre',
              onPressed: () => Navigator.pushNamed(context, AppRoutes.sobre),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.explore), text: 'Destinos'),
              Tab(icon: Icon(Icons.flight), text: 'Minhas viagens'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            
            Padding(
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
 
            StreamBuilder<QuerySnapshot>(

              stream: FirebaseFirestore.instance

                  .collection('viagens')

                  .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)

                  .snapshots(),

              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {

                  return const Center(child: CircularProgressIndicator());

                }

                if (snapshot.hasError) {

                  return const Center(child: Text('Erro ao carregar as viagens.'));

                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {

                  return const Center(child: Text('Nenhuma viagem cadastrada ainda.'));

                }
 
                final viagens = snapshot.data!.docs;
 
                // ListView para exibir os dados em tempo real

                return ListView.builder(

                  itemCount: viagens.length,

                  itemBuilder: (context, index) {

                    final viagem = viagens[index].data() as Map<String, dynamic>;

                    return Card(

                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                      elevation: 2,

                      child: ListTile(

                        leading: const CircleAvatar(

                          backgroundColor: Colors.blue,

                          child: Icon(Icons.flight_takeoff, color: Colors.white),

                        ),

                        title: Text(

                          viagem['destino'] ?? 'Destino Indefinido',

                          style: const TextStyle(fontWeight: FontWeight.bold),

                        ),

                        subtitle: Text(

                          'Ida: ${viagem['dataIda']} | Volta: ${viagem['dataVolta']}\nStatus: ${viagem['status']}',

                        ),

                        trailing: Text(

                          'R\$ ${viagem['orcamento']}',

                          style: const TextStyle(

                            color: Colors.green,

                            fontWeight: FontWeight.bold,

                            fontSize: 15,

                          ),

                        ),

                      ),

                    );

                  },

                );

              },

            ),
 
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.novaViagem),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}