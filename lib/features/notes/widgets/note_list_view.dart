import 'package:flutter/material.dart';
import 'package:prack_8/features/notes/models/note.dart';
import 'package:prack_8/shared/widgets/empty_state.dart';
import 'note_tile.dart';

class NoteListView extends StatelessWidget {
  final List<Note> notes;
  final Function(int) onTap;
  final Function(int) onDelete;
  final VoidCallback onRefresh;

  const NoteListView({
    super.key,
    required this.notes,
    required this.onTap,
    required this.onDelete,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return notes.isEmpty
        ? const EmptyState(message: 'Ничего не найдено')
        : ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return NoteTile(
          note: notes[index],
          onTap: () => onTap(index),
          onDelete: () => onDelete(index),
          onRefresh: onRefresh,
        );
      },
    );
  }
}