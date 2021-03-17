import 'dart:convert';
import 'package:firebaseauth/modelos/infoUsuarioModelo.dart';
import 'package:http/http.dart' as http;


// Clase que contiene los servicios de wigilabs
class WigilabsServicio {
  final urlPrueba =
      "https://apiselfservice.co/api/index.php/v1/soap/LoginUsuario.json";
  Future<InfoUsuario> fetchDatosUsuario() async {
    Map<String, String> headers = {"X-MC-SO": "WigilabsTest"};
    var data = {"nombreUsuario": "a@a.aa", "clave": "Garay1362"};
    var body = {"data": data};
    final encodedData = json.encode(body);

    // make POST request
    http.Response response =
        await http.post(urlPrueba, headers: headers, body: encodedData);
    final decodeData = jsonDecode(response.body);
    InfoUsuario usuario = InfoUsuario.fromJson(decodeData['response']['usuario']);


    return usuario;
  }
}
