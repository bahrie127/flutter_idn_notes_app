part of 'add_note_bloc.dart';

@immutable
sealed class AddNoteState {}

final class AddNoteInitial extends AddNoteState {}

final class AddNoteLoading extends AddNoteState {}

final class AddNoteSuccess extends AddNoteState {
  final NoteResponseModel data;

  AddNoteSuccess({
    required this.data,
  });
}

final class AddNoteFailed extends AddNoteState {
  final String message;

  AddNoteFailed({
    required this.message,
  });
}