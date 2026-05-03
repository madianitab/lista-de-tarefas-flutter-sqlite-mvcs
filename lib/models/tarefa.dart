class Tarefa {
  int? id; //pode ser nulo
  String titulo;
  String descricao;
  bool concluida;

  Tarefa({
    this.id,
    required this.titulo,
    required this.descricao,
    this.concluida = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'concluida': concluida ? 1 : 0, // SQLite armazena booleanos como 0 ou 1
    };
  }

  factory Tarefa.fromMap(Map<String, dynamic> mapa) {
    return Tarefa(
      id: mapa['id'],
      titulo: mapa['titulo'],
      descricao: mapa['descricao'],
      concluida: mapa['concluida'] == 1,
    );
  }
}