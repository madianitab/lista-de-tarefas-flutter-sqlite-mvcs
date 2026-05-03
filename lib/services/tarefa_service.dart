// lib/services/tarefa_service.dart
import '../models/tarefa.dart';
import 'database_service.dart';

class TarefaService {
  final DatabaseService _dbService = DatabaseService.instance;

  Future<List<Tarefa>> obterTarefas() async {
    return await _dbService.lerTodasAsTarefas();
  }

  Future<void> adicionarTarefa(String titulo, String descricao) async {
    final novaTarefa = Tarefa(titulo: titulo, descricao: descricao);
    await _dbService.inserir(novaTarefa);
  }

  Future<void> alternarStatusTarefa(Tarefa tarefa) async {
    tarefa.concluida = !tarefa.concluida;
    await _dbService.atualizar(tarefa);
  }

  Future<void> deletarTarefa(int id) async {
    await _dbService.deletar(id);
  }
}