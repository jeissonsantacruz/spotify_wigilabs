
import 'package:audioplayers/audioplayers.dart';
import 'package:firebaseauth/blocs/categoriaBloc.dart';
import 'package:firebaseauth/modelos/categoriasModelo.dart' as modelo;
import 'package:firebaseauth/modelos/playlistCategoria.dart' as playslist;
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';
class PlaylistCategoria extends StatefulWidget {
  @override
  CategoriasCategoriaState createState() => CategoriasCategoriaState();
}
class CategoriasCategoriaState extends State<PlaylistCategoria> {
  modelo.Categoria _categorias;
  AudioPlayer audioPlayer = AudioPlayer();
  bool sound = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categorias = null;
  }

  play(String url) async {
    int result = await audioPlayer.play(url);
    if (result == 1) {
      sound = true;
    }
  }

  _launchURL(urlParameter) async {
    String url = urlParameter.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo ir a $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      _categorias = arguments['categorias'] as modelo.Categoria;
      categoriaBloc.fetchPlaylist(_categorias.id);
    }

    SliverAppBar sliverAppBar = new SliverAppBar(
      floating: false,
      pinned: true,
      snap: false,
      expandedHeight: 300,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: true,
        title: Text("${_categorias.name}"),
        background: Stack(
          alignment: Alignment.center,
          //fit: StackFit.expand, // Para expandir la imagen por
          children: [
            Image.network(
              "${_categorias.icons.length > 0 ? _categorias.icons[0].url : "https://cdn.pixabay.com/photo/2012/04/23/15/46/question-38629_960_720.png"}",
              height: 180,
              //fit: BoxFit.cover,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.0, 0.5),
                  end: Alignment(0.0, 0.0),
                  colors: <Color>[
                    Color(0x60000000),
                    Color(0x00000000),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    _sliverList(AsyncSnapshot<playslist.PlaylistModelo> snapshot) {
      SliverList sliverList = new SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return new Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: Container(
                //color: Theme.of(context).primaryColor,
                color: Colors.black54,
                child: ListTile(
                  leading: Image.network(snapshot.data.playlists.items[index].images.length>
                          0
                      ? snapshot.data.playlists.items[index].images[0].url
                      : "https://cdn.pixabay.com/photo/2012/04/23/15/46/question-38629_960_720.png"),
                  title: Text("${ snapshot.data.playlists.items[index].name}"),
                  subtitle: Text(
                      "${ snapshot.data.playlists.items[index].description}"),
                  trailing: IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: (){},
                  ),
                 
                ),
              ),
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Open Spotify',
                  color: Colors.black45,
                  icon: Icons.play_circle_outline,
                  onTap: () => _launchURL(
                      snapshot.data.playlists.items[index].tracks.href),
                ),
              ],
            );
          },
          childCount: snapshot.data.playlists.total,
        ),
      );
      return sliverList;
    }

    _scaffold(AsyncSnapshot<playslist.PlaylistModelo> snapshot) {
      Scaffold scaffold = new Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[sliverAppBar, _sliverList(snapshot)],
        ),
      );
      return scaffold;
    }

    return new StreamBuilder(
      stream: categoriaBloc.playlistlist,
      builder: (context, AsyncSnapshot<playslist.PlaylistModelo> snapshot) {
        if (snapshot.hasData) {
          return _scaffold(snapshot);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}