import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

List archs = [];

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

  int largeScreen = 700;
  List <File> files = [];

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
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () => _createFile(),
              child: Text('Crear archivo')
          ),
          Expanded(child: ListView.builder(
            itemCount: files.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(files[index].path.split('/').last),
                onTap: () => _openFileEditor(files[index]),
              );
            },
          ),
          ),
        ],
      ),
    );
  }
  Future<void> _createFile() async {
    String fileName = 'text_file_${DateTime.now().millisecondsSinceEpoch}.txt';
    File file = File('${(await getApplicationDocumentsDirectory()).path}/$fileName');
    await file.writeAsString('');
    setState(() {
      files.add(file);
    });
  }

  Future<void> _openFileEditor(File file) async {
    String filePath = file.path;
    String fileContent = await File(filePath).readAsString();

    TextEditingController _textEditingController = TextEditingController();
    _textEditingController.text = fileContent;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contenido del Archivo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _textEditingController,
                maxLines: null,
              ),
              SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: () {
                  String content = _textEditingController.text;
                  file.writeAsString(content);
                  Navigator.pop(context);
                },
                child: Text('Guardar'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cerrar'),
              ),
              ElevatedButton(onPressed: (){
                file.deleteSync();
                setState(() {
                  files.remove(file);
                });
                Navigator.pop(context);
              },
                  child: Text('Eliminar'))
            ],
          )
        );
      },
    );
  }
}
