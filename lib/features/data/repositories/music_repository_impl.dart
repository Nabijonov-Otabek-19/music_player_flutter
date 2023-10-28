import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:music_player_simp/core/error/failures.dart';
import 'package:music_player_simp/features/data/model/music_model.dart';
import 'package:music_player_simp/features/domain/repositories/music_repository.dart';

class MusicRepositoryImpl implements MusicRepository {
  final Dio dio;

  MusicRepositoryImpl({required this.dio});

  @override
  Future<Either<Failure, List<MusicModel>>> getMusicList() async {
    try {
      final response = await dio.get("catalog.json");
      final List<dynamic> model = response.data['music'];

      final musicList = model.map((e) => MusicModel.fromJson(e)).toList();

      return Right(musicList);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
