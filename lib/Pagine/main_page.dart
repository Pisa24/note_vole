import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_vole/Cambiamenti/cambiamento_nota.dart';
import 'package:note_vole/Cambiamenti/controller_nuova_nota.dart';
import 'package:note_vole/Models/modello_nota.dart';
import 'package:note_vole/Pagine/pagina_nota.dart';
import 'package:note_vole/Widgets/bottone_fine_linea.dart';
import 'package:note_vole/Widgets/bottone_plus.dart';
import 'package:note_vole/Widgets/oggetto_nessuna_nota.dart';
import 'package:note_vole/Widgets/oggetto_barra_ricerca.dart';
import 'package:note_vole/Widgets/oggetto_griglia.dart';
import 'package:note_vole/Widgets/oggetto_lista.dart';
import 'package:note_vole/constants.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  //parametri per gestire il bottonedropDown
  final List<String> dropdownOptions = ['Data modified','Data created'];
  late String dropdownValue = dropdownOptions.first;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //sfondo 
      backgroundColor: gray100,
      appBar: AppBar(
        title:const Text("NoteVole :)"),
        actions: [

          //bottoni piccoli e scemi sulla riga
          bottone_fine_linea(
            icon: FontAwesomeIcons.rightFromBracket,
            onPressed: ()=> exit(0),
          ),
            ],
        ),

        //bottone per aggiungere note
        floatingActionButton: 
         BottonePlus(
          onPressed: () {
              Navigator.push(context, 
              // ignore: prefer_const_constructors
              MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
                create: (context) => ControllerNuovaNota(),
                child: const PaginaNota(
                  isNew: true,
                ),
              )));
          },
        ),
        body: Consumer<NotesProvider>(
          
          builder: (context, notesProvider, child) {
            final List<Nota> notes = notesProvider.notes;
            return notes.isEmpty && notesProvider.searchTerm.isEmpty ?

            //e se non hai ancora creato note?
            const NessunaNota() 

            //altrimenti:
            : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
            children: [
          
              //barra di ricerca
              const BarraDiRicerca(),

            if(notes.isNotEmpty) ...[
              //la striscia che gestisce le opzioni di ricerca ecc..
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child:
              Row(
                children: [
                  /*BottoneTendina(
                    icon: isDescending? FontAwesomeIcons.arrowDown : FontAwesomeIcons.arrowUp,
                    size: 18,
                     onPressed: () {
                      setState(() {
                        isDescending = !isDescending;
                      });}
                     ),*/
                 
                  SizedBox(width: 16),
          
          
    
          
                ],
              ),),
          
              //Come vuoi visualizzare le note? a lista o a griglia?
              Expanded(child: 
              notesProvider.isGrid? NotesGrid(notes: notes) :  NotesList(notes: notes),
               ),
            ] else const Expanded(child: Center(
              child: Text('Nessun risultato...',
              textAlign: TextAlign.center,)))
            ],
            ),
          );},
        )
    );
  }
}






