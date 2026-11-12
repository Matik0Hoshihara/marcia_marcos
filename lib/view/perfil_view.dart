import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
 
class PerfilView extends StatefulWidget {
  const PerfilView({super.key});
 
  @override
  State<PerfilView> createState() => _PerfilViewState();
}
 
class _PerfilViewState extends State<PerfilView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  bool _isLoading = true;
  String _telefone = '';
 
  @override
  void initState() {
    super.initState();
    _carregarDadosPerfil();
  }
 
  // Busca os dados atuais do Firestore uma única vez para preencher o formulário
  Future<void> _carregarDadosPerfil() async {
    if (user != null) {
      try {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user!.uid)
            .get();
 
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          setState(() {
            _nomeController.text = data['nome'] ?? '';
            _telefone = data['telefone'] ?? 'Não informado';
            _isLoading = false;
          });
        }
      } catch (e) {
        setState(() => _isLoading = false);
        _mostrarMensagem('Erro ao carregar dados do perfil.', erro: true);
      }
    }
  }
 
  // Valida e atualiza o novo nome no banco de dados 
  Future<void> _salvarAlteracoes() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user!.uid)
            .update({
              'nome': _nomeController.text.trim(),
            });
        _mostrarMensagem('Perfil atualizado com sucesso!');
      } catch (e) {
        _mostrarMensagem('Erro ao atualizar o perfil.', erro: true);
      }
    }
  }
 
  void _mostrarMensagem(String texto, {bool erro = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(texto),
        backgroundColor: erro ? Colors.red : Colors.green,
      ),
    );
  }
 
  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Meu Perfil')),
        body: const Center(child: Text('Usuário não autenticado.')),
      );
    }
 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    const SizedBox(height: 32),
                    // CAMPO NOME 
                    TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do Usuário',
                        prefixIcon: Icon(Icons.badge),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'O nome não pode ficar vazio.';
                        }
                        if (value.trim().length < 3) {
                          return 'O nome deve ter no mínimo 3 caracteres.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
 
                    // CAMPO E-MAIL 
                    TextFormField(
                      initialValue: user!.email ?? 'Não informado',
                      readOnly: true, // Bloqueia a edição
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.black12, 
                      ),
                    ),
                    const SizedBox(height: 16),
 
                    // CAMPO TELEFONE 
                    TextFormField(
                      initialValue: _telefone,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Telefone',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.black12,
                      ),
                    ),
                    const SizedBox(height: 32),
 
                    // BOTÃO SALVAR 
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _salvarAlteracoes,
                        icon: const Icon(Icons.save),
                        label: const Text(
                          'Salvar Alterações',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}