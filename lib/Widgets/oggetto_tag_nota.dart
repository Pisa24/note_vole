import 'package:flutter/material.dart';
import 'package:note_vole/constants.dart';

class NoteTag extends StatelessWidget {
  const NoteTag({
    super.key, required this.label, this.call, this.onTap,
  });

  final String label;


  //per cancellare i tag
  final VoidCallback? call;


  //per capi se hai cliccato
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: gray100
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 2,
            ),
            margin: const EdgeInsets.only(right: 4),
          child:  Row(
            children: [
              Text(
                label,
                 style:  TextStyle(
                  //grande se 
                  fontSize: call !=null ? 14: 12,
                  color: gray700,
                 )
                 ),
                 if(call != null) ...[
                  const SizedBox(width: 4,),
                  GestureDetector(
                    onTap: call,
                    child: const Icon(Icons.close,
                    size: 18,))
                 ]
            ],
          ),),
    );
  }
}