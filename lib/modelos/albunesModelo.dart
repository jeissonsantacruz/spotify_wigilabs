// To parse this JSON data, do
//
//     final albunes = albunesFromJson(jsonString);

import 'dart:convert';

Albunes albunesFromJson(String str) => Albunes.fromJson(json.decode(str));

String albunesToJson(Albunes data) => json.encode(data.toJson());

class Albunes {
    Albunes({
        this.href,
        this.items,
        this.limit,
        this.next,
        this.offset,
        this.previous,
        this.total,
    });

    String href;
    List<Item> items;
    int limit;
    String next;
    int offset;
    String previous;
    int total;

    factory Albunes.fromJson(Map<String, dynamic> json) => Albunes(
        href: json["href"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
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

class Item {
    Item({
        this.albumGroup,
        this.albumType,
        this.artists,
        this.externalUrls,
        this.href,
        this.id,
        this.images,
        this.name,
        this.releaseDate,
        this.releaseDatePrecision,
        this.totalTracks,
        this.type,
        this.uri,
    });

    Album albumGroup;
    Album albumType;
    List<Artist> artists;
    ExternalUrls externalUrls;
    String href;
    String id;
    List<Image> images;
    String name;
    DateTime releaseDate;
    ReleaseDatePrecision releaseDatePrecision;
    int totalTracks;
    ItemType type;
    String uri;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        albumGroup: albumValues.map[json["album_group"]],
        albumType: albumValues.map[json["album_type"]],
        artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        name: json["name"],
        releaseDate: DateTime.parse(json["release_date"]),
        releaseDatePrecision: releaseDatePrecisionValues.map[json["release_date_precision"]],
        totalTracks: json["total_tracks"],
        type: itemTypeValues.map[json["type"]],
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "album_group": albumValues.reverse[albumGroup],
        "album_type": albumValues.reverse[albumType],
        "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
        "external_urls": externalUrls.toJson(),
        "href": href,
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "name": name,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "release_date_precision": releaseDatePrecisionValues.reverse[releaseDatePrecision],
        "total_tracks": totalTracks,
        "type": itemTypeValues.reverse[type],
        "uri": uri,
    };
}

enum Album { SINGLE }

final albumValues = EnumValues({
    "single": Album.SINGLE
});

class Artist {
    Artist({
        this.externalUrls,
        this.href,
        this.id,
        this.name,
        this.type,
        this.uri,
    });

    ExternalUrls externalUrls;
    String href;
    String id;
    String name;
    ArtistType type;
    String uri;

    factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        name: json["name"],
        type: artistTypeValues.map[json["type"]],
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "external_urls": externalUrls.toJson(),
        "href": href,
        "id": id,
        "name": name,
        "type": artistTypeValues.reverse[type],
        "uri": uri,
    };
}

class ExternalUrls {
    ExternalUrls({
        this.spotify,
    });

    String spotify;

    factory ExternalUrls.fromJson(Map<String, dynamic> json) => ExternalUrls(
        spotify: json["spotify"],
    );

    Map<String, dynamic> toJson() => {
        "spotify": spotify,
    };
}

enum ArtistType { ARTIST }

final artistTypeValues = EnumValues({
    "artist": ArtistType.ARTIST
});

class Image {
    Image({
        this.height,
        this.url,
        this.width,
    });

    int height;
    String url;
    int width;

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        height: json["height"],
        url: json["url"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "url": url,
        "width": width,
    };
}

enum ReleaseDatePrecision { DAY }

final releaseDatePrecisionValues = EnumValues({
    "day": ReleaseDatePrecision.DAY
});

enum ItemType { ALBUM }

final itemTypeValues = EnumValues({
    "album": ItemType.ALBUM
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
