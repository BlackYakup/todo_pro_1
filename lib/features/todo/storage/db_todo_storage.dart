import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo.dart';
import 'todo_storage.dart';

class DbTodoStorage implements TodoStorage {
  static const _databaseName = 'todo_pro.db';
  static const _databaseVersion = 1;
  static const _tableName = 'todos';

  Database? _database;

  Future<Database> get _db async {
    if (_database != null) {
      return _database!;
    }

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            isDone INTEGER NOT NULL
          )
        ''');
      },
    );

    return _database!;
  }

  @override
  Future<List<Todo>> loadTodos() async {
    final db = await _db;
    final rows = await db.query(_tableName, orderBy: 'id ASC');

    return rows.map(_todoFromRow).toList();
  }

  @override
  Future<List<Todo>> addTodo(Todo todo) async {
    final db = await _db;

    await db.insert(
      _tableName,
      _todoToRow(todo),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return loadTodos();
  }

  @override
  Future<List<Todo>> deleteTodo(int id) async {
    final db = await _db;

    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);

    return loadTodos();
  }

  @override
  Future<List<Todo>> updateTodo(Todo todo) async {
    final db = await _db;

    await db.update(
      _tableName,
      _todoToRow(todo),
      where: 'id = ?',
      whereArgs: [todo.id],
    );

    return loadTodos();
  }

  Map<String, Object?> _todoToRow(Todo todo) {
    return {'id': todo.id, 'title': todo.title, 'isDone': todo.isDone ? 1 : 0};
  }

  Todo _todoFromRow(Map<String, Object?> row) {
    return Todo(
      id: row['id'] as int,
      title: row['title'] as String,
      isDone: row['isDone'] == 1,
    );
  }
}
