import 'package:flutter/material.dart';

class CadastrarUsuarioController extends ChangeNotifier {
  String nome = '';
  String email = '';
  String telefone = '';
  String senha = '';
  String confirmarSenha = '';

  void setNome(String value) => nome = value;
  void setEmail(String value) => email = value;
  void setTelefone(String value) => telefone = value;
  void setSenha(String value) => senha = value;
  void setConfirmarSenha(String value) => confirmarSenha = value;
}