part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial({
    @Default(Status.LOADING) Status status,
    @Default("") String error,
    @Default([]) List<MusicModel> musicList,
  }) = _Initial;
}
