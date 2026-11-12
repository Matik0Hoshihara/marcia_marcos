import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
 
class ViagemController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
 
  // RF003: Inserção de dados (5 campos mínimos + segregação por usuário)
  Future<String?> adicionarViagem({
    required String destino,
    required String dataIda,
    required String dataVolta,
    required double orcamento,
    required String status,
  }) async {
    try {
      // Pega o ID do usuário que está logado atualmente
      final user = _auth.currentUser;
      if (user == null) {
        return 'Erro: Usuário não está autenticado.';
      }
 
      // Salva os dados na coleção 'viagens'
      await _firestore.collection('viagens').add({
        'userId': user.uid, // Garante a separação dos dados por usuário
        'destino': destino, // Campo 1
        'dataIda': dataIda, // Campo 2
        'dataVolta': dataVolta, // Campo 3
        'orcamento': orcamento, // Campo 4
        'status': status, // Campo 5
        'criadoEm': FieldValue.serverTimestamp(),
      });
 
      return null; // Retorna nulo quando dá sucesso
    } catch (e) {
      return 'Erro ao salvar a viagem: $e';
    }
  }
}