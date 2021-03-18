
import 'package:firebaseauth/blocs/playlistBloc.dart';
import 'package:firebaseauth/modelos/playslistModelo.dart';
import 'package:flutter/material.dart';

class PlaylistTabBar extends StatefulWidget {
  PlaylistTabBarState createState() => new PlaylistTabBarState();
}

class PlaylistTabBarState extends State<PlaylistTabBar> {
  void initState() {
    super.initState();
    playlistBloc.fetchPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: playlistBloc.playlistList,
      builder: (context, AsyncSnapshot<ListPlaylistModel> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.total,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Image.network(snapshot
                            .data.items[index].images.length >
                        0
                    ? snapshot.data.items[index].images[0].url
                    : "https://cdn.pixabay.com/photo/2012/04/23/15/46/question-38629_960_720.png"),
                title: Text("${snapshot.data.items[index].name}"),
                subtitle: Text("de ${snapshot.data.items[index].owner.id}"),
                onTap: () {
                  Navigator.pushNamed(context, "/tracks",
                      arguments: <String, Playlist>{
                        'playlist': snapshot.data.items[index],
                      });
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
