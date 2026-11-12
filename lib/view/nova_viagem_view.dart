import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/viagem_controller.dart';
 
class NovaViagemView extends StatefulWidget {
  const NovaViagemView({super.key});
 
  @override
  State<NovaViagemView> createState() => _NovaViagemViewState();
}
 
class _NovaViagemViewState extends State<NovaViagemView> {
  final _formKey = GlobalKey<FormState>();
 
  // Controladores locais para capturar os textos digitados
  final _destinoController = TextEditingController();
  final _idaController = TextEditingController();
  final _voltaController = TextEditingController();
  final _orcamentoController = TextEditingController();
 
  // Opções para o campo Status
  String _statusSelecionado = 'Planejada';
  final List<String> _statusOpcoes = ['Planejada', 'Em Andamento', 'Concluída'];
 
  @override
  void dispose() {
    _destinoController.dispose();
    _idaController.dispose();
    _voltaController.dispose();
    _orcamentoController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Viagem')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Cadastre um novo roteiro',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
 
                  // CAMPO 1: DESTINO
                  TextFormField(
                    controller: _destinoController,
                    decoration: const InputDecoration(
                      labelText: 'Destino',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v == null || v.isEmpty ? 'Informe o destino' : null,
                  ),
                  const SizedBox(height: 16),
 
                  // CAMPO 2: DATA IDA
                  TextFormField(
                    controller: _idaController,
                    decoration: const InputDecoration(
                      labelText: 'Data de Ida (ex: 10/12/2026)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v == null || v.isEmpty ? 'Informe a data de ida' : null,
                  ),
                  const SizedBox(height: 16),
 
                  // CAMPO 3: DATA VOLTA
                  TextFormField(
                    controller: _voltaController,
                    decoration: const InputDecoration(
                      labelText: 'Data de Volta (ex: 20/12/2026)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v == null || v.isEmpty ? 'Informe a data de volta' : null,
                  ),
                  const SizedBox(height: 16),
 
                  // CAMPO 4: ORÇAMENTO
                  TextFormField(
                    controller: _orcamentoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Orçamento Previsto (R\$)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v == null || v.isEmpty ? 'Informe o orçamento' : null,
                  ),
                  const SizedBox(height: 16),
 
                  // CAMPO 5: STATUS
                  DropdownButtonFormField<String>(
                    value: _statusSelecionado,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                    items: _statusOpcoes.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: (val) {
                      setState(() {
                        _statusSelecionado = val!;
                      });
                    },
                  ),
                  const SizedBox(height: 32),
 
                  // BOTÃO SALVAR (Com feedback de sucesso/erro para o RF003)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                    onPressed: _salvarViagem,
                    child: const Text('SALVAR VIAGEM'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
 
  // LÓGICA DE SALVAMENTO
  Future<void> _salvarViagem() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );
 
      // Converte o texto do orçamento para double (aceita ponto ou vírgula)
      final double orcamento = double.tryParse(_orcamentoController.text.replaceAll(',', '.')) ?? 0.0;
 
      // Chama o controlador
      final viagemController = GetIt.I<ViagemController>();
      final erro = await viagemController.adicionarViagem(
        destino: _destinoController.text.trim(),
        dataIda: _idaController.text.trim(),
        dataVolta: _voltaController.text.trim(),
        orcamento: orcamento,
        status: _statusSelecionado,
      );
 
      if (mounted) Navigator.pop(context); // Fecha o loading
 
      // Feedback na tela
      if (erro == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Viagem adicionada com sucesso!'), backgroundColor: Colors.green),
          );
          Navigator.pop(context); // Volta para a tela principal
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(erro), backgroundColor: Colors.red),
          );
        }
      }
    }
  }
}