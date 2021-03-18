

import 'package:firebaseauth/modelos/busquedaModelo.dart';
import 'package:firebaseauth/servicios/spotify/repositoryServicio.dart';
import 'package:rxdart/rxdart.dart';

class BusquedaBloc {
  final _repository = RepositoryBusqueda();

  final PublishSubject busquedaCategoriaLista = PublishSubject<BusquedaCategoria>();
  

  Observable<BusquedaCategoria> get busquedaList => busquedaCategoriaLista.stream;


  fetchPlaylist(String busqueda) async {
     BusquedaCategoria code = await _repository.fecthBusqueda(busqueda );
    busquedaCategoriaLista.sink.add(code);
  }
 
 

  disposePlaylist() {
    busquedaCategoriaLista.close();
  }
 

}

final BusquedaBloc busquedaBloc = BusquedaBloc();