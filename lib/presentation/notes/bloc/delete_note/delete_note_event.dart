part of 'delete_note_bloc.dart';

@immutable
sealed class DeleteNoteEvent {}

class DeleteNoteButtonPressed extends DeleteNoteEvent {
  final int id;

  DeleteNoteButtonPressed({
    required this.id,
  });
}
