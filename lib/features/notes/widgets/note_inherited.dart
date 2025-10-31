import 'package:flutter/material.dart';
import 'package:prack_8/data/note_repository.dart';

class NoteInherited extends InheritedWidget {
  final NoteRepository repository;  // Хранение зависимости

  const NoteInherited({
    Key? key,
    required this.repository,
    required Widget child,
  }) : super(key: key, child: child);

  static NoteInherited of(BuildContext context) {
    final NoteInherited? result = context.dependOnInheritedWidgetOfExactType<NoteInherited>();
    assert(result != null, 'No NoteInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(NoteInherited oldWidget) {
    return false;
  }
}