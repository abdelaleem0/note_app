import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:note_app/notes_app/presentation/utils/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDataBase {
  SqlDataBase._();

  static final instance = SqlDataBase._();
  Database? _dataBase;

  Future<Database> get getDataBase async {
    _dataBase ??= await _initialDataBase();
    return _dataBase!;
  }

  void get closeDataBase => _dataBase = null;

  Future<Database> _initialDataBase() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, AppConstants.notesTable);
    Database myLocalDataBase = await openDatabase(path,
        onCreate: _onCreate, version: 2, onUpgrade: _onUpgrade);
    return myLocalDataBase;
  }

  FutureOr<void>? _onUpgrade(
      Database database, int oldVersion, int newVersion) {
    database.execute('ALTER TABLE notes ADD COLUMN color2 TEXT');
    if (kDebugMode) {
      print('notes update  old version$oldVersion and new version $newVersion');
    }
  }

  FutureOr<void>? _onCreate(Database database, int version) {
    database.execute(
        // 'CREATE TABLE dummyDataBase (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,name TEXT NOT NULL ,age TEXT NOT NULL,gender TEXT NOT NULL)'
        'CREATE TABLE notes (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,title TEXT NOT NULL ,description TEXT NOT NULL, color TEXT NOT NULL)');
    if (kDebugMode) {
      print("notes is Created ");
  }
  }
}


