import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_vole/constants.dart';

// ignore: camel_case_types
class bottone_fine_linea extends StatelessWidget {
  const bottone_fine_linea({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed, 
      icon:  FaIcon(icon),
      style: IconButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
         side: const BorderSide(
            
            color: black
          )
        ),
      );
  }
}