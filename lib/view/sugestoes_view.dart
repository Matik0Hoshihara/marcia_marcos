import 'package:flutter/material.dart';
import '../controller/sugestoes_controller.dart';

class SugestoesView extends StatefulWidget {
  const SugestoesView({super.key});

  @override
  State<SugestoesView> createState() => _SugestoesViewState();
}

class _SugestoesViewState extends State<SugestoesView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = SugestoesController();
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SUGESTÕES DE VIAGEM'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Envie a sua sugestão ou pedido de destino para a equipe:',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _textController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'SUA SUGESTÃO',
                    hintText: 'Ex: Gostaria de ver roteiros para a Itália...',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _controller.setSugestao,
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? 'Digite uma sugestão' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_controller.enviarSugestao()) {
                        _textController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Sugestão enviada com sucesso! Obrigado!'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('ENVIAR SUGESTÃO'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}