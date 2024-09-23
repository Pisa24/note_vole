import 'package:flutter/material.dart';
import 'package:note_vole/Models/modello_nota.dart';
import 'package:note_vole/Widgets/oggetto_nota.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key, required this.notes});

  final List<Nota> notes;

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
      clipBehavior: Clip.none,
      itemCount: notes.length,
      itemBuilder: (context, index){
        return NoteCards(
          isInGrid: false,
          nota: notes[index],
          );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 6),
    );
  }
}