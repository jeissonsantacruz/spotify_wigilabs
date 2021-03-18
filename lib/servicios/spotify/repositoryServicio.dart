import 'dart:async';

import 'package:firebaseauth/modelos/albunesModelo.dart';
import 'package:firebaseauth/modelos/artistasModelo.dart';
import 'package:firebaseauth/modelos/autorizacionModelo.dart';
import 'package:firebaseauth/modelos/busquedaModelo.dart';
import 'package:firebaseauth/modelos/categoriasModelo.dart';
import 'package:firebaseauth/modelos/playslistModelo.dart';
import 'package:firebaseauth/modelos/playlistCategoria.dart';
import 'package:firebaseauth/modelos/trackModelo.dart';
import 'package:firebaseauth/servicios/spotify/artistasServicio.dart';
import 'package:firebaseauth/servicios/spotify/busquedaServicio.dart';
import 'package:firebaseauth/servicios/spotify/categoriasServicio.dart';
import 'package:firebaseauth/servicios/spotify/playlistAlbunesServicio.dart';

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
  Future<ListPlaylistModel> fetchPlaylist() => playlistsListApiProvider.fetchPlaylist();
  Future<TracksPlaylistModel> fetchTracksList(String url) => tracksPlaylistApiProvider.fetchTracks(url);
}

class RepositoryArtistas {
  final artistas = ArtistasServicio();
  final albunes = AlbunesServicio();
  Future<Artistas> fetchArtistas() => artistas.fetchArtistas();
  Future<Albunes>  fetchAlbunes(String url) => albunes.fetchAlbunes(url);

}

class RepositoryBusqueda {
  final busqueda = BusquedaServicio();
  
  Future<BusquedaCategoria> fecthBusqueda(String busq) => busqueda.fetchBusqueda(busq);
  

}

class RepositoryCategorias {
  final categorias = CategoriasServicio();
  final playlist = PlaylistAlbunesProvider();
  Future<Categorias> fetchCategorias() => categorias.fetchCategorias();
   Future<PlaylistModelo>  fetchPlaylist(String url) => playlist.fetchPlaylistAlbunes(url);


}