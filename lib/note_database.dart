import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import 'note_class.dart';

class NoteDatabase {
  // private constructor
  NoteDatabase._init();

  // Instance
  static NoteDatabase instance = NoteDatabase._init();

  // Database private
  Database? _database;

  // Database init

  // * Here Database will return database if it has a value
  // * Otherwise database will _initDB()
  Future<Database> get database async => instance._database ?? await _initDB();

  // * This function will called when _database has null value
  // * This function will create a new database (first time only)
  Future<Database> _initDB() async {
    final myPath = await getDatabasesPath();
    final path = "$myPath/notes.db";
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );

    _database = database;
    return database;
  }

  // TableName
  final String _tableName = "MyNewNote";

  // * _onCreate() method will define DataBase (Table) Header
  Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    await db.execute("""
    CREATE TABLE $_tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      desc TEXT NOT NULL,
      date TEXT NOT NULL,
      done BOOLEAN NOT NULL
    )
""");
  }

  // createData
  Future<int> createNote(Note note) async {
    debugPrint("createData : ${note.toJson()}");
    final db = await instance.database;
    final id = await db.insert(_tableName, note.toJson());
    debugPrint("createDataID : $id");
    return id;
  }

  // single note
  Future<Note?> singleNote(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> notes = await db.query(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );

    if (notes.isNotEmpty) {
      return Note.fromJson(notes.first);
    } else {
      return null;
    }
  }

  // ReadData
  Future<List<Note>> readNotes() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> notes = await db.query(
      _tableName,
    );

    final list = List<Note>.from(notes.map((e) => Note.fromJson(e)));
    return list;
  }

  // Update
  Future<int> updateNote(Note note) async {
    final db = await instance.database;
    debugPrint('updateData -> ${note.toJson()}');
    final id = await db.update(
      _tableName,
      note.toJson(),
      where: "id = ?",
      whereArgs: [note.id],
    );
    return id;
  }

  // Delete
  Future<int> deleteNote(int id) async {
    final db = await instance.database;
    final i = await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
    return i;
  }
}
