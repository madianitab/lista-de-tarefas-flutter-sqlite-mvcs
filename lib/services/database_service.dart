// lib/services/database_service.dart

//instalar as dependências
//flutter pub add sqflite
//flutter pub add path
//flutter pub get
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/tarefa.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database; //indica que pode receber null (deixa de ser Null Safety)

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tarefas.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE tarefas (
        id $idType,
        titulo $textType,
        descricao $textType,
        concluida $intType
      )
    ''');
  }

  Future<int> inserir(Tarefa tarefa) async {
    final db = await instance.database; //Conexão com o banco
    return await db.insert('tarefas', tarefa.toMap());
  }

  Future<List<Tarefa>> lerTodasAsTarefas() async {
    final db = await instance.database;
    final resultado = await db.query('tarefas', orderBy: 'id DESC');
    return resultado.map((json) => Tarefa.fromMap(json)).toList();
  }

  Future<int> atualizar(Tarefa tarefa) async {
    final db = await instance.database;
    return await db.update(
      'tarefas',
      tarefa.toMap(),
      where: 'id = ?',
      whereArgs: [tarefa.id],
    );
  }

  Future<int> deletar(int id) async {
    final db = await instance.database;
    return await db.delete(
      'tarefas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}