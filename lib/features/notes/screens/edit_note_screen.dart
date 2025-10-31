import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prack_8/features/notes/models/note.dart';
import 'package:prack_8/data/note_repository.dart';

import '../widgets/category_dropdown.dart';

class EditNoteScreen extends StatefulWidget {
  final String index;
  final Note note;

  const EditNoteScreen({
    super.key,
    required this.index,
    required this.note,
  });

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String _selectedCategory = 'Без категории';

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note.title;
    _contentController.text = widget.note.content;
    _selectedCategory = widget.note.category;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleController.text),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Заголовок',
                hintText: 'Введите заголовок заметки',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
              ),
              maxLength: 70,
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Содержимое',
                hintText: 'Введите текст заметки',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
              ),
              maxLines: 5,
              minLines: 3,
            ),
            const SizedBox(height: 20.0),
            CategoryDropdown(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text.trim();
                final content = _contentController.text.trim();
                if (title.isNotEmpty && content.isNotEmpty) {
                  NoteRepository.updateNote(
                    widget.index,
                    Note(
                      title: title,
                      content: content,
                      category: _selectedCategory,
                      isFavorite: widget.note.isFavorite,
                      isArchived: widget.note.isArchived,
                    ),
                  );
                  context.pop();
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      title: const Text('Ошибка'),
                      content: const Text('Оба поля должны быть заполнены!'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'OK',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 2,
                textStyle: const TextStyle(fontSize: 16.0),
              ),
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}