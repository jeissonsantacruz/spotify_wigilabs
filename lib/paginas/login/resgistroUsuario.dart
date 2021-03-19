import 'package:wigilabsSpotify/paginas/login/pantallaEspera.dart';
import 'package:wigilabsSpotify/proveedores/preferenciasUsuario.dart';
import 'package:wigilabsSpotify/servicios/login/serviciosLogin.dart';
import 'package:wigilabsSpotify/widgets/toastWidget.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';


class RegistroCorreo extends StatefulWidget {
  @override
  _RegistroCorreoState createState() => _RegistroCorreoState();
}
// Clase que contiene el registro del usuario
class _RegistroCorreoState extends State<RegistroCorreo> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final serviciosLogin       = ServiciosLogin();
  final preferenciasUsuario  = PreferenciasUsuario();
  final correoController     = TextEditingController();
  final contrasenaController = TextEditingController();

// funcion que valida el password
  String validatePassword(String value) {
    if (value.isEmpty) {
      return "* requerido";
    } else if (value.length < 6) {
      return "Contraseña con más de 6 caracteres";
    } else if (value.length > 15) {
      return "Contraseña con menos de 15 caracteres";
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Registro con correo"),
        backgroundColor: Color(0xFF2EABA7),
      ),
      body: SingleChildScrollView(
        child: Form(
          // ignore: deprecated_member_use
          autovalidate: true,
          key: formkey,
          child: Padding(
            padding: EdgeInsets.only(top:size.height * 0.05,left:size.height * 0.02,right:size.height * 0.02),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                      controller: correoController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Correo',
                          hintText: 'Digite un correo como abc@gmail.com'),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "* Requerido"),
                        EmailValidator(errorText: "Digite un correo valido"),
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextFormField(
                      controller: contrasenaController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Contraseña',
                          hintText: 'Digite una contraseña segura'),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "* Requerido"),
                        MinLengthValidator(6,
                            errorText: "Contraseña con más de 6 caracteres"),
                        MaxLengthValidator(15,
                            errorText: "Contraseña con menos de 15 caracteres")
                      ])
                      //validatePassword,        //Function to check validation
                      ),
                ),
                // ignore: deprecated_member_use

                Container(
                  height: 50,
                  width: size.width*0.8,
                  decoration: BoxDecoration(
                      color: Color(0xFF2EABA7),
                      borderRadius: BorderRadius.circular(20)),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () {
                    signUpWithEmail();
                    },
                    child: Text(
                      'Registrarse',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
 //  funcion que llama el servicio de iniciar sesion con correo
  signUpWithEmail() async {
    try {
      if (formkey.currentState.validate()) {
    
        print("Validado");
        serviciosLogin.signUpWithMail(correoController.text,contrasenaController.text).then((respuesta) {
        preferenciasUsuario.login = true;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EsperaPantalla()));
      });
      } 
    } catch (e) {
      print(e.message);
      showToast(e.message, Colors.redAccent);
    }
  }
}
