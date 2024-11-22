import 'package:flutter/material.dart';

//En Dart, los colores se especifican como enteros hexadecimales precedidos por 0x, y no puedes usar el símbolo # en este contexto.
//
// Forma Correcta de Definir Colores
// Para definir colores en Flutter, debes usar el prefijo 0x seguido del código de color en hexadecimal. El formato correcto es:

//quí, 0xff es un prefijo que indica que el valor siguiente es un color en formato ARGB (Alpha, Red, Green, Blue) y 5b1c9a es el valor hexadecimal del color.


//Explicación de la Notación de Color
// 0xff indica que estás usando el formato ARGB (donde ff representa el valor del canal alfa, que es completamente opaco en este caso).
// Los siguientes 6 dígitos (D897FD, 353047, 6F6B7A, 5b1c9a) representan los valores de los canales de color RGB.
// Resumen
// Usa 0xff para especificar colores en formato hexadecimal en Flutter.
// Asegúrate de que el código de color esté en el formato 0xffRRGGBB, donde RR, GG, y BB son valores hexadecimales para los componentes rojo, verde y azul, respectivamente.



Color backgroundColor1 = const Color(0xffE9EAF7);
Color backgroundColor2 = const Color(0xffF4EEF2);
Color backgroundColor3 = const Color(0xffEBEBF2);
Color backgroundColor4 = const Color(0xffE3EDF5);

Color primaryColor = const Color(0xffD897FD);
Color textColor1 = const Color(0xff353047);
Color textColor2 = const Color(0xff6F6B7A);


Color colorarAndano = const Color(0xff4A148C);  // colo del arandano
