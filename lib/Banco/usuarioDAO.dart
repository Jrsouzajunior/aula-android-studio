import 'package:aula1/Banco/database_helper.dart';
import 'package:aula1/Usuario.dart';

class UsuarioDAO {
  // Armazena o usuário logado atualmente (ou null se deslogado)
  static Usuario usuarioLogado = Usuario();

  // --- Função de Autenticação (CORRIGIDA) ---
  static Future<bool> autenticar(String? usuario, String? senha) async {
    final db = await DatabaseHelper.getDatabase();

    final resultado = await db!.query('tb_usuario',
        where: 'nm_login = ? AND ds_senha = ?', whereArgs: [usuario, senha]);

    // CORREÇÃO: Verifica se encontrou um usuário antes de tentar acessar resultado.first
    if (resultado.isNotEmpty) {
      // Se a lista NÃO está vazia, o login foi bem-sucedido.
      // Agora, é seguro atribuir os dados do primeiro (e único) resultado.
      usuarioLogado.codigo = resultado.first['cd_usuario'] as int;
      usuarioLogado.nome = resultado.first['nm_usuario'] as String;
      return true;
    }

    // Se a lista está vazia, o login falhou.
    return false;
  }

  // A função cadastrar (que adicionei anteriormente) deve estar aqui também se você a incluiu
  // ... (manter a função cadastrar se ela foi adicionada)
}
