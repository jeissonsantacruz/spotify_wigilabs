

import 'package:firebaseauth/modelos/busqueda.dart';
import 'package:firebaseauth/servicios/spotify/repositoryServicio.dart';
import 'package:rxdart/rxdart.dart';

class BusquedaBloc {
  final _repository = RepositoryBusqueda();

  final PublishSubject busquedaCategoria = PublishSubject<BusquedaCategoria>();
  

  Observable<BusquedaCategoria> get busquedaList => busquedaCategoria.stream;


  fetchPlaylistList(String busqueda) async {
     BusquedaCategoria code = await _repository.fecthBusqueda(busqueda );
    busquedaCategoria.sink.add(code);
  }
 
 

  disposePlaylist() {
    busquedaCategoria.close();
  }
 

}

final BusquedaBloc busquedaBloc = BusquedaBloc();