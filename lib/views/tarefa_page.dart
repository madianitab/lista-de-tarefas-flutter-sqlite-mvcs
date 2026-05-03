import 'package:flutter/material.dart';
import '../controllers/tarefa_controller.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  final TarefaController _controller = TarefaController();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.carregarTarefas();
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas (To-Do)'),
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          if (_controller.carregando) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_controller.tarefas.isEmpty) {
            return const Center(
              child: Text('Nenhuma tarefa cadastrada. Adicione uma nova!'),
            );
          }

          return ListView.builder(
            itemCount: _controller.tarefas.length,
            itemBuilder: (context, index) {
              final tarefa = _controller.tarefas[index];
              return ListTile(
                title: Text(
                  tarefa.titulo,
                  style: TextStyle(
                    decoration: tarefa.concluida ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(tarefa.descricao),
                leading: Checkbox(
                  value: tarefa.concluida,
                  onChanged: (bool? value) {
                    _controller.alternarStatusTarefa(tarefa);
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _controller.deletarTarefa(tarefa.id!),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarDialogoNovaTarefa(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _mostrarDialogoNovaTarefa(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nova Tarefa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.adicionarTarefa(
                  _tituloController.text,
                  _descricaoController.text,
                );
                _tituloController.clear();
                _descricaoController.clear();
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}