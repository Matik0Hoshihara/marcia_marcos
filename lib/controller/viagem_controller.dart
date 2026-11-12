import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
 
class ViagemController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
 
  // Inserção de dados 
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
        'userId': user.uid, 
        'destino': destino, 
        'dataIda': dataIda, 
        'dataVolta': dataVolta, 
        'orcamento': orcamento, 
        'status': status, 
        'criadoEm': FieldValue.serverTimestamp(),
      });
 
      return null; 
    } catch (e) {
      return 'Erro ao salvar a viagem: $e';
    }
  }
}