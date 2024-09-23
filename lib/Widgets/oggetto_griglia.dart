import 'package:flutter/material.dart';
import 'package:note_vole/Models/modello_nota.dart';
import 'package:note_vole/Widgets/oggetto_nota.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({
    required this.notes,
    super.key,
  });

  final List<Nota> notes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      clipBehavior: Clip.none,
      itemCount: notes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
       crossAxisSpacing: 8,
        mainAxisSpacing: 8),
      itemBuilder: (context, int index){
    
      //singola nota
      return NoteCards(
        nota: notes[index],
        isInGrid: true,
        );
     },
     );
  }
}
