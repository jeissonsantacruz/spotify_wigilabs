import 'dart:async';
import 'package:wigilabsSpotify/modelos/autorizacionModelo.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class AuthorizationTokenApiProvider {
  Client client = Client();
  static String clientId = "e896c879956242c5af64dc4e9c0e1d99";
  static String clientsecret ="90568b123f76475fa3d57c51651ab833";

  static String authorizationStr = "$clientId:$clientsecret";
  static var bytes = utf8.encode(authorizationStr);
  static var base64Str = base64.encode(bytes);

  String authorization= 'Basic ' + base64Str;

  var urlToToken = 'https://accounts.spotify.com/api/token';

  Future<AuthorizationModel> fetchToken(String code) async {
    var response = await client.post(urlToToken, body: {
      'grant_type': "authorization_code",
      'code': code,
      'redirect_uri': 'alarmfy:/'
    },headers: {'Authorization' : authorization});

    if (response.statusCode == 200) {
      return AuthorizationModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}