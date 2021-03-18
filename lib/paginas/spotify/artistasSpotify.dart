
import 'package:wigilabsSpotify/blocs/artistasBloc.dart';
import 'package:wigilabsSpotify/modelos/albunesModelo.dart' as albun;
import 'package:wigilabsSpotify/modelos/artistasModelo.dart' as modelo;
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class ArtistasScreem extends StatefulWidget {
  @override
  _ArtistasScreemState createState() => _ArtistasScreemState();
}
class _ArtistasScreemState extends State<ArtistasScreem> {
  modelo.Artist _artistas;
  
  bool sound = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _artistas = null;
  }



  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      _artistas = arguments['artista'] as modelo.Artist;
      artistasBloc.fectAlbunes("https://api.spotify.com/v1/artists/${_artistas.id}/albums?include_groups=single%2Cappears_on&market=ES&limit=10&offset=5");
    }

    SliverAppBar sliverAppBar = new SliverAppBar(
      floating: false,
      pinned: true,
      snap: false,
      expandedHeight: 300,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: true,
        title: Text("${_artistas.name}"),
        background: Stack(
          alignment: Alignment.center,
          //fit: StackFit.expand, // Para expandir la imagen por
          children: [
            Image.network(
              "${_artistas.images.length > 0 ? _artistas.images[0].url : "https://cdn.pixabay.com/photo/2012/04/23/15/46/question-38629_960_720.png"}",
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

    _sliverList(AsyncSnapshot<albun.Albunes> snapshot) {
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
                  leading: Image.network(snapshot
                              .data.items[index].images.length >
                          0
                      ? snapshot.data.items[index].images[0].url
                      : "https://cdn.pixabay.com/photo/2012/04/23/15/46/question-38629_960_720.png"),
                  title: Text("${snapshot.data.items[index].name}"),
                  subtitle: Text(
                      "${snapshot.data.items[index].artists[0].name}"),
                  trailing: IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: (){},
                  ),
                  
                ),
              ),
              secondaryActions: <Widget>[
               
              ],
            );
          },
          childCount: snapshot.data.items.length,
        ),
      );
      return sliverList;
    }

    _scaffold(AsyncSnapshot<albun.Albunes> snapshot) {
      Scaffold scaffold = new Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[sliverAppBar, _sliverList(snapshot)],
        ),
      );
      return scaffold;
    }

    return new StreamBuilder(
      stream: artistasBloc.albunesListList,
      builder: (context, AsyncSnapshot<albun.Albunes> snapshot) {
        
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