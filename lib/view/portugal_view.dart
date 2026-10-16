import 'package:flutter/material.dart';
import 'pais_detalhe_view.dart';

class PortugalView extends StatelessWidget {
  const PortugalView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PaisDetalheView(
      nomePais: 'Portugal',
      bandeira: '🇵🇹',
      moeda: 'Euro (EUR - €)',
      locaisTuristicos: 'Torre de Belém, Palácio da Pena, Ribeira do Porto',
      lingua: 'Português (Ex: Olá = Olá / Obrigado = Obrigado)',
    );
  }
}