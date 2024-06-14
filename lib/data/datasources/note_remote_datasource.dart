import 'package:dartz/dartz.dart';
import 'package:flutter_idn_notes_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_idn_notes_app/data/datasources/config.dart';
import 'package:flutter_idn_notes_app/data/models/response/all_notes_response_model.dart';
import 'package:flutter_idn_notes_app/data/models/response/note_response_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class NoteRemoteDatasource {
  Future<Either<String, NoteResponseModel>> addNote(
    String title,
    String content,
    bool isPin,
    XFile? image,
  ) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${authData.accessToken}',
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Config.baseUrl}/api/notes'),
    );

    request.headers.addAll(headers);
    request.fields['title'] = title;
    request.fields['content'] = content;
    request.fields['is_pin'] = isPin ? '1' : '0';

    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          image.path,
        ),
      );
    }

    http.StreamedResponse response = await request.send();

    final String body = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      return Right(NoteResponseModel.fromJson(body));
    } else {
      return Left(body);
    }
  }

  //get all notes
  Future<Either<String, AllNotesResponseModel>> getAllNotes() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/api/notes'),
      headers: {
        'Authorization': 'Bearer ${authData.accessToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = AllNotesResponseModel.fromJson(response.body);
      return Right(data);
    } else {
      return Left(response.body);
    }
  }

  //delete notes
  Future<Either<String, String>> deleteNotes(int id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.delete(
      Uri.parse('${Config.baseUrl}/api/notes/$id'),
      headers: {
        'Authorization': 'Bearer ${authData.accessToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return const Right('Delete success');
    } else {
      return Left(response.body);
    }
  }

}
