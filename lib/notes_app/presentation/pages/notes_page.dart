import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/notes_app/domain/entities/note_entity.dart';
import 'package:note_app/notes_app/presentation/manager/notes_cubit.dart';
import 'package:note_app/notes_app/presentation/manager/notes_state.dart';
import 'package:note_app/notes_app/presentation/pages/add_note_page.dart';
import 'package:note_app/notes_app/presentation/utils/constants.dart';
import 'package:note_app/notes_app/presentation/widgets/note_item.dart';

class NotesPage extends StatefulWidget {
  final String title;
  const NotesPage( this.title, {super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        leadingWidth: 1,
        backgroundColor: const Color(0xffefb7ff),
        title:  Center(
            child: Text(
          '${widget.title} notes app',
        )),
      ),
      body: BlocConsumer<NotesCubit,NotesState>(
        listenWhen: (previous, current) => previous.deleteNotesTable!=current.deleteNotesTable,
        listener:(context, state) {
          if(state.deleteNotesTable.isSuccess){
            BlocProvider.of<NotesCubit>(context).getNotes();
          }

        },
      builder: (context, state) {
        return BlocBuilder<NotesCubit,NotesState>(
          builder:(context, state) {
            if(state.notes.isSuccess){
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () =>
                        _deleteNotesTable(tableName: AppConstants.notesTable),
                    child: const Text(
                      'delete dataBase',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: state.notes.data?.length,
                        itemBuilder: (context, index) {
                          return NoteItem(
                            note: state.notes.data?[index]??const NoteEntity.initial(),
                            onPressed: () {
                              _deleteItemFromDataBase(state.notes.data?[index].id ?? 0,);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
              if (state.notes.isFailure) {
                return Center(
                  child: Text(
                    state.notes.errorMessage ??
                        'error during fetching database',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
          }, );
      },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (cont) => BlocProvider.value(
                  value: context.read<NotesCubit>(),
                  child: const AddNotePage(),
                ),

              ));
        },
      ),
    );
  }

  void _deleteItemFromDataBase(int id) async {
    BlocProvider.of<NotesCubit>(context).deleteNote(id);
  }



  void _deleteNotesTable({required String tableName})async {
    BlocProvider.of<NotesCubit>(context).deleteNotesTable(tableName);

  }
}
