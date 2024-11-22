// Importamos las librerías necesarias para usar Material Design y nuestro archivo de colores personalizados.
import 'dart:convert';

import 'package:campoazul_app/api_connection/api_connection.dart';
import 'package:campoazul_app/users/authentication/register_screen.dart';
import 'package:campoazul_app/users/authentication/sign_in.dart';

import 'package:campoazul_app/users/fragmentos/dashboard_of_fragments.dart';
import 'package:campoazul_app/users/model/user.dart';
import 'package:campoazul_app/users/userPreferences/user_preferences.dart';
import 'package:campoazul_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;


//ESTA SERA LA VENTANA DE BIEVENIDA DONDE ESTARAN LAS OPCIONES PARA REGISTRARSE Y INGRESAR SON DOS BOTONES QUE LOS ENLAZARAN A SUS PANTALLAS NECESARIAS


// Definimos una clase 'LoginScreen' que es un StatefulWidget, lo que significa que puede mantener un estado mutable.
// /y representa la pamntalla de inisio se sesion
class LoginScreen extends StatefulWidget {
  // Constructor para 'LoginScreen' con una clave opcional.
  const LoginScreen({super.key});






  // Creamos el estado para 'LoginScreen'. Este estado manejará la lógica y la interfaz.
  @override
  _LoginScreenState createState() => _LoginScreenState();
}



// Esta clase define el estado de 'LoginScreen'.
class _LoginScreenState extends State<LoginScreen> {
  // Variables booleanas que indicarán si los botones de "Registrarse" o "Iniciar Sesión" están siendo presionados.
  bool isRegisterPressed = false;
  bool isLoginPressed = false;

  //creamos nuestros estados de controller para login
  var formkey = GlobalKey<FormState>();
  var emailController= TextEditingController();
  var passwordController = TextEditingController();










