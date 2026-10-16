import 'package:flutter/material.dart';
import 'pais_detalhe_view.dart';

class JapaoView extends StatelessWidget {
  const JapaoView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PaisDetalheView(
      nomePais: 'Japão',
      bandeira: '🇯🇵',
      moeda: 'Iene (JPY - ¥)',
      locaisTuristicos: 'Monte Fuji, Templo Senso-ji, Quioto, Castelo de Osaka',
      lingua: 'Japonês (Ex: Olá = Konnichiwa / Obrigado = Arigatou)',
    );
  }
}