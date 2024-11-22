import 'dart:convert';
import 'package:campoazul_app/users/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs {
  // Método para guardar la información del usuario localmente
  static Future<void> saveRememberUser(User userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonData);
  }

  // Método para obtener el usuario guardado
  static Future<User?> getRememberedUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userJsonData = preferences.getString("currentUser");
    if (userJsonData != null) {
      return User.fromJson(jsonDecode(userJsonData));
    }
    return null; // Retorna null si no hay usuario guardado
  }

  // Método para borrar la información del usuario
  static Future<void> clearUserPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentUser");
  }
}
