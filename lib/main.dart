import 'package:wigilabsSpotify/paginas/login/loginUsuario.dart';
import 'package:wigilabsSpotify/paginas/login/pantallaEspera.dart';
import 'package:wigilabsSpotify/paginas/login/resgistroUsuario.dart';
import 'package:wigilabsSpotify/paginas/spotify/artistasSpotify.dart';
import 'package:wigilabsSpotify/paginas/spotify/homeUsuarioSpotify.dart';
import 'package:wigilabsSpotify/paginas/spotify/playlistSpotify.dart';
import 'package:flutter/material.dart';

import 'proveedores/preferenciasUsuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final prefs = new PreferenciasUsuario();
  @override
  void initState() {
    //Config uracion de notificaciones push
    super.initState();

    //temporal order to check if user has a current order

    //checking the user data save in device

    //initialize the push notification provider
    // pushProvider.initNotifications();
    // pushProvider.messages.listen((data) {
    //   if (data == 'cancel') {
    //     navigatorKey.currentState.pushNamed('services');
    //   }
    //   if (data == 'taken') {
    //     navigatorKey.currentState.pushNamed('orderProccess');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: _ruta(),
      navigatorKey: navigatorKey,
      routes: {
        'login': (context) => new LoginPagina(),
        'registro': (context) => new RegistroCorreo(),
        'espera': (context) => new EsperaPantalla(),
        'home': (context) => new HomePagina(),
        // '/tracks': (BuildContext context) => new TracksScreen(),
        '/artistas': (BuildContext context) => new ArtistasScreem(),
        '/playlistCategorias': (BuildContext context) =>
            new PlaylistCategoria(),
      },
    );
  }

  // Esta funcion retorna una ruta dependiendo si el usuario esta o no logeado
  _ruta<String>() {
    final userPreferences = new PreferenciasUsuario();
    // Rutas Switch
    var route;
    if (userPreferences.login != false) {
      route = 'espera';
      return route;
    } else {
      route = 'login';
      return route;
    }
  }
}
