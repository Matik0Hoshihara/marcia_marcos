import 'package:flutter/material.dart';
import '../controller/cadastrar_usuario_controller.dart';

class CadastrarUsuarioView extends StatefulWidget {
  const CadastrarUsuarioView({super.key});

  @override
  State<CadastrarUsuarioView> createState() => _CadastrarUsuarioViewState();
}

class _CadastrarUsuarioViewState extends State<CadastrarUsuarioView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = CadastrarUsuarioController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'CADASTRAR',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 28),

                  //NOME
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'NOME',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _controller.setNome,
                    validator: (value) =>
                        value == null || value.trim().isEmpty ? 'Informe o seu nome' : null,
                  ),
                  const SizedBox(height: 16),

                  //E-MAIL
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-MAIL',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _controller.setEmail,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe o e-mail';
                      }
                      if (!value.contains('@') || !value.split('@').last.contains('.')) {
                        return 'Informe um e-mail válido (ex: usuario@email.com)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  //TELEFONE
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'TELEFONE',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _controller.setTelefone,
                    validator: (value) =>
                        value == null || value.trim().isEmpty ? 'Informe o seu telefone' : null,
                  ),
                  const SizedBox(height: 16),

                  //SENHA
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'SENHA',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    onChanged: _controller.setSenha,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe a senha';
                      }
                      if (value.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  //CONFIRMAR SENHA
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'CONFIRMAR SENHA',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    onChanged: _controller.setConfirmarSenha,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirme a sua senha';
                      }
                      if (value != _controller.senha) {
                        return 'As senhas não coincidem';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 28),

                  // BOTÃO CADASTRAR
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Usuário cadastrado com sucesso!')),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('CADASTRAR USUÁRIO'),
                  ),
                  const SizedBox(height: 12),

                  // BOTÃO VOLTAR P/ LOGIN
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('voltar ao login'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}