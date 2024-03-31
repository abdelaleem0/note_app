import 'package:note_app/notes_app/data/data_sources/sql_database.dart';
import 'package:note_app/notes_app/data/mappers/notes_extension.dart';
import 'package:note_app/notes_app/domain/entities/note_entity.dart';
import 'package:note_app/notes_app/domain/repositories/notes_repositories.dart';
import 'package:note_app/notes_app/presentation/utils/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesRepositoriesImpl implements NotesRepository {
  final SqlDataBase _database;

  NotesRepositoriesImpl({required SqlDataBase database}) : _database = database;
  @override
  Future<int> deleteNote({required int id}) async {
    final dataBase = await _database.getDataBase;
    String sqlDelete = "DELETE  FROM '${AppConstants.notesTable}' WHERE id=$id";
    final response = await dataBase.rawDelete(sqlDelete);
    return response;
  }

  @override
  Future<int> insertNote(NoteEntity model) async {
    final dataBase = await _database.getDataBase;
    String sqlInsert =
        'INSERT INTO ${AppConstants.notesTable}(id,title, description,color) VALUES("${model.id}","${model.title}","${model.description}","${model.color.name}")';
    try {
      final response = await dataBase.rawInsert(sqlInsert);
      return response;
    } catch (e) {
      return 0;
    }
  }

  @override
  Future<List<NoteEntity>?> getNotes() async {
    try {
      String sqlRead = "SELECT * FROM '${AppConstants.notesTable}'";
      final dataBase = await _database.getDataBase;
      final response = await dataBase.rawQuery(sqlRead);

      return response.map((e) {
        return e.mapping();
      }).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteNotesTable({required String tableName}) async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, tableName);
    await deleteDatabase(path);
  }
}
