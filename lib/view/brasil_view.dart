import 'package:flutter/material.dart';
import 'pais_detalhe_view.dart';

class BrasilView extends StatelessWidget {
  const BrasilView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PaisDetalheView(
      nomePais: 'Brasil',
      bandeira: '🇧🇷',
      moeda: 'Real (BRL - R\$)',
      locaisTuristicos: 'Cristo Redentor, Cataratas do Iguaçu, Pelourinho',
      lingua: 'Português do Brasil (Ex: Olá = Tudo bem? / Obrigado = Valeu!)',
    );
  }
}