// To parse this JSON data, do
//
//     final tracksPlaylistModel = tracksPlaylistModelFromJson(jsonString);

import 'dart:convert';

TracksPlaylistModel tracksPlaylistModelFromJson(String str) => TracksPlaylistModel.fromJson(json.decode(str));

String tracksPlaylistModelToJson(TracksPlaylistModel data) => json.encode(data.toJson());




class TracksPlaylistModel {
    TracksPlaylistModel({
        this.album,
        this.artists,
        this.discNumber,
        this.durationMs,
        this.explicit,
        this.externalIds,
        this.externalUrls,
        this.href,
        this.id,
        this.isLocal,
        this.isPlayable,
        this.name,
        this.popularity,
        this.previewUrl,
        this.trackNumber,
        this.type,
        this.uri,
    });

    Album album;
    List<Artist> artists;
    int discNumber;
    int durationMs;
    bool explicit;
    ExternalIds externalIds;
    ExternalUrls externalUrls;
    String href;
    String id;
    bool isLocal;
    bool isPlayable;
    String name;
    int popularity;
    String previewUrl;
    int trackNumber;
    ItemType type;
    String uri;

    factory TracksPlaylistModel.fromJson(Map<String, dynamic> json) => TracksPlaylistModel(
        album: Album.fromJson(json["album"]),
        artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
        discNumber: json["disc_number"],
        durationMs: json["duration_ms"],
        explicit: json["explicit"],
        externalIds: ExternalIds.fromJson(json["external_ids"]),
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        isLocal: json["is_local"],
        isPlayable: json["is_playable"],
        name: json["name"],
        popularity: json["popularity"],
        previewUrl: json["preview_url"] == null ? null : json["preview_url"],
        trackNumber: json["track_number"],
        type: itemTypeValues.map[json["type"]],
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "album": album.toJson(),
        "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
        "disc_number": discNumber,
        "duration_ms": durationMs,
        "explicit": explicit,
        "external_ids": externalIds.toJson(),
        "external_urls": externalUrls.toJson(),
        "href": href,
        "id": id,
        "is_local": isLocal,
        "is_playable": isPlayable,
        "name": name,
        "popularity": popularity,
        "preview_url": previewUrl == null ? null : previewUrl,
        "track_number": trackNumber,
        "type": itemTypeValues.reverse[type],
        "uri": uri,
    };
}

class Album {
    Album({
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

    AlbumTypeEnum albumType;
    List<Artist> artists;
    ExternalUrls externalUrls;
    String href;
    String id;
    List<Image> images;
    String name;
    DateTime releaseDate;
    ReleaseDatePrecision releaseDatePrecision;
    int totalTracks;
    AlbumTypeEnum type;
    String uri;

    factory Album.fromJson(Map<String, dynamic> json) => Album(
        albumType: albumTypeEnumValues.map[json["album_type"]],
        artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        name: json["name"],
        releaseDate: DateTime.parse(json["release_date"]),
        releaseDatePrecision: releaseDatePrecisionValues.map[json["release_date_precision"]],
        totalTracks: json["total_tracks"],
        type: albumTypeEnumValues.map[json["type"]],
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "album_type": albumTypeEnumValues.reverse[albumType],
        "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
        "external_urls": externalUrls.toJson(),
        "href": href,
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "name": name,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "release_date_precision": releaseDatePrecisionValues.reverse[releaseDatePrecision],
        "total_tracks": totalTracks,
        "type": albumTypeEnumValues.reverse[type],
        "uri": uri,
    };
}

enum AlbumTypeEnum { ALBUM, SINGLE }

final albumTypeEnumValues = EnumValues({
    "album": AlbumTypeEnum.ALBUM,
    "single": AlbumTypeEnum.SINGLE
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
    Id id;
    Name name;
    ArtistType type;
    Uri uri;

    factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: idValues.map[json["id"]],
        name: nameValues.map[json["name"]],
        type: artistTypeValues.map[json["type"]],
        uri: uriValues.map[json["uri"]],
    );

    Map<String, dynamic> toJson() => {
        "external_urls": externalUrls.toJson(),
        "href": href,
        "id": idValues.reverse[id],
        "name": nameValues.reverse[name],
        "type": artistTypeValues.reverse[type],
        "uri": uriValues.reverse[uri],
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

enum Id { THE_12_CHZ98_P_HFMPJ_EKN_JQM_WV_I, THE_0_IQGJL0_OG3_Z53_PZVIB7_ZY_D, THE_780_A_IHE_X167_VEX_QSV_NKJQ_C }

final idValues = EnumValues({
    "0iqgjl0OG3z53PZVIB7ZyD": Id.THE_0_IQGJL0_OG3_Z53_PZVIB7_ZY_D,
    "12Chz98pHFMPJEknJQMWvI": Id.THE_12_CHZ98_P_HFMPJ_EKN_JQM_WV_I,
    "780aIheX167VexQSVNkjqC": Id.THE_780_A_IHE_X167_VEX_QSV_NKJQ_C
});

enum Name { MUSE, VKINGUR_LAFSSON, MUZER }

final nameValues = EnumValues({
    "Muse": Name.MUSE,
    "Muzer": Name.MUZER,
    "Víkingur Ólafsson": Name.VKINGUR_LAFSSON
});

enum ArtistType { ARTIST }

final artistTypeValues = EnumValues({
    "artist": ArtistType.ARTIST
});

enum Uri { SPOTIFY_ARTIST_12_CHZ98_P_HFMPJ_EKN_JQM_WV_I, SPOTIFY_ARTIST_0_IQGJL0_OG3_Z53_PZVIB7_ZY_D, SPOTIFY_ARTIST_780_A_IHE_X167_VEX_QSV_NKJQ_C }

final uriValues = EnumValues({
    "spotify:artist:0iqgjl0OG3z53PZVIB7ZyD": Uri.SPOTIFY_ARTIST_0_IQGJL0_OG3_Z53_PZVIB7_ZY_D,
    "spotify:artist:12Chz98pHFMPJEknJQMWvI": Uri.SPOTIFY_ARTIST_12_CHZ98_P_HFMPJ_EKN_JQM_WV_I,
    "spotify:artist:780aIheX167VexQSVNkjqC": Uri.SPOTIFY_ARTIST_780_A_IHE_X167_VEX_QSV_NKJQ_C
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

class ExternalIds {
    ExternalIds({
        this.isrc,
    });

    String isrc;

    factory ExternalIds.fromJson(Map<String, dynamic> json) => ExternalIds(
        isrc: json["isrc"],
    );

    Map<String, dynamic> toJson() => {
        "isrc": isrc,
    };
}

enum ItemType { TRACK }

final itemTypeValues = EnumValues({
    "track": ItemType.TRACK
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
