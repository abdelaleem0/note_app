
import 'package:note_app/notes_app/domain/repositories/notes_repositories.dart';

class DeleteAllNotesUseCase{
  final NotesRepository repository;

  DeleteAllNotesUseCase({required this.repository});

  Future<void> call({required String tableName}){
    return repository.deleteNotesTable(tableName: tableName);
}


}