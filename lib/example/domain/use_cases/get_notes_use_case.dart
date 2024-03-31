import 'package:note_app/example/domain/entities/note_entity.dart';
import 'package:note_app/example/domain/repositories/notes_repositories.dart';

class GetNotesUseCase{
  final NotesRepository repository;

  GetNotesUseCase({required this.repository});
  Future<List<NoteEntity>?> call() {
    return repository.getNotes();
  }


}