import 'package:sqflite/sqflite.dart';

class NoteDatabase {
  // private constructor
  NoteDatabase._init();

  // Instance
  static NoteDatabase instance = NoteDatabase._init();

  // Database private
  Database? _database;

  // Database init
  Future<Database> get database async => instance._database ?? await _initDB();

  Future<Database> _initDB() async {
    final myPath = await getDatabasesPath();
    final path = "$myPath/note.db";
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // TableName
  final String _tableName = "notes";

  Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    db.execute("""
    CREATE TABLE $_tableName (

      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name 
      contact 
      desc 
      date 
      is_impotent

    )
""");
  }
}
