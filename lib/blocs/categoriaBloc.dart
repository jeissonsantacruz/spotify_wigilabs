
import 'package:firebaseauth/modelos/categorias.dart';
import 'package:firebaseauth/servicios/spotify/repositoryServicio.dart';
import 'package:rxdart/rxdart.dart';

class CategoriaBloc {
  final _repository = RepositoryCategorias();

  final PublishSubject categoriaLista = PublishSubject<Categorias>();
 

  Observable<Categorias> get categoriasList => categoriaLista.stream;


  fetchCategorias() async {
     Categorias code =   await _repository.fetchCategorias();
    categoriaLista.sink.add(code);
  }
 

  disposePlaylist() {
    categoriaLista.close();
  }

}

final CategoriaBloc categoriaBloc = CategoriaBloc();