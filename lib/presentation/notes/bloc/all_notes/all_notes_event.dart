part of 'all_notes_bloc.dart';

@immutable
sealed class AllNotesEvent {}

class GetAllNotes extends AllNotesEvent {}
