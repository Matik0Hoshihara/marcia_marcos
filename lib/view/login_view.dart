import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart'; // IMPORTAÇÃO DO GETIT
import '../controller/auth_controller.dart'; // IMPORTAÇÃO DO AUTH CONTROLLER
import '../controller/login_controller.dart';
import '../controller/usuario_controller.dart';
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  // LOGO
                  Column(
                    children: [
                      // AVIÃO
                      const Icon(
                        Icons.flight_takeoff,
                        size: 64,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 8),
 
                      // TÍTULO
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'M&M',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Viagens',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w300,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
 
                  const Text(
                    'LOGIN',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),
 
                  // E-MAIL
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
 
                  // SENHA
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
 
                  // ENTRAR 
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(child: CircularProgressIndicator()),
                        );
 
                        final auth = GetIt.I<AuthController>();
                        final erro = await auth.login(_controller.email, _controller.senha);
 
                        if (mounted) {
                          Navigator.pop(context);
                        }

                        if (erro == null) {

                          UsuarioController.instance.definirEmail(_controller.email);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Bem-vindo!'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Navigator.pushReplacementNamed(context, AppRoutes.principal);
                          }
                        } else {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Erro ao entrar: $erro'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      }
                    },
                    child: const Text('ENTRAR'),
                  ),
 
                  // CADASTRAR USUÁRIO
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
        ),
      ),
    );
  }
}