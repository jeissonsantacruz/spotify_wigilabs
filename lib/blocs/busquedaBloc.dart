

import 'package:wigilabsSpotify/modelos/busquedaModelo.dart';
import 'package:wigilabsSpotify/servicios/spotify/repositoryServicio.dart';
import 'package:rxdart/rxdart.dart';

class BusquedaBloc {
  final _repository = RepositoryBusqueda();

  final PublishSubject tracksPlaylistModelLista = PublishSubject<List<TracksPlaylistModel>>();
  

  Observable<TracksPlaylistModel> get busquedaList => tracksPlaylistModelLista.stream;


  fetchPlaylist(String busqueda) async {
     List<TracksPlaylistModel> code = await _repository.fecthBusqueda(busqueda );
    tracksPlaylistModelLista.sink.add(code);
  }
 
 

  disposePlaylist() {
    tracksPlaylistModelLista.close();
  }
 

}

final BusquedaBloc busquedaBloc = BusquedaBloc();