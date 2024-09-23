import 'package:flutter/material.dart';
import 'package:note_vole/Cambiamenti/cambiamento_nota.dart';
import 'package:note_vole/constants.dart';
import 'package:note_vole/Pagine/main_page.dart';
import 'package:provider/provider.dart';

void main() async{
  /*//widget che fa il binding...
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase mi ha fatto piangere, manegiare con cura
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);*/


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesProvider(),
      child: MaterialApp(
        title: 'NoteVole',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'Fredoka',
          //scaffoldBackgroundColor: black,
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
            backgroundColor: Colors.transparent,
            titleTextStyle: const TextStyle(
              color: primary,
              fontSize: 32,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              ),
            ),
          ),
        home: const MainPage(),
        ),
    );
  }
}

