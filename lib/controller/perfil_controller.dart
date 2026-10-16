import 'package:flutter/material.dart';

class PerfilController extends ChangeNotifier {
  String nome = '';
  String email = 'usuario@email.com'; 
  
  void setNome(String value) => nome = value;

  void setUsuarioAutenticado({required String emailAutenticado, String? nomeInicial}) {
    email = emailAutenticado;
    nome = nomeInicial ?? '';
    notifyListeners();
  }
}