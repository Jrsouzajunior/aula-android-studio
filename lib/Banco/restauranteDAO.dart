
import 'package:aula1/Banco/database_helper.dart';

import 'package:aula1/restaurante.dart';

class RestauranteDAO{

  static Future<List<Restaurante>> listarTodos() async{
    final db = await DatabaseHelper.getDatabase();
    final resultado = await db?.query('tb_restaurante');
    
    return resultado!.map((mapa){
      return Restaurante(
        codigo: mapa['cd_restaurante'] as int,
        nome: mapa['nm_restaurante'] as String,
      );
    }).toList();
  }
}