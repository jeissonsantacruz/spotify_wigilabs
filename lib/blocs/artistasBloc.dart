

import 'package:firebaseauth/modelos/albunesModelo.dart';
import 'package:firebaseauth/modelos/artistasModelo.dart';
import 'package:firebaseauth/servicios/spotify/repositoryServicio.dart';
import 'package:rxdart/rxdart.dart';

class ArtistasBloc {
  final _repository = RepositoryArtistas();

  final PublishSubject playlistLista = PublishSubject<Artistas>();
  final PublishSubject albunesLista = PublishSubject<Albunes>();

  Observable<Artistas> get playlistList => playlistLista.stream;
  Observable<Albunes> get albunesListList => albunesLista.stream;

  fetchPlaylist() async {
     Artistas code = await _repository.fetchArtistas();
    playlistLista.sink.add(code);
  }
   fectAlbunes(String url) async {
    Albunes tracks = await _repository.fetchAlbunes(url);
    albunesLista.sink.add(tracks);
  }
 

  disposePlaylist() {
    playlistLista.close();
  }
  disposeAlbunes() {
    albunesLista.close();
  }

}

final ArtistasBloc artistasBloc = ArtistasBloc();