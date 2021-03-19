import 'package:flutter/material.dart';
import 'package:wigilabsSpotify/blocs/busquedaBloc.dart';


import 'package:wigilabsSpotify/modelos/busquedaModelo.dart' as modelo;
import 'package:wigilabsSpotify/servicios/spotify/busquedaServicio.dart';

class CountrySearchDelegate extends SearchDelegate<modelo.TracksPlaylistModel> {
 
  @override
  final String searchFieldLabel;
  final List<modelo.TracksPlaylistModel> historial;
  final blocBusqueda = BusquedaServicio();
  CountrySearchDelegate(this.searchFieldLabel, this.historial);
  

  @override
  List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(
          icon: Icon( Icons.clear ), 
          onPressed: () => this.query = ''
        )
      ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon( Icons.arrow_back_ios ),
      onPressed: () => this.close(context, null )
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    if ( query.trim().length == 0 ) {
      return Text('no hay valor en el query');
    }


   
    // query!
    return FutureBuilder(
      future: blocBusqueda.fetchBusqueda( query ),
      builder: ( context , AsyncSnapshot snapshot) {
        
        if ( snapshot.hasError ) {
          return ListTile( title: Text('No hay nada con ese término') );
        }

        if ( snapshot.hasData ) {
          // crear la lista
          return _showtracks( snapshot.data );
        } else {
          // Loading
          return Center(child: CircularProgressIndicator( strokeWidth: 4 ));
        }
      },
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _showtracks( this.historial );
  }

  Widget _showtracks( List<modelo.TracksPlaylistModel> tracks ) {

    return ListView.builder(
      itemCount: tracks.length,
      itemBuilder: ( context , i) {

        final track = tracks[i];

        return ListTile(
                leading: Image.network(tracks[i].album.images.length >
                        0
                    ? tracks[i].album.images[0].url
                    : "https://cdn.pixabay.com/photo/2012/04/23/15/46/question-38629_960_720.png"),
                title: Text("${track.name}"),
                subtitle: Text("de ${track.type}"),
               
              );

      },
    );

  }

}




// class CountryService {

//   final _dio = new Dio();

//   Future getCountryByName( String name ) async {

//     try {
      
//       final url = 'https://resttracks.eu/rest/v2/name/$name';
//       final resp = await _dio.get(url);

//       final List<dynamic> countryList = resp.data;
      
//       return countryList.map(
//         (obj) => modelo.Country.fromJson(obj)
//       ).toList();


//     } catch (e) {
      
//       print(e);
//       return [];
//     }

//   }

// }