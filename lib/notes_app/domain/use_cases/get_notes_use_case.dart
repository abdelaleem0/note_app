import 'package:note_app/notes_app/domain/entities/note_entity.dart';
import 'package:note_app/notes_app/domain/repositories/notes_repositories.dart';

class GetNotesUseCase{
  final NotesRepository repository;

  GetNotesUseCase({required this.repository});
  Future<List<NoteEntity>?> call() {
    return repository.getNotes();
  }


}