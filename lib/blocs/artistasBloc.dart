

import 'package:firebaseauth/modelos/albunes.dart';
import 'package:firebaseauth/modelos/artista.dart';
import 'package:firebaseauth/servicios/spotify/repositoryServicio.dart';
import 'package:rxdart/rxdart.dart';

class ArtistasBloc {
  final _repository = RepositoryArtistas();

  final PublishSubject playlistLista = PublishSubject<Artistas>();
  final PublishSubject albunesList = PublishSubject<Albunes>();

  Observable<Artistas> get playlistList => playlistLista.stream;
  Observable<Albunes> get albunesListList => albunesList.stream;

  fetchPlaylistList() async {
     Artistas code = await _repository.fetchArtistas();
    playlistLista.sink.add(code);
  }
   fectAlbune(String url) async {
    Albunes tracks = await _repository.fetchAlbunes(url);
    albunesList.sink.add(tracks);
  }
 

  disposePlaylist() {
    playlistLista.close();
  }
  disposeAlbunes() {
    albunesList.close();
  }

}

final ArtistasBloc artistasBloc = ArtistasBloc();