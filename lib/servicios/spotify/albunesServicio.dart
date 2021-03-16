import 'dart:async';

import 'package:firebaseauth/modelos/albunes.dart';
import 'package:firebaseauth/modelos/autorizacion.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AlbunesServicio {
  Client client = Client();

  Future<Albunes> fetchAlbunes(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accesstoken = prefs.getString('access_token');
    String tokentype = prefs.getString('token_type');

    String authorizationWithToken = '$tokentype $accesstoken';
    var response = await client.get(url,headers: {'Authorization' : authorizationWithToken});
    
    //SI SE NECESITA NUEVO TOKEN
    if (response.statusCode == 401) {
      String refreshtoken = prefs.getString('refresh_token');
      String clientid = "e896c879956242c5af64dc4e9c0e1d99";
      String clientsecret ="90568b123f76475fa3d57c51651ab833";
      String authorizationStr = "$clientid:$clientsecret";
      var bytes = utf8.encode(authorizationStr);
      var base64Str = base64.encode(bytes);
      String authorization= 'Basic ' + base64Str;
      var responseNewToken = await client.post("https://accounts.spotify.com/api/token", body: {
        'grant_type': 'refresh_token',
        'refresh_token': refreshtoken,
        'redirect_uri': 'alarmfy:/'
      },headers: {'Authorization' : authorization});

      if (responseNewToken.statusCode == 200) {
        
        AuthorizationModel aM =  AuthorizationModel.fromJson(json.decode(responseNewToken.body));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('access_token', aM.accessToken);
        prefs.setString('token_type', aM.tokenType);
        prefs.setBool('logged', true);

        accesstoken = prefs.getString('access_token');
        tokentype = prefs.getString('token_type');
        String authorizationWithToken = '$tokentype $accesstoken';
        response = await client
            .get(url, headers: {'Authorization': authorizationWithToken});
        print("Se dio un nuevo token!");
      } else {
       
        throw Exception('Failed to request a new token');
      }

    }

    if (response.statusCode == 200) {
     
      return Albunes.fromJson(json.decode(response.body));
    } else {
   
      throw Exception('Failed to load tracks');
    }
  }
}