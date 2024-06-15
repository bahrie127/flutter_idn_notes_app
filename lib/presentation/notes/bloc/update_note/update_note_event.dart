part of 'update_note_bloc.dart';

@immutable
sealed class UpdateNoteEvent {}

class UpdateNoteButtonPressed extends UpdateNoteEvent {
  final int id;
  final String title;
  final String content;
  final bool isPin;

  UpdateNoteButtonPressed({
    required this.id,
    required this.title,
    required this.content,
    required this.isPin,
  });
}
