// To parse this JSON data, do
//
//     final infoUsuario = infoUsuarioFromJson(jsonString);

import 'dart:convert';

InfoUsuario infoUsuarioFromJson(String str) => InfoUsuario.fromJson(json.decode(str));

String infoUsuarioToJson(InfoUsuario data) => json.encode(data.toJson());

class InfoUsuario {
    InfoUsuario({
        this.nombre,
        this.apellido,
        this.userProfileId,
        this.documentNumber,
    });

    String nombre;
    String apellido;
    String userProfileId;
    String documentNumber;

    factory InfoUsuario.fromJson(Map<String, dynamic> json) => InfoUsuario(
        nombre: json["nombre"],
        apellido: json["apellido"],
        userProfileId: json["UserProfileID"],
        documentNumber: json["DocumentNumber"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "UserProfileID": userProfileId,
        "DocumentNumber": documentNumber,
    };
}
