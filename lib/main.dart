import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'app.dart';
import 'data/note_repository.dart';

void main() {
  GetIt.I.registerSingleton<NoteRepository>(NoteRepository());
  runApp(MyApp());
}