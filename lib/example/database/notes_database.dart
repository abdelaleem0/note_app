import 'dart:async';

import 'package:floor/floor.dart';
import 'package:note_app/example/database/dao/notes_dao.dart';
import 'package:note_app/example/database/entities/note.dart';
import 'package:note_app/example/domain/entities/note_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'notes_database.g.dart';
@Database(version: 1, entities: [Note])
abstract class NotesDataBase extends FloorDatabase{
  NotesDao get notesDeo;

}