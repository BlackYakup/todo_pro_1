import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_pro/features/todo/models/todo.dart';
import 'package:todo_pro/features/todo/storage/todo_storage.dart';

class DbTodoStorage implements TodoStorage {
  static const _databaseName = 'todo_pro.db';
  static const _databaseVersion = 1;
  static const _tableName = 'todos';

  static const _idColumn = 'id';
  static const _titleColumn = 'title';
  static const _isDoneColumn = 'isDone';

  Database? _database;

  Future<Database> get _db async {
    if (_database != null) {
      return _database!;
    }

    final databasePath = await getDatabasesPath();
    print('Database path: $databasePath');
    final path = join(databasePath, _databaseName);

    _database = await openDatabase(path, version: _databaseVersion, onCreate: _createDatabase);

    return _database!;
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        $_idColumn INTEGER PRIMARY KEY,
        $_titleColumn TEXT NOT NULL,
        $_isDoneColumn INTEGER NOT NULL
      )
    ''');
  }

  @override
  Future<List<Todo>> loadTodos() async {
    final db = await _db;
    final rows = await db.query(_tableName, orderBy: '$_idColumn ASC');

    return rows.map(_todoFromRow).toList();
  }

  @override
  Future<List<Todo>> addTodo(Todo todo) async {
    final db = await _db;

    await db.insert(_tableName, _todoToRow(todo), conflictAlgorithm: ConflictAlgorithm.replace);

    return loadTodos();
  }

  @override
  Future<List<Todo>> deleteTodo(int id) async {
    final db = await _db;

    await db.delete(_tableName, where: '$_idColumn = ?', whereArgs: [id]);

    return loadTodos();
  }

  @override
  Future<List<Todo>> updateTodo(Todo todo) async {
    final db = await _db;

    await db.update(_tableName, _todoToRow(todo), where: '$_idColumn = ?', whereArgs: [todo.id]);

    return loadTodos();
  }

  Map<String, Object?> _todoToRow(Todo todo) {
    return {_idColumn: todo.id, _titleColumn: todo.title, _isDoneColumn: todo.isDone ? 1 : 0};
  }

  Todo _todoFromRow(Map<String, Object?> row) {
    return Todo(id: row[_idColumn] as int, title: row[_titleColumn] as String, isDone: row[_isDoneColumn] == 1);
  }
}
