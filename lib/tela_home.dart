

import 'package:aula1/Banco/restauranteDAO.dart';
import 'package:aula1/Banco/usuarioDAO.dart';
import 'package:aula1/restaurante.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aula1/tela_cadastro.dart';

class telaHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => telaHomeState();
  }

class telaHomeState extends State<telaHome>{
  final nome = UsuarioDAO.usuarioLogado.nome;

  List<Restaurante> restaurantes = [];

  Future<void> carregarRestaurantes() async{
    final lista = await RestauranteDAO.listarTodos();
    setState(() {
      restaurantes = lista;
    });
  }

  void initState(){
    super.initState();
    carregarRestaurantes();
  }

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
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: ImagensSlider()),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: restaurantes.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      final restaurante = restaurantes[index];
                      return ElevatedButton(
                          onPressed: (){},
                          child: Text(restaurante.nome ?? 'Sem nome')
                      );
                    },
                ),
              ),
            ],
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

class ImagensSlider extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        for (final color in Colors.primaries)
          Container(width: 160, color: color),
      ],
    );
  }
}