import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  String email = '';
  String senha = '';

  void setEmail(String value) => email = value;
  void setSenha(String value) => senha = value;
}