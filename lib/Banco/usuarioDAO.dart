
import 'package:aula1/Banco/database_helper.dart';
import 'package:aula1/Usuario.dart';

class UsuarioDAO {

  static Usuario usuarioLogado = Usuario();

  static Future<bool> autenticar(String? usuario, String? senha) async{

    final db = await DatabaseHelper.getDatabase();

    final resultado = await db!.query('tb_usuario',
      where: 'nm_login = ? AND ds_senha = ?',
      whereArgs: [usuario, senha]
    );

    usuarioLogado.codigo = resultado.first['cd_usuario'] as int;
    usuarioLogado.nome = resultado.first['nm_usuario'] as String;

    return resultado.isNotEmpty;

  }
}
