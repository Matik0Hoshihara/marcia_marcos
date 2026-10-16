import 'package:flutter/material.dart';

class RecuperarSenhaController extends ChangeNotifier {
  String email = '';

  void setEmail(String value) => email = value;
}