import 'package:wigilabsSpotify/paginas/login/resgistroUsuario.dart';
import 'package:wigilabsSpotify/proveedores/preferenciasUsuario.dart';
import 'package:wigilabsSpotify/servicios/login/serviciosLogin.dart';
import 'package:wigilabsSpotify/widgets/toastWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'pantallaEspera.dart';

// Clase que contiene el login de la aplicacion
class LoginPagina extends StatefulWidget {
  @override
  _LoginPaginaState createState() => _LoginPaginaState();
}

class _LoginPaginaState extends State<LoginPagina> {
  final serviciosLogin = ServiciosLogin();
  final preferenciasUsuario = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://iphoneroscdn-iphoneros.netdna-ssl.com/wp-content/uploads/2013/08/10.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.05,
              left: size.height * 0.02,
              right: size.height * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Iniciar sesion',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
              SizedBox(height: size.height * 0.2),
              SizedBox(
                  width: size.width,
                  child: BotonCustom(
                    color: Colors.black,
                    hintText: 'Ingresar con Correo',
                    icon: Icons.mail_outline,
                    onPressed: _emailSignUp,
                  )),
              SizedBox(height: 20),
              SizedBox(
                  width: size.width,
                  child: BotonCustom(
                    color: Colors.blue,
                    hintText: 'Ingresar con Facebook',
                    icon: FontAwesomeIcons.facebook,
                    onPressed: _facebookSignUp,
                  )),
              SizedBox(height: 20),
              SizedBox(
                  width: size.width,
                  child: BotonCustom(
                    color: Colors.red[400],
                    hintText: 'Ingresar con Google',
                    icon: FontAwesomeIcons.google,
                    onPressed: _googleSignUp,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  // funcion que llama el servicio de iniciar sesion con google
  _googleSignUp() async {
    try {
      serviciosLogin.googleSignUp().then((respuesta) {
        preferenciasUsuario.login = true;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EsperaPantalla()));
      });
    } catch (e) {
      print(e.message);
      showToast(e.message, Colors.redAccent);
    }
  }
  // funcion que llama el servicio de iniciar sesion con Facebook
  _facebookSignUp() async {
    try {
      serviciosLogin.signUpWithFacebook().then((respuesta) {
        preferenciasUsuario.login = true;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EsperaPantalla()));
      });
    } catch (e) {
      print(e.message);
      showToast(e.message, Colors.redAccent);
    }
  }

  // funcion que redirige a la pagina de registro de correo
  _emailSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegistroCorreo()));
  }
}

// Clase que dibuja un boton 
class BotonCustom extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final Function onPressed;
  final Color color;

  BotonCustom({this.icon, this.hintText, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return RaisedButton(
      child: Row(
        children: <Widget>[
          Icon(icon, size: 30),
          Text(
            hintText,
            style: TextStyle(fontSize: 28),
          ),
        ],
      ),
      textColor: Colors.white,
      color: color,
      padding: EdgeInsets.all(10),
      onPressed: (){onPressed();}
      
    );
  }
}
