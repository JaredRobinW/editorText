import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidPrincipal extends StatelessWidget{
  const WidPrincipal({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Editor de texto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.red,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.roboto().fontFamily,
        colorSchemeSeed: Colors.grey,
        brightness: Brightness.dark,
      ),
    home: const principal(),
    );
  }
}

class principal extends StatefulWidget{
  const principal({super.key});

  @override
  State<principal> createState() => _EstadoP();
}

class _EstadoP extends State<principal>{
  int currentPageIndex = 0;
  int largeScreen = 700;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Editor de texto',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.greenAccent),
          )
        ),

      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){},
          icon: const Icon(Icons.add),
          label: const Text('Nuevo archivo')),
    );
  }
}