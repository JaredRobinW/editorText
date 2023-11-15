import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';


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
      home: const Principal(),
    );
  }
}

class Principal extends StatefulWidget{
  const Principal({super.key});
  

  @override
  State<Principal> createState() => _EstadoP();
}

class _EstadoP extends State<Principal>{

  int largeScreen = 700;
  List <File> files = [];

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? filePaths = prefs.getStringList('files');
    if (filePaths != null) {
      setState(() {
        files = filePaths.map((path) => File(path)).toList();
      });
    }
  }

  Future<void> _saveFiles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> filePaths = files.map((file) => file.path).toList();
    prefs.setStringList('files', filePaths);
  }


  @override 

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Center(
            child: Text('Editor de texto',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color : Colors.white),
            ),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 20.0),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
              onPressed: () => _createFile(),
              child: const Text('Crear archivo')
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
    String fileName = 'Archivo_${DateTime.now().millisecondsSinceEpoch}.txt';
    File file = File('${(await getApplicationDocumentsDirectory()).path}/$fileName');
    await file.writeAsString('');
    setState(() {
      files.add(file);
    });
    _saveFiles();
  }

  Future<void> _openFileEditor(File file) async {

    String filePath = file.path;
    String fileContent = await File(filePath).readAsString();

    TextEditingController _textEditingController = TextEditingController();
    _textEditingController.text = fileContent;

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),

              const Text(
                'Contenido del Archivo',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 25.0),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Escriba aqui!!!',
                  contentPadding: EdgeInsets.all(10.0),
                ),
                controller: _textEditingController,
                maxLines: null,
              ),

              const SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {
                  String content = _textEditingController.text;
                  file.writeAsString(content);
                  Navigator.pop(context);
                },
                child: const Text('Guardar'),
              ),

              const SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
              
              const SizedBox(height: 12.0),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: (){
                file.deleteSync();
                setState(() {
                  files.remove(file);
                });
                Navigator.pop(context);
              },
                  child: const Text('Eliminar'))
            ],
          )
        );
      },
    );
  }
}