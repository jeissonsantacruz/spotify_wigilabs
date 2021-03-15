import 'dart:async';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' show Client;

class AuthorizationApiProvider {
  Client client = Client();

  static String url = "https://accounts.spotify.com/authorize";
  static String clientId = "e896c879956242c5af64dc4e9c0e1d99";
  static String responseType = "code";
  static String redirectUri = "alarmfy:/";
  static String scope =
      "playlist-read-private playlist-read-collaborative";
  static String state = "34fFs29kd09";

  String urlDireccion = "$url" +
      "?client_id=$clientId" +
      "&response_type=$responseType" +
      "&redirect_uri=$redirectUri" +
      "&scope=$scope" +
      "&state=$state";
  
  Future<String> fetchCode() async {
    print(urlDireccion);
    final response = await FlutterWebAuth.authenticate(
        url: urlDireccion, callbackUrlScheme: "alarmfy");
    final error = Uri.parse(response).queryParameters['error'];
    if (error == null) {
      final code = Uri.parse(response).queryParameters['code'];
      return code;
    } else {
      print("Error al autenticar");
      return error;
    }
  }
}
