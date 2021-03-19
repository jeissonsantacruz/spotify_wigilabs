import 'package:flutter/material.dart';
import 'package:wigilabsSpotify/modelos/busquedaModelo.dart';
import 'package:wigilabsSpotify/widgets/busquedaWidget.dart';


class BusquedaPantalla extends StatefulWidget {

  @override
  _BusquedaPantallaState createState() => _BusquedaPantallaState();
}

class _BusquedaPantallaState extends State<BusquedaPantalla> {

  TracksPlaylistModel paisSeleccionado = TracksPlaylistModel();
  List<TracksPlaylistModel> historial = [];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

         

            MaterialButton(
              child: Text('Buscar', style: TextStyle( color: Colors.white) ),
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              color: Colors.white,
              onPressed: () async {
                final pais = await showSearch(
                  context: context, 
                  delegate: CountrySearchDelegate('Buscar...', historial )
                );

                setState(() {
                  this.paisSeleccionado = pais;
                  this.historial.insert(0, pais);
                });
              }
            )

            

          ],
        )
     ),
   );
  }
}
