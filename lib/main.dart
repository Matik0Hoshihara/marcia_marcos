import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview_plus/device_preview_plus.dart'; 

import 'core/app_routes.dart';
import 'view/login_view.dart';
import 'view/cadastrar_usuario_view.dart';
import 'view/recuperar_senha_view.dart';
import 'view/principal_view.dart';
import 'view/perfil_view.dart';
import 'view/sobre_view.dart';
import 'view/sugestoes_view.dart';
import 'view/japao_view.dart';
import 'view/portugal_view.dart';
import 'view/espanha_view.dart';
import 'view/brasil_view.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MeuApp(),
    ),
  );
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      
      title: 'Viagens 2026',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginView(),
        AppRoutes.cadastrarUsuario: (context) => const CadastrarUsuarioView(),
        AppRoutes.recuperarSenha: (context) => const RecuperarSenhaView(),
        AppRoutes.principal: (context) => const PrincipalView(),
        AppRoutes.perfil: (context) => const PerfilView(),
        AppRoutes.sobre: (context) => const SobreView(),
        AppRoutes.sugestoes: (context) => const SugestoesView(),
        AppRoutes.japao: (context) => const JapaoView(),
        AppRoutes.portugal: (context) => const PortugalView(),
        AppRoutes.espanha: (context) => const EspanhaView(),
        AppRoutes.brasil: (context) => const BrasilView(),
      },
    );
  }
}