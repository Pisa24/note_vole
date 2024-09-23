import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_vole/Cambiamenti/cambiamento_nota.dart';
import 'package:note_vole/constants.dart';
import 'package:provider/provider.dart';

class BarraDiRicerca extends StatelessWidget {
  const BarraDiRicerca({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search notes...',
        hintStyle: const TextStyle(fontSize: 14),
        prefixIcon:  const Icon(FontAwesomeIcons.magnifyingGlass),
        fillColor: white,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.zero,
        prefixIconConstraints: const BoxConstraints(minWidth: 40,minHeight:40),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary),
          ),
          focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary),
          )
        ),
        //la capacita della barra di leggere
        onChanged: (newValue){
          context.read<NotesProvider>().searchTerm = newValue;
        },
    );
  }
}

