part of 'delete_note_bloc.dart';

@immutable
sealed class DeleteNoteState {}

final class DeleteNoteInitial extends DeleteNoteState {}

final class DeleteNoteLoading extends DeleteNoteState {}

final class DeleteNoteSuccess extends DeleteNoteState {
  final String message;

  DeleteNoteSuccess({
    required this.message,
  });
}

final class DeleteNoteFailed extends DeleteNoteState {
  final String message;

  DeleteNoteFailed({
    required this.message,
  });
}
