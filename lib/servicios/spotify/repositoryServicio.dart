import 'dart:async';

import 'package:firebaseauth/modelos/albunes.dart';
import 'package:firebaseauth/modelos/artista.dart';
import 'package:firebaseauth/modelos/autorizacion.dart';
import 'package:firebaseauth/modelos/busqueda.dart';
import 'package:firebaseauth/modelos/listaPlaylist.dart';
import 'package:firebaseauth/modelos/trackPaylist.dart';
import 'package:firebaseauth/servicios/spotify/artistasServicio.dart';
import 'package:firebaseauth/servicios/spotify/busquedaServicio.dart';

import 'albunesServicio.dart';
import 'autorizacionTokenServicio.dart';
import 'autorizacionServicio.dart';
import 'playlistServicio.dart';
import 'tracksPlaylistServicio.dart';



class RepositoryAuthorization {
  final authorizationCodeApiProvider = AuthorizationApiProvider();
  final authorizationTokenApiProvider = AuthorizationTokenApiProvider();
  Future<String> fetchAuthorizationCode() => authorizationCodeApiProvider.fetchCode();
  Future<AuthorizationModel> fetchAuthorizationToken(String code) => authorizationTokenApiProvider.fetchToken(code);
}

class RepositoryPlaylist {
  final playlistsListApiProvider = PlaylistListApiProvider();
  final tracksPlaylistApiProvider = TracksPlaylistApiProvider();
  Future<ListPlaylistModel> fetchPlaylistList() => playlistsListApiProvider.fetchPlaylistList();
  Future<TracksPlaylistModel> fetchTracksList(String url) => tracksPlaylistApiProvider.fetchTracks(url);
}

class RepositoryArtistas {
  final artistas = ArtistasServicio();
  Future<Artistas> fetchArtistas() => artistas.fetchArtistas();
    final albunes = AlbunesServicio();

    Future<Albunes> fetchAlbunes(String url) => albunes.fetchAlbunes(url);

}

class RepositoryBusqueda {
  final busqueda = BusquedaServicio();
  Future<BusquedaCategoria> fecthBusqueda(String busq) => busqueda.fetchBusqueda(busq);
  

}