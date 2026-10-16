import 'package:flutter/material.dart';

class UsuarioController extends ChangeNotifier {
  static final UsuarioController instance = UsuarioController._();
  UsuarioController._();

  String _nome = '';
  String _email = 'usuario@email.com';

  String get nome => _nome;
  String get email => _email;

  void definirEmail(String emailDigitado) {
    _email = emailDigitado.trim();
    notifyListeners();
  }

  void atualizarNome(String novoNome) {
    _nome = novoNome.trim();
    notifyListeners();
  }
}