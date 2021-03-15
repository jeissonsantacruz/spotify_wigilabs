import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

/* Classe que contiene todos los servicios de login*/
class ServiciosLogin {
  // Funcion que llama el API de firebase para iniciar o autenticarse con Google
  Future<void> googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);

      return user;
    } catch (e) {
      print(e.message);
    }
  }

  // Funcion que llama el API de firebase para iniciar o autenticarse con Facebook
  Future<void> signUpWithFacebook() async {
    try {
      var facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);

      if (result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        );
        final FirebaseUser user =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;

        return user;
      }
    } catch (e) {
      print(e.message);
      return null;
    }
  }

  // Funcion que llama el API de firebase para iniciar o autenticarse con Email
  Future<bool> signUpWithMail(String correo, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: correo, password: password);
      return true;
    } catch (e) {
      print(e.message);
      return false;
    }
  }
}

final String urlPrueba =
    'https://apiselfservice.co/api/index.php/v1/soap/LoginUsuario.json';

// {
//     "error": 1,
//     "response": "El Usuario ingresado no se encuentra registrado",
//     "secs": "00:00:00.1560",
//     "server": "Exception4",
//     "request": "{\"nombreUsuario\":\"a@a.aa\",\"clave\":\"Garay1362\"}",
//     "nodo": "10.3.0.12"
// }
class PruebaDatos {
  Future<Map<dynamic, dynamic>> listarPendientes() async {
    var data = {
      {"nombreUsuario": "a@a.aa", "clave": "Garay1362"}
    };

    var dataBody = {"data": json.encode(data)};
    var dio = Dio();
    final encodedData = FormData.fromMap(dataBody);
    // make POST request
    Response response = await dio.post(
      urlPrueba,
      data: encodedData,
      options: Options(
        headers: {"X-MC-SO": "WigilabsTest"},
      ),
    );
    final decodeData = jsonDecode(response.data);

    print(decodeData);

    return decodeData;
  }

}
