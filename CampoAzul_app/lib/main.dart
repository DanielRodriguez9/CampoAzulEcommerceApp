import 'package:campoazul_app/users/authentication/login_screen.dart'; // Importa el widget LoginScreen desde tu proyecto.
import 'package:flutter/material.dart'; // Importa los widgets de Flutter.
import 'package:get/get.dart'; // Importa GetX para la gestión de estado y rutas.

void main() {

  WidgetsFlutterBinding.ensureInitialized();  //esto es para que cuando abramos la app  no salgan pantalla blanca o algo asi

  runApp(const MyApp()); // Ejecuta la aplicación con el widget MyApp como raíz.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor de MyApp que acepta una clave.

  // Método simulado para la carga de datos
  Future<void> _loadData() async {
    // Simula un retraso de 2 segundos para la carga de datos
    await Future.delayed(Duration(seconds: 2)); // Simula un retraso de 2 segundos.
    // Aquí puedes realizar operaciones de carga de datos reales, como solicitudes HTTP.
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Campo Azul App', // Título de la aplicación.
      debugShowCheckedModeBanner: false,  // esto es para que el banner de debug no salga de nuestra app es como un liston que esta y se quita jeje
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Define el esquema de colores de la aplicación.
        useMaterial3: true, // Usa Material 3 para el diseño.
      ),
      home: FutureBuilder(
        future: _loadData(), // Asigna el Future que se ejecutará para construir el widget.
        builder: (context, snapshot) {
          // Comprueba el estado del Future y construye el widget basado en él.
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Mientras se espera que el Future se complete.
            return const Center(child: CircularProgressIndicator()); // Muestra un indicador de carga. cuando se abre la app
          } else if (snapshot.hasError) {
            // Si ocurre un error mientras el Future se completa.
            return Center(child: Text('Error: ${snapshot.error}')); // Muestra el mensaje de error.
          } else {
            // Cuando el Future se completa con éxito.
            return const LoginScreen(); // Muestra el widget LoginScreen. nuestra ventana principal de opciones de inicio de sesion y registro
          }
        },
      ),
    );
  }
}
