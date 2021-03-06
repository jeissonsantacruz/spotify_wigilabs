import 'dart:async';
import 'package:wigilabsSpotify/blocs/autorizacionBloc.dart';
import 'package:wigilabsSpotify/modelos/autorizacionModelo.dart';
import 'package:wigilabsSpotify/paginas/spotify/homeUsuarioSpotify.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class EsperaPantalla extends StatefulWidget {
  @override
  _EsperaPantallaState createState() => _EsperaPantallaState();
}

class _EsperaPantallaState extends State<EsperaPantalla> {
  addTokenToSF(AsyncSnapshot<AuthorizationModel> snapshot) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', snapshot.data.accessToken);
    prefs.setString('token_type', snapshot.data.tokenType);
    prefs.setString('refresh_token', snapshot.data.refreshToken);
    prefs.setBool('logged', true);
  }

  @override
  Widget build(BuildContext contextBuild) {
    autorizacionBloc.fetchAuthorizationCode();

    _bienvenido() {
      autorizacionBloc.disposeToken();
      Timer(
          Duration(microseconds: 0),
          () =>   Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePagina())));
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: StreamBuilder(
        stream: autorizacionBloc.authorizationCode,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == "access_denied") {
              Navigator.pop(contextBuild);
            } else {
              autorizacionBloc.fetchAuthorizationToken(snapshot.data);
              return StreamBuilder(
                stream: autorizacionBloc.authorizationToken,
                builder: (context, AsyncSnapshot<AuthorizationModel> snapshot) {
                  if (snapshot.hasData) {
                    print("FINAL DATA");
                    print('access_token: ${snapshot.data.accessToken}');
                    print("token_type: ${snapshot.data.tokenType}");
                    print("expires_in: ${snapshot.data.expiresIn}");
                    print("refresh_token: ${snapshot.data.refreshToken}");
                    print("scope: ${snapshot.data.scope}");
                    addTokenToSF(snapshot);
                    return _bienvenido();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              );
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
