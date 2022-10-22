import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflit_database/Models/Note.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper databaseHelper;
  static Database _database;

  String noteTable = "note_table";
  String colID = "id";
  String colTitle = "title";
  String colDesc = "description";
  String colDate = "date";
  String colPriority = "priority";

  DatabaseHelper.createInstance();

  factory DatabaseHelper() {
    if (databaseHelper == null) {
      databaseHelper = DatabaseHelper.createInstance();
    }
    return databaseHelper;
  }

  void createDB(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($colID INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDesc TEXT, $colDate TEXT, $colPriority INTEGER)');
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getExternalStorageDirectory();
    String path = directory.path + "note.db";

    var noteDatabase = await openDatabase(path, version: 1, onCreate: createDB);
    return noteDatabase;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  // Fetch notes
  Future<List<Map<String, dynamic>>> _getNoteMapList() async {
    Database db = await this.database;

    var result = db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  Future<List<Note>> getNoteList() async {
    var getNoteMapList = await _getNoteMapList();
    List<Note> notes = List<Note>();
    int count = getNoteMapList.length;

    for (int i = 0; i<count; i++) {
      notes.add(Note.fromMap(getNoteMapList[i]));
    }

    return notes;
  }

  // Insert notes
  Future<int> insertNote(Note note) async {
    Database db = await this.database;

    var result = db.insert(noteTable, note.toMap());
    return result;
  }

  // Update notes
  Future<int> updateNote(Note note) async {
    Database db = await this.database;

    print("----------- ${note.getTitle} ---------");
    print("----------- ${note.getID} ---------");

    var result = db.update(noteTable, note.toMap(),
        where: '$colID = ?', whereArgs: [note.id]);
    return result;
  }

  // Delete notes
  Future<int> deleteNote(int id) async {
    Database db = await this.database;
    var result = db.delete(noteTable, where: '$colID = $id');
    return result;
  }

}
