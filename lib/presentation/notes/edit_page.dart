import 'package:flutter/material.dart';

import 'package:flutter_idn_notes_app/data/models/response/note_response_model.dart';

class EditPage extends StatefulWidget {
  final Note note;
  const EditPage({
    super.key,
    required this.note,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool isPin = false;

  void isPinHandler(bool value) {
    setState(() {
      isPin = value;
    });
  }

  @override
  void initState() {
    _titleController.text = widget.note.title!;
    _contentController.text = widget.note.content!;
    isPin = widget.note.isPin! == '1' ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
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
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Update'),
            ),
          ),
        ],
      ),
    );
  }
}
