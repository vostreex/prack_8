import 'package:flutter/material.dart';
import 'package:prack_8/features/notes/models/note.dart';
import 'package:prack_8/data/note_repository.dart';
import 'package:prack_8/features/notes/widgets/note_inherited.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onRefresh;

  const NoteTile({
    super.key,
    required this.note,
    required this.onTap,
    required this.onDelete,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final newlineIndex = note.content.indexOf('\n');
    final previewLength = newlineIndex != -1 ? newlineIndex : 30;
    final preview = note.content.length > previewLength
        ? '${note.content.substring(0, previewLength)}...'
        : note.content;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(
                note.title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    preview,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (note.category != 'Без категории')
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Chip(
                            label: Text(
                              note.category,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[700],
                              ),
                            ),
                            backgroundColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.grey[400]!),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              onTap: onTap,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            ),
          ),
          IconButton(
            icon: Icon(
              note.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: note.isFavorite ? Colors.red : Colors.grey,
              size: 24.0,
            ),
            onPressed: () {
              NoteInherited.of(context).repository.toggleFavorite(note.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    note.isFavorite
                        ? 'Заметка удалена из избранного'
                        : 'Заметка добавлена в избранное',
                  ),
                ),
              );
              onRefresh();
            },
          ),
          IconButton(
            icon: Icon(
              note.isArchived ? Icons.unarchive : Icons.archive,
              color: Colors.blue[300],
              size: 24.0,
            ),
            onPressed: () {
              NoteInherited.of(context).repository.toggleArchive(note.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    note.isArchived
                        ? 'Заметка восстановлена из архива'
                        : 'Заметка добавлена в архив',
                  ),
                ),
              );
              onRefresh();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red[300],
              size: 24.0,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}