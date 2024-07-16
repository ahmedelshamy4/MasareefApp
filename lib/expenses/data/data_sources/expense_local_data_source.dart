import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseLocalDataSource {
  ExpenseLocalDataSource._internal();

  static final ExpenseLocalDataSource _instance =
      ExpenseLocalDataSource._internal();

  factory ExpenseLocalDataSource() {
    return _instance;
  }

  static Database? _database;

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "expenses.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          """
          CREATE TABLE IF NOT EXISTS expenses (
            id INTEGER PRIMARY KEY,
            title  TEXT NOT NULL,
            amount REAL NOT NULL,
            date TEXT NOT NULL
          );
          """,
        );
      },
    );
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }
}
