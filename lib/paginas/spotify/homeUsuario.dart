import 'package:firebaseauth/paginas/spotify/busquedaSpotify.dart';
import 'package:firebaseauth/paginas/spotify/pantallaInicio.dart';
import 'package:flutter/material.dart';

import 'libreriaSpotify.dart';

class HomePagina extends StatefulWidget {
  @override
  _HomePaginaState createState() => _HomePaginaState();
}

class _HomePaginaState extends State<HomePagina> {
  var indexSeleccion = 0;
  @override
  Widget build(BuildContext context) {
    AppBar appBar = new AppBar(
      title: Text(
        "Spotify",
        style: TextStyle(fontSize: 20),
      ),
      backgroundColor: Colors.black54,
      centerTitle: true,
      elevation: 0.0,
    );

    BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      selectedFontSize: 10,
      unselectedFontSize: 10,
      selectedItemColor: Colors.white,
      //unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text("Home"),
            icon: Icon(
              Icons.home,
            )),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text("Busqueda"),
            icon: Icon(
              Icons.search,
            )),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text("Libreria"),
            icon: Icon(
              Icons.library_music,
            )),
      ],
      currentIndex: indexSeleccion,
      onTap: (index) {
        setState(() {
          indexSeleccion = index;
        });
      },
    );

    List<Widget> listPages = [
      new StartPage(),
      new SearchPage(),
      new MyLibraryPage(),
    ];

    Scaffold scaffold = new Scaffold(
      appBar: appBar,
      body: listPages.elementAt(indexSeleccion),
      bottomNavigationBar: bottomNavigationBar,
    );

    return scaffold;
  }
}