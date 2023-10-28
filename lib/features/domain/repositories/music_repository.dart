import 'package:dartz/dartz.dart';
import 'package:music_player_simp/core/error/failures.dart';
import 'package:music_player_simp/features/data/model/music_model.dart';

abstract class MusicRepository {
  Future<Either<Failure, List<MusicModel>>> getMusicList();
}