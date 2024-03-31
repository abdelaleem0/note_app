import 'dart:async';

import 'package:floor/floor.dart';
import 'package:note_app/notes_app/database/dao/notes_dao.dart';
import 'package:note_app/notes_app/database/entities/note.dart';
import 'package:note_app/notes_app/domain/entities/note_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'notes_database.g.dart';
@Database(version: 1, entities: [Note])
abstract class NotesDataBase extends FloorDatabase{
  NotesDao get notesDeo;

}