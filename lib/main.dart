import 'dart:io';
import 'package:flutter/material.dart';
//instalar as dependências
//flutter pub add sqflite_common_ffi
//flutter pub get
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'views/tarefa_page.dart';

void main() async {
  // Garante que os widgets do Flutter estejam inicializados antes de rodar qualquer código nativo
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Inicializa o FFI para suportar SQLite no Desktop
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const TarefaPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}