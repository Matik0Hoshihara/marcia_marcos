import 'package:flutter/material.dart';

class UsuarioController extends ChangeNotifier {
  static final UsuarioController instance = UsuarioController._();
  UsuarioController._();

  String _nome = '';
  String _email = '';
  String _telefone = '';

  String get nome => _nome;
  String get email => _email;
  String get telefone => _telefone;

  void definirUsuario({required String email, String? nome, String? telefone}) {
    _email = email;
    
    if (nome != null && nome.isNotEmpty) {
      _nome = nome;
    } else if (email.isNotEmpty) {
      String nomeBase = email.split('@').first;
      _nome = nomeBase[0].toUpperCase() + nomeBase.substring(1);
    } else {
      _nome = 'Usuário';
    }
    _telefone = telefone ?? '';
    notifyListeners();
  }

  void atualizarNome(String novoNome) {
    _nome = novoNome;
    notifyListeners();
  }
}