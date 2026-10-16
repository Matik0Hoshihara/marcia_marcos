import 'package:flutter/material.dart';

class SugestoesController extends ChangeNotifier {
  String sugestao = '';

  void setSugestao(String value) {
    sugestao = value;
  }

  bool enviarSugestao() {
    if (sugestao.trim().isNotEmpty) {
      
      sugestao = '';
      notifyListeners();
      return true;
    }
    return false;
  }
}