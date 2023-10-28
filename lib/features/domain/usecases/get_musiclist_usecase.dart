import 'package:dartz/dartz.dart';
import 'package:music_player_simp/core/error/failures.dart';
import 'package:music_player_simp/core/usecases/usecase.dart';
import 'package:music_player_simp/features/data/model/music_model.dart';
import 'package:music_player_simp/features/domain/repositories/music_repository.dart';

class GetMusicListUseCase implements UseCase<List<MusicModel>, NoParams> {
  final MusicRepository repository;

  GetMusicListUseCase(this.repository);

  @override
  Future<Either<Failure, List<MusicModel>>> call(NoParams params) {
    return repository.getMusicList();
  }
}
