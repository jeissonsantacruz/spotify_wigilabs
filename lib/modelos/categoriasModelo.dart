// To parse this JSON data, do
//
//     final categorias = categoriasFromJson(jsonString);

import 'dart:convert';

Categorias categoriasFromJson(String str) => Categorias.fromJson(json.decode(str));

String categoriasToJson(Categorias data) => json.encode(data.toJson());

class Categorias {
    Categorias({
        this.categories,
    });

    Categories categories;

    factory Categorias.fromJson(Map<String, dynamic> json) => Categorias(
        categories: Categories.fromJson(json["categories"]),
    );

    Map<String, dynamic> toJson() => {
        "categories": categories.toJson(),
    };
}

class Categories {
    Categories({
        this.href,
        this.items,
        this.limit,
        this.next,
        this.offset,
        this.previous,
        this.total,
    });

    String href;
    List<Categoria> items;
    int limit;
    String next;
    int offset;
    dynamic previous;
    int total;
 
    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        href: json["href"],
        items: List<Categoria>.from(json["items"].map((x) => Categoria.fromJson(x))),
        limit: json["limit"],
        next: json["next"],
        offset: json["offset"],
        previous: json["previous"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "href": href,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "limit": limit,
        "next": next,
        "offset": offset,
        "previous": previous,
        "total": total,
    };
}

class Categoria {
    Categoria({
        this.href,
        this.icons,
        this.id,
        this.name,
    });

    String href;
    List<Icon> icons;
    String id;
    String name;

    factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        href: json["href"],
        icons: List<Icon>.from(json["icons"].map((x) => Icon.fromJson(x))),
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "href": href,
        "icons": List<dynamic>.from(icons.map((x) => x.toJson())),
        "id": id,
        "name": name,
    };
}

class Icon {
    Icon({
        this.height,
        this.url,
        this.width,
    });

    int height;
    String url;
    int width;

    factory Icon.fromJson(Map<String, dynamic> json) => Icon(
        height: json["height"] == null ? null : json["height"],
        url: json["url"],
        width: json["width"] == null ? null : json["width"],
    );

    Map<String, dynamic> toJson() => {
        "height": height == null ? null : height,
        "url": url,
        "width": width == null ? null : width,
    };
}
