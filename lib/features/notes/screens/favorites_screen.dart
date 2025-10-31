import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prack_8/features/notes/models/note.dart';
import 'package:prack_8/data/note_repository.dart';
import '../widgets/note_inherited.dart';
import 'edit_note_screen.dart';
import '../widgets/note_list_view.dart';
import '../widgets/category_dropdown.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Note> filteredNotes = [];
  String _selectedCategory = 'Все категории';
  String _sortCriteria = 'Дата создания';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_filterNotes);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _filterNotes();  // Начальный вызов фильтрации здесь, чтобы избежать ошибки в initState
  }

  void _filterNotes() {
    final query = _controller.text.toLowerCase();
    setState(() {
      filteredNotes = NoteInherited.of(context).repository.notes.where((note) {
        final matchesQuery = note.title.toLowerCase().contains(query) ||
            note.content.toLowerCase().contains(query);
        final matchesCategory = _selectedCategory == 'Все категории' ||
            note.category == _selectedCategory;
        return matchesQuery && matchesCategory && note.isFavorite && !note.isArchived;
      }).toList();
      _sortNotes();
    });
  }

  void _sortNotes() {
    setState(() {
      filteredNotes.sort((a, b) {
        switch (_sortCriteria) {
          case 'Заголовок':
            return a.title.compareTo(b.title);
          case 'Дата создания':
            return b.creationDate.compareTo(a.creationDate);
          default:
            return 0;
        }
      });
    });
  }

  void _deleteNote(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Подтверждение'),
        content: const Text('Вы уверены, что хотите удалить эту заметку?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                NoteInherited.of(context).repository.deleteNote(id);
                _filterNotes();
              });
              Navigator.of(context).pop();
            },
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Поиск избранных заметок',
                      hintText: 'Введите запрос для поиска',
                      prefixIcon: const Icon(Icons.search),
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
                  ),
                ),
                const SizedBox(width: 16.0),
                CategoryDropdown(
                  value: _selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                      _filterNotes();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.grey[100],
              ),
              child: Row(
                children: [
                  Text(
                    'Сортировать по:',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _sortCriteria,
                        isExpanded: true,
                        items: <String>['Дата создания', 'Заголовок']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _sortCriteria = newValue!;
                            _sortNotes();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            Expanded(
              child: NoteListView(
                notes: filteredNotes,
                onDelete: (index) => _deleteNote(filteredNotes[index].id),
                onTap: (index) {
                  final note = filteredNotes[index];
                  context.push('/edit/${note.id}', extra: note).then((_)=> setState(() => _filterNotes()));
                },
                onRefresh: _filterNotes,
              ),
            ),
          ],
        ),
      ),
    );
  }
}