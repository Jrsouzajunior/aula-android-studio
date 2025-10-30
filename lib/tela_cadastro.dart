
import 'package:aula1/exemplo.dart';
import 'package:aula1/tela_home.dart';
import 'package:aula1/tela_login.dart';
import 'package:flutter/material.dart';

class telaCadastro extends StatefulWidget{
  @override
  State<telaCadastro> createState() => telaCadastroState();
  }

class telaCadastroState extends State<telaCadastro>{
  final formKey = GlobalKey<FormState>();
  String nome = '';
  String email = '';
  String telefone = '';
  String login = '';
  String senha = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro'),
      backgroundColor: Colors.greenAccent,),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.abc),
                labelText: 'Nome',
                border: OutlineInputBorder()
              ),
              validator: (nome) {
                if (nome == null || nome.isEmpty) {
                  return 'Por favor, insira seu nome.';
                }
                return null;
              },
              onSaved: (nome) {
                nome = nome ?? '';
              },
            ),
            SizedBox(height: 15),

            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'E-mail',
                border: OutlineInputBorder()
              ),
              validator: (email) {
                if (email == null || !email.contains('@')) {
                  return 'E-mail inválido!';
                }
                return null;
              },
              onSaved: (email) {
                email = email ?? '';
              },
            ),
            SizedBox(height: 15),
            
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: 'Telefone',
                border: OutlineInputBorder()
              ),
              validator: (telefone) {
                if (telefone == null || telefone.isEmpty) {
                  return 'Informe o telefone!';
                }
                return null;
              },
              onSaved: (telefone) {
                telefone = telefone ?? '';
              },
            ),
            SizedBox(height: 15),

            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'Login',
                border: OutlineInputBorder()
              ),
              validator: (login) {
                if (login == null || login.length < 5) {
                  return 'O login deve ter pelo menos 5 caracteres!';
                }
                return null;
              },
              onSaved: (login) {
                login = login ?? '';
              },
            ),
            SizedBox(height: 15),

            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Senha',
                border: OutlineInputBorder()
              ),
              validator: (senha) {
                if (senha == null || senha.length < 8) {
                  return 'A senha deve ter pelo menos 8 caracteres!';
                }
                return null;
              },
              onSaved: (senha) {
                senha = senha ?? '';
              },
            ),
            SizedBox(height: 30),

            ElevatedButton(onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Usuário $nome cadastrado com sucesso!')),
                );

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => telaLogin())
              );
              }
            },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  'Cadastrar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
            ),
          ],
        ),
      ),
    );
  }
}