

import 'package:aula1/Banco/usuarioDAO.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aula1/tela_cadastro.dart';

class telaHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => telaHomeState();
  }

class telaHomeState extends State<telaHome>{
  final nome = UsuarioDAO.usuarioLogado.nome;

  bool isDarkMode = false;
  int selectedIndex = 0;

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color scaffoldBackgroundColor = isDarkMode ? Colors.black87 : Colors.white;
    final Color appBarColor = isDarkMode ? Colors.grey[900]! : Colors.greenAccent;
    final Color appBarContentColor = isDarkMode ? Colors.white : Colors.black;
    final Color switchIconColor = isDarkMode ? Colors.amber : Colors.black;
    final Color primaryColor = Colors.green;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
            'Olá, $nome!',
        style: TextStyle(color: appBarContentColor),
      ),
        backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        actions: [
          Icon(Icons.construction_rounded),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Icon(Icons.light_mode, color: switchIconColor),
              Switch(
                  value: isDarkMode,
                  onChanged: toggleTheme,
                  activeColor: Colors.yellow,
                  inactiveThumbColor: Colors.grey,
              ),
              Icon(Icons.dark_mode, color: appBarContentColor),
            ],
          ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Tela Home - Modo ${isDarkMode ? 'Escuro' : 'Claro'}',
          style: TextStyle(fontSize: 20, color: appBarContentColor),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.person),
            label: 'Perfil',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Carrinho',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configurações',
            ),
          ],
        currentIndex: selectedIndex,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          backgroundColor: appBarColor,
          onTap: onItemTapped,
      ),
    );
  }
}