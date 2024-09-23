

import 'package:flutter/material.dart';
import 'package:note_vole/Models/modello_nota.dart';


//cerca dentro la litsa di tag
// ignore: camel_case_extensions
extension listDeepContains on List<String>{
  bool deepContains(String term) =>
    contains(term) || any((element) => element.contains(term));
}

class NotesProvider extends ChangeNotifier{
  final List<Nota> _notes = [];


//Cerco comparando il testo scritto nela barra con 
//tutti i titoli, testi e tags nelle note
//funziona solo se c'e scritto qualcosa 
   List<Nota> get notes =>
      [..._searchTerm.isEmpty ? _notes : _notes.where(_test)];

  bool _test(Nota note) {
    //puoi cerca sia in low che in upperCase
    final term = _searchTerm.toLowerCase().trim();
    final title = note.title?.toLowerCase() ?? '';
    final content = note.content?.toLowerCase() ?? '';
    //se non ci sono = stringa vuota
    final tags = note.tags?.map((e) => e.toLowerCase()).toList() ?? [];
    return title.contains(term) ||
        content.contains(term) ||
        tags.deepContains(term);
  }

 /* List<Nota> get notes =>
      [..._searchTerm.isEmpty ? _notes : _notes.where(_test)]..sort(_compare);

  bool _test(Nota note) {
    final term = _searchTerm.toLowerCase().trim();
    final title = note.title?.toLowerCase() ?? '';
    final content = note.content?.toLowerCase() ?? '';
    final tags = note.tags?.map((e) => e.toLowerCase()).toList() ?? [];
    return title.contains(term) ||
        content.contains(term) ||
        tags.deepContains(term);
  }*/

  /*int _compare(Nota note1, note2) {
    return _orderBy == OrderOption.dateModified
        ? _isDescending
            ? note2.dateModified.compareTo(note1.dateModified)
            : note1.dateModified.compareTo(note2.dateModified)
        : _isDescending
            ? note2.dateCreated.compareTo(note1.dateCreated)
            : note1.dateCreated.compareTo(note2.dateCreated);
  }*/

  void addNote(Nota note) {
    _notes.add(note);
    notifyListeners();
  }


  //usiamo il campo data creazione per trovare esattamente la nostra nota
  //tanto è l'unico campo che non camìbia
  void updateNote(Nota note) {
    final index =
        _notes.indexWhere((element) => element.dataCreazione == note.dataCreazione);
    _notes[index] = note;
    notifyListeners();
  }

  //rimuove easy la nota
  void deleteNote(Nota note) {
    _notes.remove(note);
    notifyListeners();
  }


  bool _isDescending = true;
  set isDescending(bool value) {
    _isDescending = value;
    notifyListeners();
  }

  bool get isDescending => _isDescending;

  bool _isGrid = true;
  set isGrid(bool value) {
    _isGrid = value;
    notifyListeners();
  }

  bool get isGrid => _isGrid;

  String _searchTerm= '';
  set searchTerm(String value){
    _searchTerm = value;
    notifyListeners();
  }

  String get searchTerm => _searchTerm;

}