part of 'all_notes_bloc.dart';

@immutable
sealed class AllNotesState {}

final class AllNotesInitial extends AllNotesState {}

final class AllNotesLoading extends AllNotesState {}

final class AllNotesSuccess extends AllNotesState {
  final AllNotesResponseModel data;

  AllNotesSuccess({
    required this.data,
  });
}

final class AllNotesFailed extends AllNotesState {
  final String message;

  AllNotesFailed({
    required this.message,
  });
}
