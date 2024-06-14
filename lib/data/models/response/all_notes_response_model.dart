import 'dart:convert';

import 'package:flutter_idn_notes_app/data/models/response/note_response_model.dart';

class AllNotesResponseModel {
    final String? message;
    final List<Note>? data;

    AllNotesResponseModel({
        this.message,
        this.data,
    });

    factory AllNotesResponseModel.fromJson(String str) => AllNotesResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllNotesResponseModel.fromMap(Map<String, dynamic> json) => AllNotesResponseModel(
        message: json["message"],
        data: json["data"] == null ? [] : List<Note>.from(json["data"]!.map((x) => Note.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

