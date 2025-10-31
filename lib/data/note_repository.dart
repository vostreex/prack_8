import 'package:prack_8/features/notes/models/note.dart';

class NoteRepository {
  final List<Note> notes = [];  // Экземплярное поле вместо static

  void addNote(Note note) {
    notes.add(note);
  }

  void updateNote(String id, Note updatedNote) {
    final index = notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      notes[index] = Note(
        id: id,
        title: updatedNote.title,
        content: updatedNote.content,
        category: updatedNote.category,
        creationDate: notes[index].creationDate,
        isFavorite: notes[index].isFavorite,
        isArchived: notes[index].isArchived,
      );
    }
  }

  void deleteNote(String id) {
    notes.removeWhere((note) => note.id == id);
  }

  void toggleFavorite(String id) {
    final index = notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      notes[index] = Note(
        id: notes[index].id,
        title: notes[index].title,
        content: notes[index].content,
        category: notes[index].category,
        creationDate: notes[index].creationDate,
        isFavorite: !notes[index].isFavorite,
        isArchived: notes[index].isArchived,
      );
    }
  }

  void toggleArchive(String id) {
    final index = notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      notes[index] = Note(
        id: notes[index].id,
        title: notes[index].title,
        content: notes[index].content,
        category: notes[index].category,
        creationDate: notes[index].creationDate,
        isFavorite: notes[index].isFavorite,
        isArchived: !notes[index].isArchived,
      );
    }
  }
}