import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class MusicModel extends Equatable {
  final String? id;
  final String? title;
  final String? album;
  final String? artist;
  final String? genre;
  final String? source;
  final String? image;
  final int? trackNumber;
  final int? totalTrackCount;
  final int? duration;
  final String? site;

  const MusicModel({
    this.id,
    this.title,
    this.album,
    this.artist,
    this.genre,
    this.source,
    this.image,
    this.trackNumber,
    this.totalTrackCount,
    this.duration,
    this.site,
  });

  @override
  List<Object?> get props =>
      [
        id,
        title,
        album,
        artist,
        genre,
        source,
        image,
        trackNumber,
        totalTrackCount,
        duration,
        site
      ];

  MusicModel copyWith({
    String? id,
    String? title,
    String? album,
    String? artist,
    String? genre,
    String? source,
    String? image,
    int? trackNumber,
    int? totalTrackCount,
    int? duration,
    String? site,
  }) {
    return MusicModel(
      id: id ?? this.id,
      title: title ?? this.title,
      album: album ?? this.album,
      artist: artist ?? this.artist,
      genre: genre ?? this.genre,
      source: source ?? this.source,
      image: image ?? this.image,
      trackNumber: trackNumber ?? this.trackNumber,
      totalTrackCount: totalTrackCount ?? this.totalTrackCount,
      duration: duration ?? this.duration,
      site: site ?? this.site,
    );
  }

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      album: json['album'] ?? "",
      artist: json['artist'] ?? "",
      genre: json['genre'] ?? "",
      source: json['source'] ?? "",
      image: json['image'] ?? "",
      trackNumber: json['trackNumber'] ?? 0,
      totalTrackCount: json['totalTrackCount'] ?? 0,
      duration: json['duration'] ?? 0,
      site: json['site'] ?? "",
    );
  }
}
