import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prack_8/features/notes/models/note.dart';
import 'package:prack_8/data/note_repository.dart';
import 'package:prack_8/features/notes/widgets/note_inherited.dart';

import '../widgets/category_dropdown.dart';
import 'notes_list_screen.dart';


class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String _selectedCategory = 'Без категории';

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
          title: const Text('Добавить заметку'),
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
                  NoteInherited.of(context).repository.addNote(
                    Note(
                      title: title,
                      content: content,
                      category: _selectedCategory,
                    ),
                  );
                  _titleController.clear();
                  _contentController.clear();
                  context.pop('/notes');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Заполните оба поля')),
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
              child: const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}