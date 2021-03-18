
import 'package:firebaseauth/modelos/categoriasModelo.dart';
import 'package:firebaseauth/modelos/playlistCategoria.dart';
import 'package:firebaseauth/servicios/spotify/repositoryServicio.dart';
import 'package:rxdart/rxdart.dart';

class CategoriaBloc {
  final _repository = RepositoryCategorias();

  final PublishSubject categoriaLista = PublishSubject<Categorias>();
  final PublishSubject playlistLista =  PublishSubject<PlaylistModelo>();

  Observable<Categorias> get categoriasList => categoriaLista.stream;
  Observable<PlaylistModelo> get playlistlist => playlistLista.stream;


  fetchCategorias() async {
     Categorias code =   await _repository.fetchCategorias();
    categoriaLista.sink.add(code);
  }
  
  fetchPlaylist(String categoriaId) async {
     PlaylistModelo code =   await _repository.fetchPlaylist(categoriaId);
    playlistLista.sink.add(code);
  }
 

  disposeCategoria() {
    categoriaLista.close();
  }
  disposePlaylist() {
    playlistLista.close();
  }

}

final CategoriaBloc categoriaBloc = CategoriaBloc();