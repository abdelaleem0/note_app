
import 'package:note_app/example/domain/entities/note_entity.dart';
import 'package:note_app/example/domain/repositories/notes_repositories.dart';

class InsertNoteUseCase{
  final NotesRepository repository;

  InsertNoteUseCase({required this.repository});
  Future<int> call({required NoteEntity model}) {
    return repository.insertNote(model);
  }


}