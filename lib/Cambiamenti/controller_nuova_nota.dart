import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:note_vole/Cambiamenti/cambiamento_nota.dart';
import 'package:note_vole/Models/modello_nota.dart';
import 'package:provider/provider.dart';

 class ControllerNuovaNota extends ChangeNotifier{

   Nota? _note;
  set note(Nota? value) {
    _note = value;
    //dicitura schizzofrenica
    _title = _note!.title ?? '';
    _content = Document.fromJson(jsonDecode(_note!.contentJson));
    _tags.addAll(_note!.tags ?? []);
    notifyListeners();
  }

  Nota? get note => _note;

  bool _readOnly = false;

  set readOnly(bool value){
    //prima gli do il valore e poi chiamo il listeners
    _readOnly = value;
    notifyListeners();
  }


  bool get readOnly => _readOnly;


  String _title = '';

  set titolo(String value){
    _title = value;
    notifyListeners();
  }
  String get titolo => _title.trim();


  Document _content = Document();

  set content(Document value){
    _content = value;
    notifyListeners();
  }
  Document get content => _content;


final List<String> _tags = [];

  void addTag(String tag){
    _tags.add(tag);
    notifyListeners();
  }

  List<String> get tags => [..._tags];

  //funzione per rimuovere i tag
  void removeTag(int index){
    _tags.removeAt(index);
    notifyListeners();
  }


  //funzione per aggiornare i tags
  void updateTag(String tag, int index) {
    _tags[index] = tag;
    notifyListeners();
  }

  bool get isNew => _note == null;


  //serve per evitare che si possa caricare una nota vuota
  bool get canSaveNote {
    final String? newTitle = titolo.isNotEmpty ? titolo : null;
    final String? newContent = content.toPlainText().trim().isNotEmpty
        ? content.toPlainText().trim()
        : null;
    //caricabile solo con titolo o content
    bool canSave = newTitle != null || newContent != null;

    if (!isNew) {
      final newContentJson = jsonEncode(content.toDelta().toJson());
      canSave &= newTitle != note!.title ||
          newContentJson != note!.contentJson ||
          !listEquals(tags, note!.tags);
    }

    return canSave;
  }

  //gestiona di salvataggio della nota
  void saveNote(BuildContext context) {
    final String? newTitle = titolo.isNotEmpty ? titolo : null;
    final String? newContent = content.toPlainText().trim().isNotEmpty
        ? content.toPlainText().trim()
        : null;
    final String contentJson = jsonEncode(_content.toDelta().toJson());

    //cosi ci rida i millisecondi sgravati
    final int now = DateTime.now().microsecondsSinceEpoch;

    //aggiorna effettivamente la nota
    final Nota note = Nota(
      title: newTitle,
      content: newContent,
      contentJson: contentJson,
      dataCreazione: isNew ? now : _note!.dataCreazione,
      dataModifica: now,
      tags: tags,
    );

    final notesProvider = context.read<NotesProvider>();
    isNew ? notesProvider.addNote(note) : notesProvider.updateNote(note);
  }
}

