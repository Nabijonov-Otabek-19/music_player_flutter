import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_player_simp/features/data/model/music_model.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_call_handle.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../domain/usecases/get_musiclist_usecase.dart';

part 'home_event.dart';

part 'home_state.dart';

part 'home_bloc.freezed.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMusicListUseCase getMusicListUseCase;

  HomeBloc({required this.getMusicListUseCase})
      : super(const HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      switch (event) {
        case _GetMusicList():
          final failureOrSuccess = await getMusicListUseCase(NoParams());
          _eitherLoadedOrErrorState(emit, state, failureOrSuccess);
          break;
      }
    });
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Aniqlanmagan Xatolik';
    }
  }

  void _eitherLoadedOrErrorState(
    Emitter<HomeState> emit,
    HomeState state,
    Either<Failure, List<MusicModel>> failureOrSuccess,
  ) async {
    emit(state.copyWith(status: Status.LOADING));

    failureOrSuccess.fold(
        (failure) async => emit(state.copyWith(
              status: Status.ERROR,
              error: _mapFailureMessage(failure),
            )),
        (success) => emit(
              state.copyWith(
                status: Status.COMPLETED,
                musicList: success,
              ),
            ));
  }
}
