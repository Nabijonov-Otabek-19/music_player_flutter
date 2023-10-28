import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'playlist_event.dart';

part 'playlist_state.dart';

part 'playlist_bloc.freezed.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  PlaylistBloc() : super(const PlaylistState.initial()) {
    on<PlaylistEvent>((event, emit) async {
      switch (event) {
        //
      }
    });
  }
}
