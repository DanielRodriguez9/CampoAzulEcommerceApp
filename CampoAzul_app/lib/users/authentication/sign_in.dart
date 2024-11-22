import 'dart:convert';

import 'package:campoazul_app/api_connection/api_connection.dart';
import 'package:campoazul_app/users/authentication/register_screen.dart';
import 'package:campoazul_app/users/fragmentos/dashboard_of_fragments.dart';
import 'package:campoazul_app/users/model/user.dart';
import 'package:campoazul_app/users/userPreferences/user_preferences.dart';
import 'package:campoazul_app/utils/colors.dart'; //importamos la pantalla colors.dart que contiene nuestros colores personalizadpos
import 'package:flutter/material.dart'; //paquete principal de flutter para la creacion de interfases de usuario UI con widgets y clases
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // este paquete nos toco descargarlo y ponerlo en nuestro pubspec.ymal importante ponerlo ahi en dependences y nos da iconos para la app
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart'; // este paquete tambien lo descargamos desde el sitio oficial  de dart  y toca seguir el proceso de instalacion en la documentacion de launcher dart nos permite abrir URLs en un navegador web desde la aplicacion
import 'login_screen.dart'; // aqui importamos nuestra pantalla de LoginScreen y permite la navegacion entre pantallas en este caso con nuesyra pantalla principal
import 'package:http/http.dart' as http;

//*
// final: La palabra clave final se utiliza para declarar una variable que solo puede ser asignada una vez. Después de asignarla, no puedes cambiar su valor. Es útil cuando sabes que el valor de la variable no debe cambiar durante la ejecución del programa.
//
// Uri.parse: La función Uri.parse convierte una cadena de texto (string) en un objeto Uri. Un Uri es una forma estandarizada de representar direcciones web (URLs) en Flutter.
//
// Variables _facebookUrl, _instagramUrl, _xUrl: Estas variables almacenan las URLs de las redes sociales que se quieren abrir desde la app. Al ser declaradas como final, aseguramos que estas URLs no cambiarán una vez asignadas.
//
// ¿Por qué final?
// Usamos final porque estas URLs son constantes dentro del contexto de la aplicación. Una vez que se asignan, no es necesario ni recomendable cambiarlas, lo que evita errores y mantiene la integridad de las URL.
// *
final Uri _facebookUrl = Uri.parse(
    "https://www.facebook.com/cryptomilovatCEO"); // creamos el metodo de esto en la parte de abajo toco para cada icono de red social
final Uri _instagramUrl =
    Uri.parse('https://www.instagram.com/cryptomilovattech');
final Uri _xUrl = Uri.parse("https://x.com/CryptoMilovat");

class SignIn extends StatefulWidget {
  // widget con esyado, esta panalla puede cambiar dinamicamente en funcion de las interacciones del usuario
  const SignIn(
      {super.key}); // es el constructor de la clase SignIn, la palabra clave const indica que el widget es inmutable

  @override
  _SignInState createState() =>
      _SignInState(); // estado asociado al widget SignIn, aqui de defnen las variables y la logica que pueden cambiar la UI
}

class _SignInState extends State<SignIn> {
  // estado asociado al widget SignIn aqui se define la b
  bool _isObscure =
      true; // Controla la visibilidad de la contraseña para mostrarse o estar oculto con asteriscos o puntos

  bool isLogin =
      false; // controla el estado del boton DE INICIAR SESION lo iniciamos con false apagado

  //creamos nuestros estados de controller para login
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // funcion para loginuser cuando den clic en el boton de inicio de sesion

  loginUserNow() async {
    try {
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          'user_email': emailController.text.trim(),"user_password": passwordController.text.trim(),
        },
      );

