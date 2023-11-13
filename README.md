# Almacenamiento de Archivos (edición de un archivo de texto)

Robinson Donoso Zacconi 20.158.880-4 Desarrollador.

Manuel Montecinos Sias 19.298.779-2 Diseñador.

Carolina Robles Fuentes 20.150.384-1 Arquitecto.

# Caso de Uso.

El caso de uso seleccionado es la edición de un archivo de texto,
el cual se trabajó en una app en la cual se trabajan dichos archivos en una modalidad de block de notas, 
para que estos archivos puedan ser trabajados.

# Diseño.

Se busco un diseño lo más amigable posible con el usuario el cual cuenta con botones los cuales le permiten al usuario 
realizar las distintas acciones disponibles en la aplicación. En la pantalla inicial se pueden observar una lista con los
archivos anteriormente creados y en la parte superior un botón con el cual se crean nuevos archivos. Una vez se ingresa a un
archivo anteriormente creado o se crea uno nuevo, se ve una pestaña que contiene el texto a ingresar y el texto anteriormente
guardado en caso de este existir, en la parte inferior de la pestaña de texto se observan tres botones, el botón de guardado,
el botón cerrar y finalmente el botón eliminar.


# Implementación.

## Tutorial: Implementación para manipular el almacenamiento de archivos de texto

En este tutorial aprenderemos a implementar una característica en Flutter que consiste en Almacenamiento de archivos.
En el cual se puedan crear, eliminar y editar archivos de texto que se almacenen localmente en el dispositivo en la
carpeta correspondiente

### Paso 1: Configuración del entorno de desarrollo 

`Asegúrate de tener Flutter y Dart instalados en tu sistema.`

### Paso 2: Creacion de un proyecto Flutter

Abre la terminal y ejecuta los siguientes comandos:
```
Flutter create <nombre_proyecto>
cd nombre_proyecto
```

### Paso 3: Implementación de principal.dart

Este archivo contiene la estructura de la aplicación, incluyendo el widget principal y el tema.

**Importaciones:**

Se importan los paquetes necesarios para Flutter
```
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
```

**Clase WidPrincipal:**


Define un widget de Flutter llamado WidPrincipal que extiende StatelessWidget.
Este widget se utiliza para configurar la apariencia general de la aplicación.
```
class WidPrincipal extends StatelessWidget{
  const WidPrincipal({super.key});
```

Implementa el método build, que devuelve la estructura principal de la aplicación.

```
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
```

**Clase principal:**


Define un widget de estado (StatefulWidget) llamado principal que tiene un estado mutable.

```
class principal extends StatefulWidget{
  const principal({super.key});
```

Implementa el método createState que devuelve una nueva instancia del estado _EstadoP asociado con este widget.

```
@override
  State<principal> createState() => _EstadoP();
}
```

**Clase _EstadoP:**


Define la clase _EstadoP, que extiende State y gestiona el estado mutable de principal. Declara dos variables de estado.

```
class _EstadoP extends State<principal>{
  int currentPageIndex = 0;
  int largeScreen = 700;
```
Implementa el método build, que devuelve la estructura de la interfaz de usuario para la pantalla principal.

```
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
```

### Paso 4: Implementación de main.dart

Este archivo contiene el punto de entrada de la aplicación (main), que inicializa y ejecuta la aplicación Flutter.

### Paso 5: Implementación de Myapp y WidPrincipal

En el archivo main.dart, asegúrate de que Myapp utiliza WidPrincipal como su widget principal.

**Importaciones:**

Se importan los paquetes necesarios para Flutter

```
import 'package:flutter/material.dart';
import 'package:appp1/front/principal.dart';
```

**Funcion main:**


Define la función principal main, que se ejecutará al iniciar la aplicación. Dentro de esta función, se llama a runApp con una instancia del widget Myapp como argumento.
```
void main(){
  runApp(const Myapp());
}
```
**Clase Myapp:**


Define un widget de Flutter llamado Myapp que extiende StatelessWidget. Este widget se utiliza para configurar la aplicación a nivel global. Define un constructor para Myapp.

```
class Myapp extends StatelessWidget{
  const Myapp({super.key});
```

Implementa el método build, que devuelve la estructura principal de la aplicación.

```
@override
  Widget build(BuildContext context){
    return const WidPrincipal(
    );
  }
}
```


### Paso 6: Ejecutar la aplicación

Guarda todos los archivos y ejecuta tu aplicación Flutter con el siguiente comando:
```
Flutter run
```


# Arquitectura.

## Estructura de archivos

- editorText
  - lib/
    - main.dart
    - front
      - crearAr.dart
      - principal.dart
  - README.md  

## Arquitectura de Software:

**Modelo:**

En este caso específico, la aplicación no incluye una lógica de modelo compleja. 
**Vista:**

WidPrincipal y principal son los componentes visuales clave. WidPrincipal configura la apariencia general de la aplicación, 
y principal representa la pantalla principal con una barra de aplicación y un botón flotante.
**Controlador:**

Para esta aplicación, el controlador sería responsable de manejar la lógica del botón flotante, como la creación de nuevos archivos, la edición y eliminacion de estos.

## Diagrama de Arquitectura (Conceptual):
En el contexto de Flutter y dado que estamos tratando con una aplicación relativamente simple, la arquitectura no requiere capas demasiado complejas. 
La comunicación entre las partes clave se gestiona principalmente a través de la jerarquía de widgets.

<img src="https://github.com/JaredRobinW/editorText/blob/main/Imagen1.png" alt="Diagrama de Arquitectura" width="200" style="display: block; margin: auto;"/>


   En donde: 
    - **MyApp:** Punto de entrada principal de la aplicación que instancia WidPrincipal.
    - **WidPrincipal:** Configura la apariencia general de la aplicación y contiene el tema.
    - **Principal:** Representa la pantalla principal con la barra de aplicación y el botón flotante.
