import 'package:aula1/Banco/restauranteDAO.dart';
import 'package:aula1/Banco/usuarioDAO.dart';
import 'package:aula1/restaurante.dart';
import 'package:flutter/material.dart';
// Removi tela_cadastro e tela_login se não estão mais em uso
// import 'package:aula1/tela_cadastro.dart';
// import 'package:aula1/tela_login.dart';

class telaHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => telaHomeState();
}

class telaHomeState extends State<telaHome> {
  final nome = UsuarioDAO.usuarioLogado.nome;

  List<Restaurante> restaurantes = [];
  int _currentBannerPage = 0;

  // --- MOCK DATA PARA FILTROS COM IMAGENS (Usando URLs de bandeiras) ---
  final List<Map<String, dynamic>> cuisines = [
    {'name': 'Mexicana', 'image_url': 'https://flagcdn.com/w80/mx.png'},
    {'name': 'Árabe', 'image_url': 'https://flagcdn.com/w80/sa.png'},
    {'name': 'Francesa', 'image_url': 'https://flagcdn.com/w80/fr.png'},
    {'name': 'Portuguesa', 'image_url': 'https://flagcdn.com/w80/pt.png'},
    {'name': 'Italiana', 'image_url': 'https://flagcdn.com/w80/it.png'},
    {'name': 'Japonesa', 'image_url': 'https://flagcdn.com/w80/jp.png'},
  ];

  // --- MOCK DATA PARA BANNERS PROMOCIONAIS ---
  final List<Map<String, dynamic>> banners = [
    {
      'title': 'OFERTA ESPECIAL',
      'subtitle': 'A partir de R\$ 4,99',
      'color': Colors.redAccent.shade400
    },
    {
      'title': 'Entrega GRÁTIS',
      'subtitle': 'Em restaurantes selecionados!',
      'color': Colors.deepPurple.shade400
    },
    {
      'title': 'Sua 1ª Compra',
      'subtitle': '50% OFF no seu primeiro pedido',
      'color': Colors.orange.shade400
    },
  ];

  // Função para carregar os restaurantes do Banco
  Future<void> carregarRestaurantes() async {
    final lista = await RestauranteDAO.listarTodos();
    setState(() {
      restaurantes = lista;
    });
  }

  @override
  void initState() {
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
    // Lógica de navegação
  }

  // Widget para os indicadores de página ("bolinhas de marcação")
  Widget _buildPageIndicator(int index, Color primaryColor) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: _currentBannerPage == index ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color:
            _currentBannerPage == index ? primaryColor : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }

  // --- WIDGET AUXILIAR PARA O CARD DE RESTAURANTE DO CARROSSEL ---
  Widget _buildRestauranteCarouselCard(
      Restaurante restaurante, Color textColor, Color primaryColor) {
    final String restaurantLogoAsset =
        restaurante.logopath ?? 'assets/logos/default_placeholder.png';

    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.asset(
              restaurantLogoAsset,
              height: 80,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print("Erro ao carregar asset: $restaurantLogoAsset - $error");
                return Container(
                  height: 80,
                  color: primaryColor.withOpacity(0.1),
                  child: Center(
                    child:
                        Icon(Icons.broken_image, size: 40, color: Colors.red),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              restaurante.nome ?? 'Restaurante Sem Nome',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.green;
    final Color scaffoldBackgroundColor =
        isDarkMode ? Colors.black87 : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(toolbarHeight: 0, backgroundColor: primaryColor),

      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              // 1. CABEÇALHO (HEADER)
              Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- LINHA SUPERIOR DO CABEÇALHO ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Ícone do Menu Sanduíche
                        IconButton(
                          icon: Icon(Icons.menu, color: Colors.white, size: 28),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                        // Logo do Aplicativo e Slogan
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/logo.png', // Caminho do logo do app
                                height: 40,
                                errorBuilder: (context, error, stackTrace) {
                                  print(
                                      "Erro ao carregar logo do app: assets/logo.png - $error");
                                  return Text('FoodConnect',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold));
                                },
                              ),
                              SizedBox(width: 10),
                              // Slogan do Serviço (anteriormente "Online")
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  // Mantive a cor verde para o fundo do slogan, mas você pode ajustar
                                  color: Colors.green.shade700,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Sua conexão com sabor', // <-- AQUI É O NOVO TEXTO DO SLOGAN!
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Sino de Notificação
                        IconButton(
                          icon: Icon(Icons.notifications_none,
                              color: Colors.white, size: 28),
                          onPressed: () {
                            // Ação do sino
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Barra de Pesquisa (mantida)
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Icon(Icons.search, color: Colors.grey),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Buscar restaurantes ou pratos',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Icon(Icons.filter_list, color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 2. TÍTULO DO FILTRO DE CULINÁRIA (restante do código abaixo permanece o mesmo)
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 16.0),
                child: Text(
                  'Qual a sua culinária favorita?',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
              ),

              // 3. FILTROS HORIZONTAIS COM BANDEIRAS
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  itemCount: cuisines.length,
                  itemBuilder: (context, index) {
                    final cuisine = cuisines[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40.0),
                              child: Image.network(
                                cuisine['image_url'] as String,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: primaryColor.withOpacity(0.1),
                                    child: Icon(Icons.flag,
                                        size: 30, color: primaryColor),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            cuisine['name'] as String,
                            style: TextStyle(fontSize: 12, color: textColor),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // 4. TÍTULO DO BANNER
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0),
                child: Text(
                  'Promoções do Dia',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
              ),

              // 5. BANNER PROMOCIONAL
              Container(
                height: 180,
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: PageView.builder(
                  itemCount: banners.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentBannerPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final banner = banners[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          color: banner['color'] as Color,
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                banner['title'] as String,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text(
                                banner['subtitle'] as String,
                                style: TextStyle(
                                    color: Colors.yellowAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text('Aproveite Já',
                                    style: TextStyle(
                                        color: banner['color'] as Color,
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Indicadores do Banner
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: banners.asMap().entries.map((entry) {
                    return _buildPageIndicator(entry.key, primaryColor);
                  }).toList(),
                ),
              ),

              // 6. TÍTULO DO CARROSSEL DE ÚLTIMOS RESTAURANTES
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 8.0),
                child: Text(
                  'Últimos Restaurantes',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
              ),
            ]),
          ),

          // --- CARROSSEL DE CARDS DE RESTAURANTES ---
          SliverToBoxAdapter(
            child: Container(
              height: 160,
              child: restaurantes.isEmpty
                  ? Center(
                      child: Text('Carregando restaurantes...',
                          style: TextStyle(color: textColor.withOpacity(0.7))))
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      itemCount: restaurantes.length,
                      itemBuilder: (context, index) {
                        final restaurante = restaurantes[index];
                        return _buildRestauranteCarouselCard(
                            restaurante, textColor, primaryColor);
                      },
                    ),
            ),
          ),
        ],
      ),

      // --- BARRA DE NAVEGAÇÃO INFERIOR ---
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: scaffoldBackgroundColor,
        onTap: onItemTapped,
      ),
    );
  }
}
