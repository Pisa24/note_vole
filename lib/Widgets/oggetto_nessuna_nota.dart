import 'package:flutter/material.dart';

class NessunaNota extends StatelessWidget {
  const NessunaNota({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/mano1.png',
            width: MediaQuery.sizeOf(context).width *1
            
          ),
          const SizedBox(height: 32,),
          const Text('Aggiungi una nota',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Fredoka'
          ),
          textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
