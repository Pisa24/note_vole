import 'package:flutter/material.dart';
import 'package:note_vole/Widgets/campi_nota.dart';
import 'package:note_vole/Widgets/oggetto_bottone_elevato.dart';
import 'package:note_vole/Widgets/oggetto_tag_finestra.dart';

// ignore: camel_case_types
class nuova_finestra_dialogo extends StatefulWidget {
  const nuova_finestra_dialogo({
    super.key, this.tag,
  });

  final String? tag;

  @override
  State<nuova_finestra_dialogo> createState() => _finestra_dialogoState();
}

// ignore: camel_case_types
class _finestra_dialogoState extends State<nuova_finestra_dialogo> {

late final TextEditingController tagC;

late final GlobalKey<FormFieldState> tagKey;

@override
  void initState() {
    super.initState();

    //cosi legge quello che vogliamo
    tagC = TextEditingController(text: widget.tag);
    tagKey = GlobalKey();
  }

  @override
  void dispose() {
    tagC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return finestra_tag(
      child: Column(
          //piccola piccola
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Add tag',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 24),
          NoteFormField(
            //possiamo scegliere i campi per i quali la stringa non è valida
            key: tagKey,
            controller: tagC,
            hintText: 'Add tag (< 16 characters)',
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'No tags added';
              } else if (value.trim().length > 16) {
                return 'Tags should not be more than 16 characters';
              }
              return null;
            },

            //cosi l'errore rosso andrà via se stiamo scrivendo
            //e apparirà mentre scriviamo
            onChanged: (newValue) {
              tagKey.currentState?.validate();
            },
            autofocus: true,
          ),
          
          const SizedBox(height: 24),
          bottone_elevato(
            child: const Text('Add'),
            onPressed: () {
              if (tagKey.currentState?.validate() ?? false) {
                Navigator.pop(context, tagC.text.trim());
              }
            },
          ),
        ],
      ),
    );
  }

}