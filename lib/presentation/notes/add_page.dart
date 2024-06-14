import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_idn_notes_app/presentation/notes/bloc/add_note/add_note_bloc.dart';
import 'package:flutter_idn_notes_app/presentation/notes/notes_page.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool isPin = false;

  XFile? image;

  void isPinHandler(bool value) {
    setState(() {
      isPin = value;
    });
  }

  //image picker handler
  void imagePickerHandler() async {
    final XFile? _image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = _image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Note'),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Content',
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            //is favorite
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text('Is Pin?'),
                  const SizedBox(
                    width: 16,
                  ),
                  Switch(
                    value: isPin,
                    onChanged: isPinHandler,
                  ),
                ],
              ),
            ),
            //image picker
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: imagePickerHandler,
                child: const Text('Pick Image'),
              ),
            ),
            //image preview
            if (image != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Image.file(File(image!.path)),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: BlocConsumer<AddNoteBloc, AddNoteState>(
                listener: (context, state) {
                  if (state is AddNoteSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Note added successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return const NotesPage();
                    }));
                  }
                  if (state is AddNoteFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AddNoteLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      //save note
                      context.read<AddNoteBloc>().add(
                            AddNoteButtonPressed(
                              title: _titleController.text,
                              content: _contentController.text,
                              isPin: isPin,
                              image: image,
                            ),
                          );
                    },
                    child: const Text('Save'),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
