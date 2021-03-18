import 'package:firebaseauth/blocs/artistasBloc.dart';
import 'package:firebaseauth/modelos/artistasModelo.dart' as modelo;
import 'package:flutter/material.dart';

class ArtistTabBar extends StatefulWidget {
  ArtistTabBarState createState() => new ArtistTabBarState();
}

class ArtistTabBarState extends State<ArtistTabBar> { 
  void initState() {
    super.initState();
    artistasBloc.fetchPlaylist();
  }
  @override 
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: artistasBloc.playlistList,
      builder: (context, AsyncSnapshot<modelo.Artistas> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.artists.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Image.network(snapshot.data.artists[index].images.length>
                        0
                    ? snapshot.data.artists[index].images[0].url
                    : "https://cdn.pixabay.com/photo/2012/04/23/15/46/question-38629_960_720.png"),
                title: Text("${snapshot.data.artists[index].name}"),
                subtitle: Text("de ${snapshot.data.artists[index].popularity}"),
                onTap: () {
                  Navigator.pushNamed(context, "/artistas",
                      arguments: <String, modelo.Artist>{
                        
                        'artista': snapshot.data.artists[index],
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
final ArtistasBloc artistasBloc = ArtistasBloc();