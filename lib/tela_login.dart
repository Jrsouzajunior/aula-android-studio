import 'package:aula1/Banco/usuarioDAO.dart';
import 'package:aula1/exemplo.dart';
import 'package:aula1/tela_cadastro.dart';
import 'package:aula1/tela_home.dart';
import 'package:flutter/material.dart';

class telaLogin extends StatefulWidget {
  @override
  State<telaLogin> createState() => telaLoginState();
}

class telaLoginState extends State<telaLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 1. CAPTURA AS DIMENSÕES DA TELA
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = AppBar().preferredSize.height;
    final topPadding = MediaQuery.of(context).padding.top;

    // Calcula a altura mínima necessária para o Container verde preencher TUDO.
    final minBodyHeight = screenHeight - appBarHeight - topPadding;

    return Scaffold(
      // Evita que o teclado cause o problema do fundo branco
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Meu Ifood'),
        backgroundColor: Colors.greenAccent,
      ),

      // Envolve tudo em SingleChildScrollView
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.green,
          // *** CORREÇÃO: Garante que a altura mínima seja a altura da tela ***
          constraints: BoxConstraints(minHeight: minBodyHeight),

          child: Column(
            // Centraliza o conteúdo verticalmente
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 200,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Bem vindo!',
                style: TextStyle(color: Colors.white, fontSize: 30),
                textDirection: TextDirection.ltr,
              ),
              SizedBox(
                height: 40,
              ),
              // --- CAMPO E-MAIL ---
              SizedBox(
                width: 250,
                child: TextFormField(
                  controller: emailController,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.white70),
                    labelText: 'E-mail',
                    // Estilização para bordas ficarem visíveis
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.yellowAccent, width: 2)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // --- CAMPO SENHA ---
              SizedBox(
                width: 250,
                child: TextFormField(
                  controller: senhaController,
                  obscureText: true,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.white70),
                    labelText: 'Senha',
                    // Estilização para bordas ficarem visíveis
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.yellowAccent, width: 2)),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // --- BOTÃO ENTRAR ---
              ElevatedButton(
                onPressed: () async {
                  final sucesso = await UsuarioDAO.autenticar(
                      emailController.text, senhaController.text);

                  if (sucesso) {
                    // Usando pushReplacement para ir para a Home e não permitir voltar para o Login
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => telaHome()));
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Erro de Login'),
                          content: const Text(
                              'E-mail e/ou senha inválido. Por favor, tente novamente.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  ' ENTRAR ',
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // --- BOTÃO CADASTRE-SE ---
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => telaCadastro()));
                },
                child: Text.rich(
                  TextSpan(
                    text: 'Não tem conta? ',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Cadastre-se! Clique aqui',
                        style: TextStyle(
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
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
