import 'package:uuid/uuid.dart';

class Note {
  String id;
  String title;
  String content;
  String category;
  DateTime creationDate;
  bool isFavorite;
  bool isArchived;

  Note({
    required this.title,
    required this.content,
    this.category = 'Без категории',
    DateTime? creationDate,
    String? id,
    this.isFavorite = false,
    this.isArchived = false,
  })  : id = id ?? const Uuid().v4(),
        creationDate = creationDate ?? DateTime.now();
}