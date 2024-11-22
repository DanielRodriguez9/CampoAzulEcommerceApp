import 'dart:convert';

import 'package:campoazul_app/api_connection/api_connection.dart';
import 'package:campoazul_app/main.dart';
import 'package:campoazul_app/users/authentication/login_screen.dart';
import 'package:campoazul_app/users/authentication/sign_in.dart';
import 'package:campoazul_app/users/model/user.dart';
import 'package:campoazul_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordVisible = false; // Control de visibilidad de la contraseña

  //control de boton registro efecto
  bool isRegister = false;

  final formkey = GlobalKey<FormState>(); // Clave para el formulario
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Obtener tamaño de pantalla

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
          child: Form(
            // Envolvemos los campos en un Form para la validación
            key: formkey,
            child: ListView(
              children: [
                SizedBox(height: size.height * 0.03),
                _buildTitle(size),
                const SizedBox(height: 25),
                _buildSubtitle(),
                SizedBox(height: size.height * 0.03),
                _buildTextField(
                  controller: nameController,
                  hintText: "Digite su usuario",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su nombre de usuario';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  controller: emailController,
                  hintText: "Digite su correo electrónico",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un correo electrónico';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Por favor ingrese un correo válido';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  controller: passwordController,
                  hintText: "Digite su contraseña",
                  obscureText: !_isPasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su contraseña';
                    }
                    if (value.length < 6) {
                      return 'La contraseña debe tener al menos 6 caracteres';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.black45,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                _buildRegisterButton(context, size),
                SizedBox(height: size.height * 0.02),
                _buildSignInOption(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método que construye el título
  Widget _buildTitle(Size size) {
    return Text(
      "¡Únete a nosotros!",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 37,
        color: colorarAndano,
      ),
    );
  }

  // Método que construye el subtítulo
  Widget _buildSubtitle() {
    return Text(
      "Crea tu cuenta",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: textColor2,
        height: 1.2,
      ),
    );
  }

  // Método que construye un campo de texto reutilizable
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    required String? Function(String?) validator,
    Widget? suffixIcon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black45, fontSize: 15),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  // Botón para registrar usuario el buildregister lo creamos arriba en la parte inicial revisar
  Widget _buildRegisterButton(BuildContext context, Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: () {
            // Verificar si el formulario es válido
            if (formkey.currentState?.validate() ?? false) {
              validateUserEmail();
              // Cambiar el estado para actualizar la apariencia del botón
              setState(() {
                isRegister = !isRegister;
              });
            } else {
              Fluttertoast.showToast(
                msg: "Por favor complete todos los campos correctamente",
              );
            }
          },
          borderRadius: BorderRadius.circular(15),
          splashColor: Colors.white.withOpacity(0.4),
          highlightColor: Colors.white.withOpacity(0.2),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: size.height * 0.08,
            decoration: BoxDecoration(
              color: isRegister
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
            child: const Center(
              child: Text(
                "Registrarse",
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
    );
  }




  // Opción para iniciar sesión si ya tiene cuenta
  Widget _buildSignInOption(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "¿Ya tienes cuenta? ",
                style: TextStyle(fontSize: 15, color: textColor2),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignIn(),
                    ),
                  );
                },
                child: Text(
                  "Inicia sesión",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.13),
          buildBackArrow(context, Colors.white),
        ],
      ),
    );
  }

  // Flecha para regresar a la pantalla de bienvenida
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
          padding: EdgeInsets.all(10),  //tamaño de la soombra circular morada de la flecha
          decoration: BoxDecoration(
            //color: Colors.transparent,
            shape: BoxShape.circle,   // forma  del circulo que va con la flecha
            color: colorarAndano,
          ),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white, // Puedes personalizar el color de la flecha aquí
            size: 45,  //tamaño de la flecha de regreso
          ),
        ),
      ),
    );
  }

  Future<void> validateUserEmail() async {
    try {
      var res = await http.post(
        Uri.parse(API.validateEmail),
        body: {
          'user_email': emailController.text.trim(),
        },
      );

      // Imprimir respuesta para depurar
      print("Response status (validate email): ${res.statusCode}");
      print("Response body (validate email): ${res.body}");

      if (res.statusCode == 200) {
        var resBodyOfValidateEmail = jsonDecode(res.body);

        if (resBodyOfValidateEmail['emailFound'] == true) {
          Fluttertoast.showToast(
            msg: "Este correo electrónico ya existe. Intente con otro correo.",
          );
        } else {
          // Proceder con el registro si el correo no está en uso
          registerAndSaveUserRecord();
        }
      } else {
        Fluttertoast.showToast(
          msg: "Error en la validación del correo: ${res.statusCode}. ${res.body}",
        );
      }
    } catch (e) {
      print("Error en validateUserEmail: $e");
      Fluttertoast.showToast(msg: "Excepción en validateUserEmail: ${e.toString()}");
    }
  }


  // Función de registro de usuario simulada
  registerAndSaveUserRecord() async {
    User userModel = User(
      1,
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    try {
      var res = await http.post(
        Uri.parse(API.signUp),
        body: userModel.toJson(),
      );

      // Imprimir respuesta para depurar
      print("Response status: ${res.statusCode}");
      print("Response body: ${res.body}");

      if (res.statusCode == 200) {
        var resBodyOfSignup = jsonDecode(res.body);

        // Verificar si la clave 'success' está en la respuesta
        if (resBodyOfSignup['success'] == true) {
          Fluttertoast.showToast(msg: "¡Felicitaciones,Registro Exitoso!.");

          //para limpiar los campos de texto cuando sea el registro sea exitoso con la funcion setstate y el codigo clear
          setState(() {
            nameController.clear();
            emailController.clear();
            passwordController.clear();
          });


        } else {
          String errorMessage =
              resBodyOfSignup['message'] ?? "Error desconocido";
          Fluttertoast.showToast(msg: "Error: $errorMessage");
        }
      } else {
        // Mostrar el código de estado y el cuerpo de la respuesta para errores no 200
        Fluttertoast.showToast(msg: "Error: ${res.statusCode}. ${res.body}");
      }
    } catch (e) {
      // Mostrar cualquier excepción
      print("Error: $e");
      Fluttertoast.showToast(msg: "Excepción: ${e.toString()}");
    }
  }
}
