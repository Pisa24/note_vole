import 'package:flutter/material.dart';
import 'package:note_vole/Widgets/oggetto_bottone_elevato.dart';
import 'package:note_vole/Widgets/oggetto_tag_finestra.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return finestra_tag(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              bottone_elevato(
               onPressed: () => Navigator.pop(context, false),
               isOut: true,
               child: const Text('No'),
              ),
              const SizedBox(width: 8),
              bottone_elevato(
               child: const Text('Yes'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
        ],
      ),
    );
  }
}