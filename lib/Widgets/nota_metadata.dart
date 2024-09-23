import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_vole/Cambiamenti/controller_nuova_nota.dart';
import 'package:note_vole/Cambiamenti/mostra_finestra_diaologo.dart';
import 'package:note_vole/Models/modello_nota.dart';
import 'package:note_vole/Widgets/bottone_tendina.dart';
import 'package:note_vole/Widgets/oggetto_tag_nota.dart';
import 'package:note_vole/constants.dart';
import 'package:note_vole/date.dart';
import 'package:provider/provider.dart';


class NoteMetadata extends StatefulWidget {
  const NoteMetadata({
    required this.note,
    super.key,
  });
  final Nota? note;

  @override
  State<NoteMetadata> createState() => _NoteMetadataState();
}

class _NoteMetadataState extends State<NoteMetadata> {
  late final ControllerNuovaNota cNota;

  @override
  void initState() {
    super.initState();

    cNota = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.note != null) ...[
          Row(
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  'Ultima modifica',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: gray500,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  toLongDate(widget.note!.dataModifica),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: gray900,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  'Creata',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: gray500,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  toLongDate(widget.note!.dataCreazione),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: gray900,
                  ),
                ),
              ),
            ],
          ),
        ],
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  const Text(
                    'Tags',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: gray500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  BottoneTendina(
                    icon: FontAwesomeIcons.circlePlus,
                    onPressed: () async {
                      final String? tag =
                          await showNewTagDialog(context: context);

                      if (tag != null) {
                        cNota.addTag(tag);
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Selector<ControllerNuovaNota, List<String>>(
                selector: (_, cNota) => cNota.tags,
                builder: (_, tags, __) => tags.isEmpty
                    ?  const Text(
                        'Nessun tag',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: gray900,
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            tags.length,
                            (index) => NoteTag(
                              label: tags[index],
                              call: () {
                                cNota.removeTag(index);
                              },
                              onTap: () async {
                                final String? tag = await showNewTagDialog(
                                  context: context,
                                  tag: tags[index],
                                );
                                //se hai creato un tag, salvalo
                                if (tag != null && tag != tags[index]) {
                                  cNota.updateTag(tag, index);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

