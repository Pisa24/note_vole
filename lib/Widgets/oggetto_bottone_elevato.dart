import 'package:flutter/material.dart';
import 'package:note_vole/constants.dart';

// ignore: camel_case_types
class bottone_elevato extends StatelessWidget {
  const bottone_elevato({
    super.key,
   
   required this.child, this.onPressed, this.isOut = false,
  });

  
  final Widget child;
  final VoidCallback? onPressed;
  final bool isOut;

  @override
  Widget build(BuildContext context) {
    return  DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(offset: const Offset(2, 2),
              color: isOut? primary : black,
              ),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: isOut? white: primary,
      foregroundColor: isOut? primary: white,
      side:  BorderSide(
        color: isOut? primary :  black
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ), 
    child: Text(child.toString()),
          ),
          );
    
  }
}