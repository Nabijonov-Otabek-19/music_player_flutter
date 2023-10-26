import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_player_simp/features/data/model/music_model.dart';

@immutable
class MusicList extends Equatable {
  final List<MusicModel>? music;

  const MusicList({required this.music});

  @override
  List<Object?> get props => [music];

  MusicList copyWith({List<MusicModel>? music}) {
    return MusicList(music: music ?? this.music);
  }

  Map<String, dynamic> toJson() {
    return {'music': music};
  }

  factory MusicList.fromJson(Map<String, dynamic> json) {
    return MusicList(
      music: (json['music'] as List<dynamic>?)
          ?.map((e) => MusicModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
