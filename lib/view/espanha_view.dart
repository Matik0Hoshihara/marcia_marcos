import 'package:flutter/material.dart';
import 'pais_detalhe_view.dart';

class EspanhaView extends StatelessWidget {
  const EspanhaView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PaisDetalheView(
      nomePais: 'Espanha',
      bandeira: '🇪🇸',
      moeda: 'Euro (EUR - €)',
      locaisTuristicos: 'Sagrada Família, Parque do Retiro, Alhambra',
      lingua: 'Espanhol (Ex: Olá = ¡Hola! / Obrigado = Gracias)',
    );
  }
}