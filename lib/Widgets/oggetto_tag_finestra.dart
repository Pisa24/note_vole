import 'package:flutter/material.dart';
import 'package:note_vole/constants.dart';

// ignore: camel_case_types
class finestra_tag extends StatelessWidget {
  const finestra_tag({
    
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    //center cosi sta piccolo e al centro
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          //apprezzabile all'occhio
          width: MediaQuery.sizeOf(context).width*0.75,
          //cosi se sposta quando si apre la tastiera
          margin: MediaQuery.viewInsetsOf(context),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: white,
            border: Border.all(width: 2, color: black),
            boxShadow: const [BoxShadow(
            offset: Offset(5, 5),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
          ),
          child: child,
        )),
    );
  }
}

