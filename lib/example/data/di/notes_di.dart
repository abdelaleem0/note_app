import 'package:note_app/app_config.dart';
import 'package:note_app/example/data/data_sources/sql_database.dart';
import 'package:note_app/example/data/repositories/floor_notes_repositories_impl.dart';
import 'package:note_app/example/database/dao/notes_dao.dart';
import 'package:note_app/example/database/notes_database.dart';
import 'package:note_app/example/data/repositories/sqfLite_notes_repositories_impl.dart';
import 'package:note_app/example/domain/repositories/notes_repositories.dart';
import 'package:note_app/example/domain/use_cases/delete_note_use_case.dart';
import 'package:note_app/example/domain/use_cases/delete_all_notes_use_case.dart';
import 'package:note_app/example/domain/use_cases/get_notes_use_case.dart';
import 'package:note_app/example/domain/use_cases/insert_note_use_case.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies({required AppEnvironment appEnvironment}) async {
  injector.pushNewScope();
  await _registerNotesFloorDependencies(appEnvironment);
}

Future<void> _registerNotesFloorDependencies(AppEnvironment appEnvironment) async {
  injector.registerFactory(() => InsertNoteUseCase(repository: injector(instanceName:appEnvironment.name )));
  injector.registerFactory(() =>   SqlDataBase.instance);
  injector.registerFactory(() => DeleteNoteUseCase(repository: injector(instanceName:appEnvironment.name )));
  injector.registerFactory(() => GetNotesUseCase(repository:injector(instanceName:appEnvironment.name)),);
  injector.registerFactory(() => DeleteAllNotesUseCase(repository: injector(instanceName:appEnvironment.name)));
  injector.registerLazySingleton<NotesRepository>(() => NotesRepositoriesImpl(database: injector()),instanceName: AppEnvironment.sqfLite.name);

  _registerFloorDataBase(appEnvironment);
}

Future<void> _registerFloorDataBase(AppEnvironment appEnvironment)async {
  if(appEnvironment==AppEnvironment.floor){
    injector.registerLazySingletonAsync<NotesDataBase>(
            () => $FloorNotesDataBase.databaseBuilder('app_database.db').build());
    injector.registerLazySingleton<NotesDao>(() => NotesDaoImp());
    injector.registerLazySingleton<NotesRepository>(() => NotesRepositoriesFloorImpl(notesDao: injector()) ,instanceName:AppEnvironment.floor.name );

  }
}