  // El método 'build' es donde definimos la interfaz de usuario de esta pantalla.
  @override
  Widget build(BuildContext context) {
    // Obtenemos el tamaño de la pantalla del dispositivo para poder usarlo en el diseño.
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // 'Scaffold' proporciona una estructura básica para la pantalla, incluyendo cosas como un AppBar, body, etc.
      body: Container(
        // Definimos el color de fondo de la pantalla usando 'backgroundColor1' de nuestro archivo de colores.
        color: backgroundColor1,
        // Establecemos la altura y el ancho del contenedor para que cubra toda la pantalla.
        height: size.height,
        width: size.width,
        // Usamos un Stack para apilar widgets unos encima de otros.
        child: Stack(
          children: [
            // Alineamos este contenedor en la parte superior central de la pantalla.
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                // Establecemos la altura en un 53% de la altura total de la pantalla.
                height: size.height * 0.53,
                // El ancho del contenedor es igual al ancho de la pantalla.
                width: size.width,
                // Le damos al contenedor un fondo de color y bordes redondeados en la parte inferior.
                decoration: BoxDecoration(    // COLOR FONDO CONTAINER CAJA aca es el color de fondo de nuestro container o caja en donde va nuestra imagen de muñequitos
                  color: colorarAndano,        //nuestro color personalizado que creamos en colors.dart
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  // Agregamos una imagen de fondo al contenedor.
                  image: const DecorationImage(
                    image: AssetImage("images/3dpersonas.png"),
                  ),
                ),
              ),
            ),
            // Posicionamos otro contenedor en la parte inferior, pero desplazado hacia arriba un poco.
            Positioned(  // este widget se utiliza dentro de un stack para colocar un widget en una posicion especifica en su contenedor
              top: size.height * 0.6, //el contenedor se posiciona a un 60& de la altura total de la pantalla desde la parte superior y se desplaza el contenedor hacia abajo en la pantalla
              left: 0,  //lef y right alinean el contenedor a ambos lados de la pantalla, ocupando todo el ancho disponible
              right: 0,
              // Centramos el contenido dentro del contenedor.
              child: Center(// el contenido dentro del contenedor se centra horizontalmente
                // Usamos una columna para organizar widgets verticalmente.
                child: Column(  // este Widget Column se usa para organizar widgets verticalmente
                  children: [
                    // Primer texto que será el título de la pantalla.
                    Text(
                      "¡Amor por\nlos Arándanos!",  //salto de linea \n esencial para dar como un ennter  que aparezca de bajo de amor por
                      textAlign: TextAlign.center,// el texto se alinea al centro horizontalmente
                      style: TextStyle(    // define el estilo del texto
                        fontWeight: FontWeight.bold,    // aplica negrita al texto
                        fontSize: 40,        //establece el tamaño de la fuente a 40
                        color: textColor1,  // aplica un color al texto definido por la variable que creamos en la pantalla colors
                        height: 1.2,      // define la altura de la linea, el espacio vertical entre las lineas de textp
                      ),
                    ),
                    // Espaciado vertical entre el título y el siguiente texto.
                    const SizedBox(height: 25),
                    // Segundo texto que describe la empresa o la aplicación.
                    Text(
                      "Cultivamos, distribuimos arándanos y sus derivados. Descubre nuestros productos.",
                      textAlign: TextAlign.center,   // ainea el texto al centro
                      style: TextStyle(    //stilo
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: textColor2,  //llamamos nuestra varuiable de colors
                        height: 1.2,
                      ),
                    ),

                    // Más espaciado para separar los textos de los botones.

                    SizedBox(height: size.height * 0.07), //espacio vertical de 7% de altura total de la pantalla
                    // Padding horizontal para agregar un margen en los lados de los botones.
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),   // añade un margen de 30 pixeles a ambos lados izquiero y derecho
                      //de la fila de bototnes, asegura que los botones no toquen los bordes de la pantalla

                      child: Row(  // widget organiza a sus hijos de manera horizontal, unos al lado del otro
                        // Usamos una fila para mostrar los botones de "Registrarse" e "Iniciar Sesión" uno al lado del otro.
                        children: [
                          // Primer botón "Registrarse" con animación al presionar.
                          Expanded(
                            // Expanded hace que el botón  registrar ocupe el espacio disponible en la fila.
                            child: GestureDetector(  // detecta interacciones tactiles, cuando el usuario presiona el boton
                              // Detectamos cuando el usuario presiona el botón.
                              onTapDown: (_) { // define lo que ocurre cuando el usuario presiona el boton
                                setState(() {
                                  isRegisterPressed = true;
                                });
                              },
                              // Detectamos cuando el usuario levanta el dedo después de presionar el botón.
                              onTapUp: (_) {     // define lo que ocurre cuando el usuario suelta el boton  , navegar a otra pantalla o mostrar mensaje
                                setState(() {
                                  isRegisterPressed = false;
                                });
                                // conexion a la ventana de registro register_screen
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen(),),);   // aca nos dirige a la ventana de register_screen
                              },
                              // Si el usuario cancela la acción (por ejemplo, desliza el dedo fuera del botón), restauramos el estado.
                              onTapCancel: () {  // ontapcancel si el usuario cancela la accion ej desliza el dedo fuera de boton el estado se restablece para indicar que ya no esta presionado
                                setState(() {
                                  isRegisterPressed = false;
                                });
                              },
                              // El AnimatedContainer cambia de color cuando el botón se presiona, creando un efecto visual.
                              child: AnimatedContainer(   // este widget permite cambiar el estilo como el color con una animacion suave
                                // aqui el color del contenedor cambia cuando el boton es presionado le da como un estilo al boton cuando lo presionan
                                duration: const Duration(milliseconds: 100),   // la animacion del boton dura 100 milisegundos
                                height: size.height * 0.08,  // el boton tiene una altura equivalente al 8 % de la altura total de la pantalla
                                decoration: BoxDecoration(      // define la apariencia visual del cotenedor
                                  color: isRegisterPressed     // cambia el color del boton segun el estado de isregisterpressed
                                      ? backgroundColor3.withOpacity(0.8)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(15),   // redondea las esquinas del boton con un radio de 15 pixeles
                                  boxShadow: [   // añade una sombra al boton para darle un efecto de elevacion
                                    BoxShadow(
                                      color: Colors.black12.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                // Texto dentro del botón.
                                child: Center(     // centra el texto dentro del boton
                                  child: Text(
                                    "Registrarse",   // el texto dentro del boton
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,   // texto en negrita
                                      fontSize: 18,   //tamaño fuente
                                      color: textColor1,    //color texto
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Espaciado entre los dos botones.
                          const SizedBox(width: 10),
                          // Segundo botón "Iniciar Sesión" con animación al presionar.

                          Expanded(
                            child: GestureDetector(
                              onTapDown: (_) {
                                setState(() {
                                  isLoginPressed = true;
                                });
                              },
                              onTapUp: (_) {     // es un callback que se ejecuta cuando el usuario levanta el dedo de la pantalla después de tocar el widget..
                                setState(() {  //  es una función que Flutter proporciona para notificar al framework que el estado del widget ha cambiado, lo que provoca que el widget se vuelva a construir (actualizar) con el nuevo estado.
                                  isLoginPressed = false;  //Dentro de setState, se está actualizando el estado de isLoginPressed, estableciéndolo en false.
                                  // Esto indica que el botón de "Iniciar Sesión" ya no está siendo presionado.
                                });


                                // esta linea es fundamental ya que cuando den clic en el boton de iniciar sesion nos dirigira a la pantalla de inisio de sesion
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignIn(),),);
                              },
                              onTapCancel: () {
                                setState(() {

                                });
                              },
                              //aniamcion boton cuando es presionado o clic
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: size.height * 0.08,
                                decoration: BoxDecoration(
                                  color: isLoginPressed
                                      ? Colors.green.withOpacity(0.8) // Color cuando está en modo "registrar"
                                      : colorarAndano, // Color predeterminado
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                //texto boton iniciar sesion
                                child: const Center(
                                  child: Text(
                                    "Iniciar Sesión",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Espacio adicional antes del texto de créditos.
                    const SizedBox(height: 25),
                    Center(
                      child: Text(
                        "Desarrollado por Daniel Rodriguez (Crypto Milovat).",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: textColor2,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
