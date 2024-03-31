import 'package:floor/floor.dart';
import'package:note_app/notes_app/domain/entities/note_entity.dart';
import 'package:note_app/notes_app/presentation/utils/constants.dart';

@Entity(tableName: AppConstants.notesTable)
class Note {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String title;
  final String description;
  final ColorEnum color;

  Note(
      {required this.id,
      required this.title,
      required this.description,
      required this.color});
}
