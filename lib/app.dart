import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prack_8/app_router.dart';
import 'data/note_repository.dart';
import 'features/notes/widgets/note_inherited.dart';
import 'shared/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = AppRouter().router;

  @override
  Widget build(BuildContext context) {
    final repo = NoteRepository();  // Создание единственного экземпляра репозитория
    return NoteInherited(
      repository: repo,
      child: MaterialApp.router(
        routerConfig: _router,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}