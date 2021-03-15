import 'package:shared_preferences/shared_preferences.dart';

/*
  Clase que guarda en el Storage local los datos del usuario
*/

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del token
  get login {
    return _prefs.getBool('login') ?? false;
  }

  set login(bool value) {
    _prefs.setBool('login', value);
  }

  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }
}