// app_router.dart
import 'package:go_router/go_router.dart';
import 'package:prack_8/features/notes/screens/notes_list_screen.dart';
import 'package:prack_8/features/notes/screens/add_note_screen.dart';
import 'package:prack_8/features/notes/screens/favorites_screen.dart';
import 'package:prack_8/features/notes/screens/archive_screen.dart';
import 'package:prack_8/features/notes/screens/settings_screen.dart';
import 'package:prack_8/features/notes/screens/edit_note_screen.dart';
import 'package:prack_8/features/notes/models/note.dart';
import 'package:prack_8/features/notes/screens/splash_screen.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/notes',
        builder: (context, state) => const NotesListScreen(),
      ),
      GoRoute(
        path: '/add',
        builder: (context, state) => const AddNoteScreen(),
      ),
      GoRoute(
        path: '/favorites',
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: '/archive',
        builder: (context, state) => const ArchiveScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/edit/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final note = state.extra as Note;
          return EditNoteScreen(index: id, note: note);
        },
      ),
    ],
  );
}