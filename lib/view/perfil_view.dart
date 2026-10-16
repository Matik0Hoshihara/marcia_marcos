import 'package:flutter/material.dart';
import '../controller/usuario_controller.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeTextController;

  @override
  void initState() {
    super.initState();
    
    _nomeTextController = TextEditingController(
      text: UsuarioController.instance.nome,
    );
  }

  @override
  void dispose() {
    _nomeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usuarioLogado = UsuarioController.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MEU PERFIL'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Icon(Icons.account_circle, size: 80, color: Colors.blue),
                const SizedBox(height: 28),

                //NOME DO USUÁRIO
                TextFormField(
                  controller: _nomeTextController,
                  decoration: const InputDecoration(
                    labelText: 'NOME DO USUÁRIO',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, informe o seu nome.';
                    }
                    if (value.trim().length < 3) {
                      return 'O nome deve conter no mínimo 3 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                //E-MAIL
                TextFormField(
                  initialValue: usuarioLogado.email,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'E-MAIL',
                    border: OutlineInputBorder(),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 28),

                //SALVAR ALTERAÇÕES
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Salva permanentemente o nome no UsuarioController
                      usuarioLogado.atualizarNome(_nomeTextController.text);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Perfil atualizado com sucesso!'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: const Text('SALVAR ALTERAÇÕES'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}