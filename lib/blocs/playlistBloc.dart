

import 'package:firebaseauth/modelos/listaPlaylist.dart';
import 'package:firebaseauth/modelos/trackPaylist.dart';
import 'package:firebaseauth/servicios/spotify/repositoryServicio.dart';
import 'package:rxdart/rxdart.dart';

class PlaylistBloc {
  final _repository = RepositoryPlaylist();

  final PublishSubject playlistLista = PublishSubject<ListPlaylistModel>();
  final PublishSubject tackslistLista = PublishSubject<TracksPlaylistModel>();

  Observable<ListPlaylistModel> get playlistList => playlistLista.stream;
  Observable<TracksPlaylistModel> get tracksList => tackslistLista.stream;

  fetchPlaylistList() async {
     ListPlaylistModel code =   await _repository.fetchPlaylistList();
    playlistLista.sink.add(code);
  }
  fetchTracksList(String url) async {
    TracksPlaylistModel tracks = await _repository.fetchTracksList(url);
    tackslistLista.sink.add(tracks);
  }

  disposePlaylist() {
    playlistLista.close();
  }
  disposeTracks() {
    tackslistLista.close();
  }
}

final PlaylistBloc playlistBloc = PlaylistBloc();