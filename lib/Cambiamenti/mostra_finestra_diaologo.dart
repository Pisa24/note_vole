import 'package:flutter/material.dart';
import 'package:note_vole/Widgets/conferma_finestra_dialogo.dart';
import 'package:note_vole/Widgets/finestra_dialogo.dart';
import 'package:note_vole/Widgets/messaggio_dialogo.dart';

Future<String?> showNewTagDialog({
  required BuildContext context,
  String? tag,
}) {
  return showDialog<String?>(
    context: context,
    builder: (context) => nuova_finestra_dialogo(tag: tag),
  );
}

Future<bool?> showConfirmationDialog({
  required BuildContext context,
  required String title,
}) {
  return showDialog<bool?>(
    context: context,
    builder: (_) => ConfirmationDialog(title: title),
  );
}

Future<bool?> showMessageDialog({
  required BuildContext context,
  required String message,
}) {
  return showDialog<bool?>(
    context: context,
    builder: (_) => MessageDialog(message: message),
  );
}