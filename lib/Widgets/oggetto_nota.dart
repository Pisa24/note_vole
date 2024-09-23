import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:note_vole/Cambiamenti/cambiamento_nota.dart';
import 'package:note_vole/Cambiamenti/controller_nuova_nota.dart';
import 'package:note_vole/Cambiamenti/mostra_finestra_diaologo.dart';
import 'package:note_vole/Models/modello_nota.dart';
import 'package:note_vole/Pagine/pagina_nota.dart';
import 'package:note_vole/Widgets/oggetto_tag_nota.dart';
import 'package:note_vole/constants.dart';
import 'package:provider/provider.dart';

class NoteCards extends StatelessWidget {
  const NoteCards({
    required this.nota,
    required this.isInGrid,
    super.key,
  });

  final bool isInGrid;
  final Nota nota;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, 
              MaterialPageRoute(builder: (context) => 
              ChangeNotifierProvider(
                //cambio lo stato della nota
                create: (_) => ControllerNuovaNota()..note = nota,
                child: const PaginaNota(
                  isNew: false,
                ),
              )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: white,
          border: Border.all(color: primary),
          borderRadius: BorderRadius.circular(12),
          //ombra
          boxShadow: [BoxShadow(
            color: primary.withOpacity(0.5),
            offset: const Offset(4, 4),
            )
            ]
        ),
        padding: const EdgeInsets.all(12),
        child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //se esiste un titolo, mostralo!
            if(nota.title != null) ...[
           Text(nota.title!, 
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: gray900,
          ),
          ),
          const SizedBox(height: 4,),],
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
            children: List.generate(

              //se esistono dei tags, mostrali!
              nota.tags!.length, 
             (index) => 
             NoteTag(label: nota.tags![index],))
          ),),
          const SizedBox(height: 4,),

          if(nota.content != null)
          isInGrid ?
           Expanded(child:
          Text(
            nota.content!,
          style: const TextStyle(color: gray700)
          ),)
          :  Text(
            nota.content!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: gray700)
          ),
          if(isInGrid) 
          const Spacer(),
           Row(
            children: [
              Text(
                //cosi la data ci mostrera il giorno. il mese. e l'anno
                DateFormat('dd MMM, y').format(
                  DateTime.fromMicrosecondsSinceEpoch(nota.dataCreazione)),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: gray500,
                  ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: ()  async{
                  //cancello la nota del context
                  final shouldDelite  = await showConfirmationDialog(context: context, 
                  title: 'Vuoi cancellare la nota?',)
                  ?? false;

                  if(shouldDelite && context.mounted){
                  context.read<NotesProvider>().deleteNote(nota);
                  }
                },
                child: const FaIcon(
                  FontAwesomeIcons.trash,
                  color: gray500,
                  size: 16,
                  ),
              ),
            ],
          )
        ],
        ),
      ),
    );
  }
}

