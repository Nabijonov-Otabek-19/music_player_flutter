import 'package:get_it/get_it.dart';
import 'package:music_player_simp/features/data/repositories/music_repository_impl.dart';
import 'package:music_player_simp/features/domain/repositories/music_repository.dart';
import 'package:music_player_simp/features/domain/usecases/get_musiclist_usecase.dart';
import 'package:music_player_simp/features/presentation/pages/home/bloc/home_bloc.dart';
import 'package:music_player_simp/features/presentation/pages/play/bloc/play_bloc.dart';

import 'core/network/base_api.dart';

GetIt di = GetIt.instance;

Future<void> init() async {
  // BaseApi (Dio)
  di.registerLazySingleton<BaseApi>(() => BaseApi());

  // Bloc
  di.registerFactory(() => HomeBloc(getMusicListUseCase: di()));
  di.registerFactory(() => PlayBloc());

  // Use cases
  di.registerLazySingleton(() => GetMusicListUseCase(di()));

  // Repositories
  di.registerLazySingleton<MusicRepositoryImpl>(
      () => MusicRepositoryImpl(dio: di.get<BaseApi>().dio));

  // abstract -> impl
  di.registerSingleton<MusicRepository>(
      MusicRepositoryImpl(dio: di.get<BaseApi>().dio));
}
