import 'package:flutter/material.dart';
import '../controller/perfil_controller.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = PerfilController();

  @override
  Widget build(BuildContext context) {
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
                  initialValue: _controller.nome,
                  decoration: const InputDecoration(
                    labelText: 'NOME DO USUÁRIO',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _controller.setNome,
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
                  initialValue: _controller.email,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'E-MAIL',
                    border: OutlineInputBorder(),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 28),

                // BOTÃO SALVAR 
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
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