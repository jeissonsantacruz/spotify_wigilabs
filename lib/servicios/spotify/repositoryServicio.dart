import 'dart:async';

import 'package:firebaseauth/modelos/autorizacion.dart';
import 'package:firebaseauth/modelos/listaPlaylist.dart';
import 'package:firebaseauth/modelos/trackPaylist.dart';

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
