import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;

// import 'dart:convert';




/* Classe que contiene todos los servicios de login*/
class ServiciosLogin {
  

  // Funcion que llama el API de firebase para iniciar o autenticarse con Google
  Future<void> googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);

      return user;
    } catch (e) {
      print(e.message);
    }
  }
  
  // Funcion que llama el API de firebase para iniciar o autenticarse con Facebook
  Future<void> signUpWithFacebook() async {
    try {
      var facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);

      if (result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        );
        final FirebaseUser user =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;

        return user;
      }
    } catch (e) {
      print(e.message);
      return null;
    }
  }
  
  // Funcion que llama el API de firebase para iniciar o autenticarse con Email
  Future<bool> signUpWithMail(String correo, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: correo, password: password);
      return true;
    } catch (e) {
      print(e.message);
      return false;
    }
  }
}
