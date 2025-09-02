import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:note_adv/models/notes.dart';
import 'package:path_provider/path_provider.dart';

class Notedb extends ChangeNotifier {
  static late Isar isar;
  static Future<void> initilize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  final List<Note> currentNotes = [];
  Future<void> addNote(
    String textfromuser,
    String subtextt,
    DateTime time,
  ) async {
    final newNote = Note();
    newNote.text = textfromuser;
    newNote.subtext = subtextt;
    newNote.datetime = time;
    await isar.writeTxn(() => isar.notes.put(newNote));
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    List<Note> fetchedNOtes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNOtes);
    notifyListeners();
  }

  Future<void> updateNote(
    int id,
    String newtext,
    String subttext,
    DateTime time,
  ) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newtext;
      existingNote.subtext = subttext;
      existingNote.datetime = time;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    notifyListeners();
    await fetchNotes();
  }
}
