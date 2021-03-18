

import 'package:wigilabsSpotify/modelos/playslistModelo.dart';
import 'package:wigilabsSpotify/modelos/trackModelo.dart';
import 'package:wigilabsSpotify/servicios/spotify/repositoryServicio.dart';
import 'package:rxdart/rxdart.dart';

class PlaylistBloc {
  final _repository = RepositoryPlaylist();

  final PublishSubject playlistLista = PublishSubject<ListPlaylistModel>();
  final PublishSubject tackslistLista = PublishSubject<TracksPlaylistModel>();

  Observable<ListPlaylistModel> get playlistList => playlistLista.stream;
  Observable<TracksPlaylistModel> get tracksList => tackslistLista.stream;

  fetchPlaylist() async {
     ListPlaylistModel code =   await _repository.fetchPlaylist();
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