      print("Response Body: ${res.body}"); // Imprime la respuesta completa

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);

        // Verifica si la clave 'success' existe y es true
        if (resBodyOfLogin.containsKey('success') && resBodyOfLogin['success'] == true) {
          Fluttertoast.showToast(msg: "Felicitaciones, haz ingresado correctamente");// Verifica si la clave 'userData' existe antes de acceder a ella
          if (resBodyOfLogin.containsKey('userData')) {
            User userInfo = User.fromJson(resBodyOfLogin["userData"]);
            await RememberUserPrefs.saveRememberUser(userInfo);

            Future.delayed(const Duration(milliseconds: 2000), () {
              Get.to(DashboardOfFragments());
            });
          } else {
            // Manejar el caso en que 'userData' no esté presente
            print("Error: 'userData' no encontrado en la respuesta.");
            Fluttertoast.showToast(msg: "Error en la respuesta del servidor.");
          }
        } else {
          Fluttertoast.showToast(
              msg: "Error, Por favor Corriga la contraseña\n o correo electronico.. Intente de nuevo!");
        }
      } else {
        // Manejar otros códigos de estado
        print("Error en la solicitud HTTP: ${res.statusCode}");
        Fluttertoast.showToast(msg: "Error en la conexión con el servidor.");
      }
    } catch (errorMsg) {
      print("Error ::" + errorMsg.toString());
      Fluttertoast.showToast(msg: "Error inesperado.");
    }
  }

  //metodo build este metodo se encarga de construir la pantalla UI
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; //OBTIENE EL TAMAÑO DE LA PANTALLA DEL DISPOSITIVO PAR AUTILIZARLO EN EL DISEÑO

    return Scaffold(
      // Proporciona la estructura basica de la pantalla como la barra de aplicacion el cuerpo y elementos visuales
      body: Container(
        // define un contenedor que cubre el cuerpo de la pantalla
        decoration: BoxDecoration(
          //Aplica un fondo con un gradiente de colores que va de backgroundColor2 a backgroundColor4.
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              backgroundColor2,
              backgroundColor2,
              backgroundColor4,
            ],
          ),
        ),
        child: SafeArea(
          //Asegura que el contenido no se superponga con áreas como la barra de estado o la muesca de la pantalla.
          child: Form(
            key: formkey,
            child: ListView(
              //Una lista desplazable que contiene todos los elementos de la pantalla.
              padding: EdgeInsets.symmetric(horizontal: 25),
              // Aplica un relleno horizontal de 25 píxeles a ambos lados.
              children: [
                SizedBox(height: size.height * 0.03),

                // Texto "¡Hola de Nuevo!"
                Text(
                  "¡Hola de Nuevo!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 37,
                    color: colorarAndano,
                  ),
                ),

                const SizedBox(height: 25),

                // Frase sobre redes sociales de síguenos
                Text(
                  "Inicia sesion para\nexplorar nuestros deliciosos productos\nde arándanos y realizar tus compras.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: textColor2,
                    height: 1.2,
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                // funcion  Campo de texto para el nombre de usuario primer parametro es el texto, el segundo el color, y el tercero indica
                // si es un campo de texto normal o una contraseña en este caso false ifnifica que no es una contraseña
                myTextField("Digite su nombre de usuario", Colors.white, false),

                // Campo de texto para la contraseña con opción de mostrar/ocultar
                //true indica que es un campo de contraseña y por lo tanto se aplicara la opcion de mostrar u ocultar el texto
                myTextField(" Digite su contraseña", Colors.black26, true),

                const SizedBox(height: 10),

                // " TEXTO Recuperar Contraseña" alineado a la derecha con clic que lo direcciona a la pantalla de registrase
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 27.0),
                    child: InkWell(
                      onTap: () {
                        print('¡Recuperar Contraseña presionado!');
                      },
                      child: Text(
                        "Recuperar Contraseña",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: textColor2,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                // Botón de "Iniciar Sesión"

                Column(
                  children: [
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                            loginUserNow();
                            // Cambiar el estado para actualizar la apariencia del botón
                            setState(() {
                              isLogin = !isLogin;
                            });
                          }
                        },
                        borderRadius: BorderRadius.circular(15),
                        splashColor: Colors.white.withOpacity(0.4),
                        highlightColor: Colors.white.withOpacity(0.2),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                            color: isLogin
                                ? Colors.green.withOpacity(
                                    0.8) // Color cuando está en modo "registrar"
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
                          child: const Center(
                            child: Text(
                              "Iniciar Sesion",
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

                SizedBox(height: size.height * 0.03),
                // Espacio entre el botón y el texto

                // Texto "¿No tienes cuenta? Regístrate" con "Regístrate" en color azul y en negrita

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "¿No tienes cuenta? ",
                      style: TextStyle(
                        fontSize: 15,
                        color: textColor2,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Acción al presionar "Regístrate"
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                        // Puedes añadir navegación a la pantalla de registro aquí
                      },
                      child: Text(
                        "Regístrate",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .blue, // Color azul para el texto "Regístrate"
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.05),

                // Iconos de redes sociales
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: _launchFacebook, // Abre Facebook
                      child: Icon(
                        FontAwesomeIcons.facebook,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        _launchx();
                      },
                      child: Icon(
                        FontAwesomeIcons.x,
                        size: 30,
                        color: Colors.lightBlue,
                      ),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: _launchInstagram, // Abre Instagram
                      child: Icon(
                        FontAwesomeIcons.instagram,
                        size: 30,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 64),
                // espacio entre redes sociales y y flecha de regreso

                buildBackArrow(context, colorarAndano),
                // Reemplaza 'Colors.blue' con el color que desees.  //aca ponemos la flecha de regresodejbajo de redes sociales
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Este es el widget de regreso de la flecha de regreso boton de regreso

  Widget buildBackArrow(BuildContext context, Color iconColor) {
    return Align(
      alignment: Alignment.topCenter, //aqui pusimos al boton en modo centro
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: Container(
          padding: EdgeInsets.all(10),
          //tamaño de la soombra circular morada de la flecha
          decoration: BoxDecoration(
            //color: Colors.transparent,
            shape: BoxShape.circle, // forma  del circulo que va con la flecha
            color: colorarAndano,
          ),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            // Puedes personalizar el color de la flecha aquí
            size: 45, //tamaño de la flecha de regreso
          ),
        ),
      ),
    );
  }

  // Función para lanzar Facebook la declaramos en la parte inicial del codgio con final con launcher que es epecial para conectarse a redes URL
  // ir a la documentacion de flutter o dart y buscar la instalacion del apquete launcher y hacer el proceso de isntalacion
  Future<void> _launchFacebook() async {
    if (!await launchUrl(_facebookUrl)) {
      throw Exception("Could not launch $_facebookUrl");
    }
  }

  // Función para lanzar Instagram
  Future<void> _launchInstagram() async {
    if (!await launchUrl(_instagramUrl)) {
      throw Exception("Could not launch $_instagramUrl");
    }
  }

  // Función para lanzar X
  Future<void> _launchx() async {
    if (!await launchUrl(_xUrl)) {
      throw Exception("Could not launch $_xUrl");
    }
  }

  // Diseño para cajas de texto como username y password en la ventana de login

  Container myTextField(String hint, Color color, bool isPassword) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      child: TextField(
        obscureText: isPassword ? _isObscure : false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 22,
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 15,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
