import 'package:flutter/material.dart';
import '../controller/login_controller.dart';
import 'cadastrar_usuario_view.dart';
import 'recuperar_senha_view.dart';
import '../core/app_routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'LOGIN',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              
              //VALIDAÇÃO DE FORMATO DO E-MAIL
              TextFormField(
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

              //SENHA
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'SENHA',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onChanged: _controller.setSenha,
                validator: (value) => value == null || value.isEmpty ? 'Informe a senha' : null,
              ),

              // RECUPERAR SENHA
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RecuperarSenhaView()),
                    );
                  },
                  child: const Text('recuperar senha'),
                ),
              ),
              const SizedBox(height: 24),

              // BOTÃO ENTRAR
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Bem-vindo!'), duration: Duration(seconds: 2)),
                    );
                    Navigator.pushReplacementNamed(context, AppRoutes.principal);
                  }
                },
                child: const Text('ENTRAR'),
              ),

              // BOTÃO CADASTRAR USUÁRIO
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CadastrarUsuarioView()),
                  );
                },
                child: const Text('cadastrar usuário'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}