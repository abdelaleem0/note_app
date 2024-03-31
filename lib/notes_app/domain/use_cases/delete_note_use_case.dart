import 'package:note_app/notes_app/domain/repositories/notes_repositories.dart';

class DeleteNoteUseCase{
  final NotesRepository repository;

  DeleteNoteUseCase({required this.repository});

  Future<int> call({required int id}){
    return repository.deleteNote(id: id);
}


}