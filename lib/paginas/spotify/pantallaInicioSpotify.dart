import 'package:wigilabsSpotify/modelos/infoUsuarioModelo.dart';
import 'package:wigilabsSpotify/servicios/wigilabs/wigilabsServicio.dart';
import 'package:flutter/material.dart';

class InicioPantalla extends StatefulWidget {
  @override
  _InicioPantallaState createState() => _InicioPantallaState();
}

class _InicioPantallaState extends State<InicioPantalla> {
  final wigilabsServicio = WigilabsServicio();
  InfoUsuario usuario = InfoUsuario();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
            future: wigilabsServicio.fetchDatosUsuario(),
            builder:
                (BuildContext context, AsyncSnapshot<InfoUsuario> snapshot) {
              if (snapshot.hasData) {
                final usuario = snapshot.data;
                return Center(
                  child: ListView(children: <Widget>[
                    CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://miro.medium.com/max/3150/2*9K7LsaGdOxTsNUbf4VAMzA.jpeg"),
                        radius: 100),
                    Column(
                      children: [
                        Text(usuario.nombre),
                        Text(usuario.apellido),
                        Text(usuario.documentNumber),
                      ],
                    )
                  ]),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
