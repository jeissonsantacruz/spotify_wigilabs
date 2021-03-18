import 'package:firebaseauth/blocs/categoriaBloc.dart';
import 'package:firebaseauth/modelos/categoriasModelo.dart';
import 'package:flutter/material.dart';

class AlbumTabBar extends StatefulWidget {
  AlbumTabBarState createState() => new AlbumTabBarState();
}


class AlbumTabBarState extends State<AlbumTabBar> {
  void initState() {
    super.initState();
    categoriaBloc.fetchCategorias();
  }
  @override
  Widget build(BuildContext context) {
   return new StreamBuilder(
      stream: categoriaBloc.categoriasList,
      builder: (context, AsyncSnapshot<Categorias> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.categories.limit,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Image.network(snapshot.data.categories.items[index].icons[0].url),
                title: Text("${snapshot.data.categories.items[index].name}"),
                onTap: () {
                  Navigator.pushNamed(context, "/playlistCategorias",
                      arguments:  <String, Categoria>{ 
                        'categorias': snapshot.data.categories.items[index],
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