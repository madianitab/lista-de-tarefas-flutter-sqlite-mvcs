import 'package:flutter/material.dart';
import '../models/tarefa.dart';
import '../services/tarefa_service.dart';

class TarefaController extends ChangeNotifier {
  final TarefaService _tarefaService = TarefaService();
  
  List<Tarefa> _tarefas = [];
  List<Tarefa> get tarefas => _tarefas;

  bool _carregando = false;
  bool get carregando => _carregando;

  Future<void> carregarTarefas() async {
    _carregando = true;
    notifyListeners();

    _tarefas = await _tarefaService.obterTarefas();

    _carregando = false;
    notifyListeners();
  }

  Future<void> adicionarTarefa(String titulo, String descricao) async {
    if (titulo.trim().isEmpty) return;
    await _tarefaService.adicionarTarefa(titulo, descricao);
    await carregarTarefas();
  }

  Future<void> alternarStatusTarefa(Tarefa tarefa) async {
    await _tarefaService.alternarStatusTarefa(tarefa);
    await carregarTarefas();
  }

  Future<void> deletarTarefa(int id) async {
    await _tarefaService.deletarTarefa(id);
    await carregarTarefas();
  }
}