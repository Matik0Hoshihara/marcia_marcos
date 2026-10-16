import 'package:flutter/material.dart';
import '../controller/recuperar_senha_controller.dart';

class RecuperarSenhaView extends StatefulWidget {
  const RecuperarSenhaView({super.key});

  @override
  State<RecuperarSenhaView> createState() => _RecuperarSenhaViewState();
}

class _RecuperarSenhaViewState extends State<RecuperarSenhaView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = RecuperarSenhaController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RECUPERAR SENHA'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Esqueceu sua senha?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Informe o seu e-mail cadastrado para receber as instruções de redefinição de senha.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                const SizedBox(height: 32),

                // CAMPO PARA INFORMAÇÃO DO E-MAIL (Requisito RF003)
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-MAIL',
                    hintText: 'exemplo@dominio.com',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _controller.setEmail,
                  validator: (value) {
                    // Item 1: Verifica se o campo foi preenchido
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, informe o seu e-mail.';
                    }
                    // Item 2: Valida se o formato do e-mail é válido
                    if (!value.contains('@') || !value.split('@').last.contains('.')) {
                      return 'Informe um e-mail com formato válido (ex: usuario@dominio.com).';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                //SOLICITAR A RECUPERAÇÃO
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Item 3: Caso o e-mail seja válido, inicia o processo e envia instruções
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Instruções de redefinição enviadas para o seu e-mail!'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 4),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('SOLICITAR RECUPERAÇÃO'),
                ),
                const SizedBox(height: 16),

                //VOLTAR P/ LOGIN
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('voltar ao login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}