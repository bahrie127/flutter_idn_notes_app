import 'package:flutter/material.dart';
import 'package:flutter_idn_notes_app/data/datasources/config.dart';

import 'package:flutter_idn_notes_app/data/models/response/note_response_model.dart';
import 'package:flutter_idn_notes_app/presentation/notes/edit_page.dart';

class DetailPage extends StatelessWidget {
  final Note note;
  const DetailPage({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.content!,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 16,
            ),
            if (note.image != null)
              Image.network(
                '${Config.baseUrl}/images/${note.image!}',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),
            //button edit
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPage(note: note),
                    ),
                  );
                },
                child: const Text('Edit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
