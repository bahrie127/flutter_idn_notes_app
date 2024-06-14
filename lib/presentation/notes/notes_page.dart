import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_idn_notes_app/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_idn_notes_app/presentation/auth/login_page.dart';
import 'package:flutter_idn_notes_app/presentation/notes/add_page.dart';
import 'package:flutter_idn_notes_app/presentation/notes/bloc/all_notes/all_notes_bloc.dart';
import 'package:flutter_idn_notes_app/presentation/notes/bloc/delete_note/delete_note_bloc.dart';
import 'package:flutter_idn_notes_app/presentation/notes/detail_page.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    context.read<AllNotesBloc>().add(GetAllNotes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notes App'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            BlocConsumer<LogoutBloc, LogoutState>(
              listener: (context, state) {
                if (state is LogoutSuccess) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  }));
                }
                if (state is LogoutFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is LogoutLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return IconButton(
                  onPressed: () {
                    context.read<LogoutBloc>().add(LogoutButtonPressed());
                  },
                  icon: const Icon(Icons.logout_outlined),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<AllNotesBloc, AllNotesState>(
          builder: (context, state) {
            if (state is AllNotesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is AllNotesFailed) {
              return const Center(
                child: Text('Failed to load notes'),
              );
            }

            if (state is AllNotesSuccess) {
              if (state.data.data!.isEmpty) {
                return const Center(
                  child: Text('No notes'),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final note = state.data.data![index];
                  return Card(
                    child: ListTile(
                      title: Text('${note.title}'),
                      subtitle: Text(note.content!.length < 20
                          ? note.content!
                          : note.content!.substring(0, 20)),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BlocConsumer<DeleteNoteBloc, DeleteNoteState>(
                              listener: (context, state) {
                                if (state is DeleteNoteSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Note deleted successfully'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  context
                                      .read<AllNotesBloc>()
                                      .add(GetAllNotes());
                                }
                                if (state is DeleteNoteFailed) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.message),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is DeleteNoteLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                return IconButton(
                                  icon: const Icon(Icons.delete_forever),
                                  onPressed: () {
                                    context.read<DeleteNoteBloc>().add(
                                        DeleteNoteButtonPressed(id: note.id!));
                                  },
                                );
                              },
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return DetailPage(note: note);
                                  }));
                                },
                                child: const Icon(Icons.arrow_forward_ios)),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  );
                },
                itemCount: state.data.data!.length,
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('Item $index'),
                    subtitle: const Text('This is a subtitle'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                );
              },
              itemCount: 20,
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AddPage();
            }));
          },
          child: const Icon(Icons.add),
        ));
  }
}
