import 'package:aula1/Banco/database_helper.dart';
import 'package:aula1/restaurante.dart';

class RestauranteDAO {
  // Lista MOCKADA que será usada SOMENTE para mapear o nome do restaurante ao caminho do logo local.
  static final List<Restaurante> _mockedLogoPaths = [
    Restaurante(
        codigo: 1,
        nome: 'Sabor Italiano',
        logopath: 'assets/logos/sabor_italiano.png'),
    Restaurante(
        codigo: 2,
        nome: 'Tokyo Sushi',
        logopath: 'assets/logos/tokyo_sushi.png'),
    Restaurante(
        codigo: 3,
        nome: 'Brasil Sabor',
        logopath: 'assets/logos/brasil_sabor.png'),
    Restaurante(
        codigo: 4,
        nome: 'Mexican Fiesta',
        logopath: 'assets/logos/mexican_fiesta.png'),
    Restaurante(
        codigo: 5, nome: 'China Box', logopath: 'assets/logos/china_box.png'),
    Restaurante(
        codigo: 6, nome: 'Veg Life', logopath: 'assets/logos/veg_life.png'),
    Restaurante(
        codigo: 7,
        nome: 'Burger Town',
        logopath: 'assets/logos/burger_town.png'),
    Restaurante(
        codigo: 8, nome: 'Maré Alta', logopath: 'assets/logos/mare_alta.png'),
    Restaurante(
        codigo: 9,
        nome: 'Sabores da Índia',
        logopath: 'assets/logos/sabores_da_india.png'),
    Restaurante(
        codigo: 10,
        nome: 'Delícias Árabes',
        logopath: 'assets/logos/delicias_arabes.png'),
  ];

  // Cria um mapa de consulta rápida: Nome do Restaurante -> Caminho do Logo
  static final Map<String, String> _logoPathLookup = Map.fromIterable(
    _mockedLogoPaths,
    key: (rest) => rest.nome!, // A chave é o nome exato do restaurante
    value: (rest) => rest.logopath!, // O valor é o caminho do asset
  );

  static Future<List<Restaurante>> listarTodos() async {
    final db = await DatabaseHelper.getDatabase();
    final resultado = await db?.query('tb_restaurante');

    // Se o banco estiver vazio, pode retornar a lista mockada completa como fallback
    if (resultado == null || resultado.isEmpty) {
      return _mockedLogoPaths;
    }

    return resultado.map((mapa) {
      String nomeRestaurante = mapa['nm_restaurante'] as String;

      // Busca o caminho do logo no mapa de consulta, usando o nome do banco
      String? caminhoLogo = _logoPathLookup[nomeRestaurante];

      return Restaurante(
        codigo: mapa['cd_restaurante'] as int,
        nome: nomeRestaurante,
        // CORREÇÃO: O logopath agora é preenchido com o caminho correto do asset!
        logopath: caminhoLogo,
      );
    }).toList();
  }
}
