import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_vole/Cambiamenti/controller_nuova_nota.dart';
import 'package:note_vole/Cambiamenti/mostra_finestra_diaologo.dart';
import 'package:note_vole/Widgets/bottone_fine_linea.dart';
import 'package:note_vole/Widgets/nota_metadata.dart';
import 'package:note_vole/Widgets/oggetto_quill.dart';
import 'package:note_vole/constants.dart';
import 'package:provider/provider.dart';

class PaginaNota extends StatefulWidget {
  const PaginaNota({super.key, required this.isNew});

  //serve per capi se stai andando a creare una nuova nota
  //oppure se hai cliccato su una gia creata
  final bool isNew;

  @override
  State<PaginaNota> createState() => _PaginaNotaState();
}

class _PaginaNotaState extends State<PaginaNota> {


  //creazione e gestione del controller del testoQuill
  late final QuillController cQuill;

  //gestisce la modalita focus con cui ci immergiamo nello scrivere...
  late FocusNode focus;

  //serve per il bottone che switcha tra nuovo e in modifica
  //late bool readOnly;
  //controller delle note (ricorda che ci scrivi)
  late final ControllerNuovaNota cNota;

  //controller per gestire il titolo e cambiamenti di stato
  late final TextEditingController cTitolo;

  @override
  void initState() {
    super.initState();
   
  
    cNota = context.read<ControllerNuovaNota>();
    
    //cosi popolo il campo che mi interessa
    cTitolo =  TextEditingController(text: cNota.titolo);

    //al controller quill diamo la capacita di interagi con il controllerNota
    //e in particolare di gestire il content
    cQuill = QuillController.basic()..addListener((){
      cNota.content = cQuill.document;
    });
    focus = FocusNode();

  //chiama il focus e il listeners quando il widget tree è disponibile
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
   if(widget.isNew){
      focus.requestFocus();
      cNota.readOnly = false;
    }
    else{
       cNota.readOnly = true;
        cQuill.document = cNota.content;
    }
  },);
  }

  @override
  void dispose() {
    cQuill.dispose();
    focus.dispose();
    cTitolo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //popscore serve per evitare che la nota venga cancellata
    //perche si è tornati indietro senza salvarla
    return PopScope(
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) async {
        if (didPop) return;


        //se non puoi salvare e provi ad uscire dalla nota
        //compare la finestra di conferma
        if (!cNota.canSaveNote) {
          Navigator.pop(context);
          return;
        }

        final bool? shouldSave = await showConfirmationDialog(
          context: context,
          title: 'Do you want to save the note?',
        );

        //se clicchi fuori dai bottoni
        if (shouldSave == null) return;


        if (!context.mounted) return;

        if (shouldSave) {
          cNota.saveNote(context);
        }

        Navigator.pop(context);
      },
      
      child: Scaffold(
        appBar: AppBar(
      
          //bottone per tornare indietro
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: bottone_fine_linea(
                icon: FontAwesomeIcons.chevronLeft,
                onPressed: (){
                  //ti rimanda indietro nella pagina
                  Navigator.maybePop(context);
                },
                ),
          ),
      
        
      
          title: Text(widget.isNew?  'nuova NotaPD' : 'Modifica'),
          actions: [
      
            //bottone per switchare tra modifica e lettura 
            //(FOCUS E UNFOCUS)
            Selector<ControllerNuovaNota, bool>(
              selector: (context, cNota) => cNota.readOnly,
              builder: (context, readOnly, child) => 
              bottone_fine_linea(
                icon: readOnly? FontAwesomeIcons.pen 
                : FontAwesomeIcons.bookOpen,
                onPressed: (){
                
                    cNota.readOnly =  !readOnly;
                  
                  if(cNota.readOnly){
                    FocusScope.of(context).unfocus();
                  } else{
                focus.requestFocus();
                  }
                },
              ),
            ),
      
            //bottone per salvare la nota
            Selector<ControllerNuovaNota, bool>(
              selector: (_, cNota, ) => cNota.canSaveNote,
              builder: (_, canSaveNote, __) => bottone_fine_linea(
                icon: FontAwesomeIcons.check,
                onPressed: canSaveNote? (){
                  cNota.saveNote(context);
                  Navigator.pop(context);
                }: null,
                ),
            )
          ],
        ),


        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Selector<ControllerNuovaNota, bool>(
              selector: (context, c) => c.readOnly,
              builder: (context, readOnly, child) => 
                TextField(
                  controller: cTitolo,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Titolo...',
                    hintStyle: TextStyle(color: gray300),
                    border: InputBorder.none,
                    ),
                    canRequestFocus: !readOnly,
      
                    //serve per regaire solo agli effettivi cambiamenti del testo
                    //e assegnare il titolo corrente
                    onChanged: (titoloCorrente){
                      cNota.titolo = titoloCorrente;
                    },
                ),
              ),
              //gestione di differenze tra nota nuova e nota da modificare
              
              //gestisce le trasformazioni di stato della nota
              NoteMetadata( note: cNota.note,),
          
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(
                  color: gray500,
                  thickness: 2,
                ),
              ),
          
             //quillTesto e controller
          
              Expanded(
                 child: QuillEditorProvider(
                  controller: cQuill,
                    child:  Selector<ControllerNuovaNota, bool>(
                    selector: (_, controler) => cQuill.readOnly,
                   builder: (_, readOnly, __) => 
                    Column(
                        children: [
                          Expanded(child: QuillEditor.basic(
                            controller: cQuill,
                            configurations: QuillEditorConfigurations(
                              placeholder: 'Scrivi qui...',
                              expands: true,
                              //je damo il readOnly
                              checkBoxReadOnly: readOnly,
                              ),
                         
                              //je damo il focus
                             focusNode: focus,
                             
                          )),
                         
                          //se stai in modalita lettura non vuoi vedere la barra fancy
                          if(!readOnly) 
                          oggetto_per_rendere_carino_quill(controller: cQuill)
                          ]
                          ),
                    ),
                    )
                    ),
        ]),
        )),
    );
  }
  }
