import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
 
class AuthController {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 
  // Registo de Utilizadores com campos adicionais

  Future<String?> registrar(String email, String senha, String nome, String telefone) async {

    try {

      UserCredential cred = await _auth.createUserWithEmailAndPassword(

        email: email,

        password: senha,

      );

      // Armazenamento dos campos adicionais na coleção usuarios

      await _firestore.collection('usuarios').doc(cred.user!.uid).set({

        'nome': nome,

        'telefone': telefone,

        'criadoEm': FieldValue.serverTimestamp(),

      });

      return null; // Retorna nulo em caso de sucesso

    } on FirebaseAuthException catch (e) {

      return e.message; // Retorna a mensagem de erro do Firebase

    } catch (e) {
      print("ERRO COMPLETO: $e"); // Imprime o rastreio na consola do VS Code
      return e.toString(); // Devolve o texto técnico exato para a sua SnackBar vermelha
    }

  }
 
  // Autenticação de Utilizadores

  Future<String?> login(String email, String senha) async {

    try {

      await _auth.signInWithEmailAndPassword(email: email, password: senha);

      return null; 

    } on FirebaseAuthException catch (e) {

      return e.message; 

    }

  }
 
  // Recuperação de Senha

  Future<void> recuperarSenha(String email) async {

    await _auth.sendPasswordResetEmail(email: email);

  }
  

}

 